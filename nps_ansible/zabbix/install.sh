#!/bash/bin
APP_NAME=$1
ansible root -m copy -a "src=/root/ansible_playbooks/zabbix/zabbix-4.0.3.tar.gz dest=/root"
ansible root -m copy -a "src=/root/ansible_playbooks/zabbix/zabbix_install.sh dest=/root"
ansible root -m shell -a "sh /root/zabbix_install.sh"
