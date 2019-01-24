#!/bin/bash
read -p "请输入更新的配置文件名:" file
read -p "请输入更新的配置文件存放路径:" dir
for ip in `cat ./ip_web.txt`
do
scp -r ./${file} tomcat8@${ip}:${dir}
done
