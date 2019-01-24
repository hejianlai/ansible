#!/bash/bin
host=$1
#ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/zabbix/zabbix_agentd.win.conf dest=C:\soft\zabbix_agents_3.2.0.win\conf\zabbix_agentd.win.conf'
#ansible $host -m win_service -a "name='Zabbix Agent' state=stopped" 
#ansible $host -m win_service -a "name='Zabbix Agent' state=started" 
ansible $host -m win_command -a "C:\soft\zabbix_agents_3.2.0.win\bin\win64\zabbix_agentd.exe -c C:\soft\zabbix_agents_3.2.0.win\conf\zabbix_agentd.win.conf -x"
#ansible $host -m win_command -a "C:\soft\zabbix_agents_3.2.0.win\bin\win64\zabbix_agentd.exe -c C:\soft\zabbix_agents_3.2.0.win\conf\zabbix_agentd.win.conf -d"
#ansible $host -m win_file -a 'path=C:\soft\zabbix_agents_3.2.0.win\ state=absent'
#ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/zabbix/zabbix_agents_3.2.0.win  dest=C:\soft\'
#ansible $host -m win_command -a "C:\soft\zabbix_agents_3.2.0.win\bin\win64\zabbix_agentd.exe -c C:\soft\zabbix_agents_3.2.0.win\conf\zabbix_agentd.win.conf -i"
#ansible $host -m win_command -a "C:\soft\zabbix_agents_3.2.0.win\bin\win64\zabbix_agentd.exe -c C:\soft\zabbix_agents_3.2.0.win\conf\zabbix_agentd.win.conf -s"
