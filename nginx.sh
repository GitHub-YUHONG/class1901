#! /usr/bin/env bash 

#author : YUHONG
#date : 2019/08/02
#usage : auto install LNMP

cat <<-EOT >/etc/yum.repo.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
EOT

yum -y install nginx mariadb-server mariadb php php-gd php-mcrypt php-mbstring php-devel php-mysql php-xml php-fpm

systemctl start nginx mariadb php-fpm
systemctl enable nginx mariadb php-fpm

cat <<-EOT >/etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name  www.pycompute.com;

    charset koi8-r;
    access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.php index.html index.htm;
    }

    error_page   404              /404.html;
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    location ~ \.php\$ {
        root           /usr/share/nginx/html;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  /usr/share/nginx/html/\$fastcgi_script_name;
        include        fastcgi_params;
    }
}
EOT
mysql -uroot -e "create database lnmp;"
mysql -uroot -e "grant privileges on lnmp.* to 'bavder'@'localhost' identified by '123456';"
cat <<-EOT >/usr/share/nginx/html/index.php
<?php
\$link = mysql_connect('localhost', 'bavduer', '123456');
if (!\$link) {
    die('Could not connect: ' . mysql_error());
}
echo 'Connected successfully';
mysql_close(\$link);
?>
EOT
systemctl restart nginx && systemctl enable nginx
systemctl stop firewalld && setenforce 0

