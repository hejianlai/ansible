host=$1
#ansible $host -m win_command -a "chdir=C:\soft\PreventCopy stop.bat"
#ansible $host -m raw -a "mkdir C:\soft\tomcat"

#安装tomcat
ansible $host -m win_command -a "sc stop Tomcat"
ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/tomcat dest=C:\soft\'
ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/install.bat dest=C:\soft\'
ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/install_config.bat dest=C:\soft\'
ansible $host -m win_command -a "chdir=C:\soft install.bat" 
ansible $host -m win_command -a "chdir=C:\soft install_config.bat" 
#
##重启tomcat应用
ansible $host -m win_service -a "name=Tomcat state=restarted" 

#更新防重系统
#ansible $host -m win_command -a "chdir=C:\soft\PreventCopy stop.bat"
#ansible $host -m win_command -a "sc stop Tomcat"
#ansible $host -m win_file -a 'path=C:\soft\\tomcat\webapps\PreventCopy\ state=absent'
#ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/PreventCopy.war dest=C:\soft\\tomcat\webapps\PreventCopy.war'
#ansible $host -m win_command -a "sc start Tomcat"

#执行sql，先把SQL文件放到sql_import_bat修改sql_imp.bat文件指定sql文件
#ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/sql_import_bat dest=C:\soft\PreventCopy\'
#ansible $host -m win_command -a "chdir=C:\soft\PreventCopy\sql_import_bat sql_imp.bat" 
exit 0
