#!/bash/bin
APP_NAME=$1
JAR_DIR=/root/ansible_playbooks/nps-pay/acc-${APP_NAME}.jar
DEST_DIR=/fs01/nps-pay/acc-${APP_NAME}
ansible nps-pay -m copy -a "src=${JAR_DIR} dest=${DEST_DIR}"
ansible nps-pay -m shell -a "sh /appupgrade/nps-pay.sh ${APP_NAME}"
