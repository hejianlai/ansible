#!/bash/bin
APP_NAME=$1
JAR_DIR=/root/ansible_playbooks/nps-tpp/tpp-${APP_NAME}.jar
DEST_DIR=/fs01/nps-tpp/tpp-${APP_NAME}
ansible nps-tpp -m copy -a "src=${JAR_DIR} dest=${DEST_DIR}"
ansible nps-tpp -m shell -a "sh /appupgrade/nps-tpp.sh ${APP_NAME}"
