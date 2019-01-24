#!/bash/bin
APP_NAME=$1
JAR_DIR=/root/ansible_playbooks/nps-web/web-${APP_NAME}.jar
DEST_DIR=/fs01/nps-web/web-${APP_NAME}
#ansible nps-web -m copy -a "src=${JAR_DIR} dest=${DEST_DIR} owner=tomcat8 mode=755"
ansible nps-web -m copy -a "src=${JAR_DIR} dest=${DEST_DIR}"
#ansible nps-web -m script -a "bash /root/ansible_playbooks/nps-web/nps-web.sh ${APP_NAME}"
ansible nps-web -m shell -a "sh /appupgrade/nps-web.sh ${APP_NAME}"
