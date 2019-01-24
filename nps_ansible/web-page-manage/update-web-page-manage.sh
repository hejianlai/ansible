#!/bash/bin
APP_NAME=page-manage
HOST_NAME=nps-webmanage
JAR_DIR=/root/ansible_playbooks/nps-web/web-${APP_NAME}.jar
DEST_DIR=/fs01/nps-web/web-${APP_NAME}
ansible ${HOST_NAME} -m copy -a "src=${JAR_DIR} dest=${DEST_DIR}"
ansible ${HOST_NAME} -m shell -a "sh /appupgrade/nps-web-page-manage.sh"
ansible ${HOST_NAME} -m copy -a "src=/root/ansible_playbooks/nps-web/static dest=/fs01/nps-web/web-page-manage/BOOT-INF/classes"
ansible ${HOST_NAME} -m shell -a "sh /fs01/nps-web/web-page-manage/start.sh 2"
