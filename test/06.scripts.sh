#! /usr/bin/env bash

#encoding:utf8
#author:yuhong
#date:2019/07/30


if [ $1 == "-mv" ]; then
	mv $2 $2.bak
elif [ $1 == "-cp" ]; then
	cp $2 $2.bbak
fi
