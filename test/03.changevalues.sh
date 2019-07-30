#! /usr/bin/env bash

#encoding:utf8
#author:yuhong
#date:2019/07/30


var01='hello'
var02='word'
echo ${var01} ${var02}

var03=${var01}
var01=${var02}
var02=${var03}
echo ${var01} ${var02}

