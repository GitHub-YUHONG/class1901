#! /usr/bin/env bash

#encoding:utf8
#author:yuhong
#date:2019/07/30


systemctl stop firewalld && systemctl disable firewalld
sed -ri s/SELINUX=encorfing/SELINUX=disabled/g /etc/selinux/config
setenforce 0

echo "* * */7 * * bash /tasks/netSync.sh" >> /var/spool/cron/$(whoami)
cat <<-EOT >/tasks/ntpSync.sh
#! /usr/bin/env bash

# encoding:utf8
# author:yuhong
# date:@ 2019/07/30


if [ ! -f /usr/bin/ntpdate ];then
	yum -y install ntpdate
	ntpdate -b ntp1.aliyun.com &
else
	ntpdate -b ntp1.aliyun.com &
fi
EOT

echo "export HISTSIZE=10000" >> /etc/profile
echo "export HISTTIMEPROMAT=\"%Y-%m-%d_%H:%M:%S -\" " >> /etc/profile
source /etc/profile

chattr +ai /etc/passwd /etc/shadow /etc/group

yum -y install vim bash-completion net-tools

if [ $? == 0 ];then
	exit 0
else
	exit 12345
fi
