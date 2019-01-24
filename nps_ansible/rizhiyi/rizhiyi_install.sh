#!/bin/bash
ip=`ifconfig |grep Bcast|awk -F":" '{print $2}'|awk '{print $1}'`
tar -xf  /fs01/heka-2_2_0.13-linux-amd64.tar.gz -C /fs01
cd /fs01 
mv heka-2_2_0.13-linux-amd64 hekad
cd /fs01/hekad/bin
sh install.sh ${ip}:10001 10.90.6.183:8080 885f9d2a2b808a3947000b9616a4bc1c 10.90.6.183:5180
