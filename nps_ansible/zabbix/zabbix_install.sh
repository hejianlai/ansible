#!/bash/sh
groupadd zabbix
useradd -g zabbix zabbix
yum install -y gcc* pcre*
tar -xf zabbix-4.0.3.tar.gz
cd zabbix-4.0.3
./configure --enable-agent
 make install
sed -i 's/127.0.0.1/10.90.6.86/g' /usr/local/etc/zabbix_agentd.conf
/usr/local/sbin/zabbix_agentd
