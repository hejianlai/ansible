#!/bin/bash
host=$1
#ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/start.bat dest=C:\soft\PreventCopy\start.bat'
ansible $host -m win_command -a "chdir=C:\soft\PreventCopy stop.bat" 
ansible $host -m win_shell -a "chdir=C:\soft\PreventCopy start.bat" 
exit 0
