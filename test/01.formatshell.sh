#! /usr/bin/env bash

#encoding:utf8
#author:yuhong
#date:2019/07/30


yum -y install vsftpd
if [ $? -eq 0];then ## -eq Be equal to 等于
	sudo rm -rf /var/ftp/* 
fi
systemctl start vsftpd && systemctl enable vsftpd
