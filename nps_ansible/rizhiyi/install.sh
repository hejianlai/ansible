#!/bash/bin
APP_NAME=$1
#ansible ${APP_NAME} -m copy -a "src=/root/ansible_playbooks/rizhiyi/heka-2_2_0.13-linux-amd64.tar.gz dest=/fs01"
ansible ${APP_NAME} -m copy -a "src=/root/ansible_playbooks/rizhiyi/rizhiyi_install.sh dest=/fs01"
ansible ${APP_NAME} -m shell -a "sh /fs01/rizhiyi_install.sh"
