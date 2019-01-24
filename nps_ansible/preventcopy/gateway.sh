#!/bin/bash
for ip in `cat ip_tpp.txt`
do
#ssh root@$ip sed -i 's/254/9/g' /etc/sysconfig/network-scripts/ifcfg-eth0
ssh root@$ip service network restart
done
