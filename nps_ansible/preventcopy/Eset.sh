#!/bin/bash
host=$1
ansible $host -m win_copy -a 'src=/root/ansible_playbooks/preventcopy/efs_v45_64.sfx.exe dest=C:\soft\'
ansible $host -m win_command -a "C:\soft\efs_v45_64.sfx.exe" 
exit 0
