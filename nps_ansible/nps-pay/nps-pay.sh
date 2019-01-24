#!/bin/bash
export JAVA_HOME=/usr/java/jdk1.8.0_144
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
APP_NAME=$1
BUCKUP_DIR=/fs01/backup/nps-pay/acc-${APP_NAME}/$(date +%Y%m%d%H%M)
APP_DIR=/fs01/nps-pay
LOG_DIR=/AppFile/log/acc-${APP_NAME}/debug.log
FILE=acc-${APP_NAME}.jar
[ -z ${BUCKUP_DIR} ] || /bin/mkdir -p ${BUCKUP_DIR}
cp -r ${APP_DIR}/acc-${APP_NAME} ${BUCKUP_DIR}
ps aux|grep acc-${APP_NAME}|grep -v grep |awk '{print $2}'|xargs kill 
sleep 15
cd ${APP_DIR}/acc-${APP_NAME}
rm -fr ${APP_DIR}/acc-${APP_NAME}/application.pid
rm -fr ${APP_DIR}/acc-${APP_NAME}/BOOT-INF/lib/
cd ${APP_DIR}/acc-${APP_NAME}/BOOT-INF/classes/
configFile(){
        if [ -f "paylink.properties" ]; then
                mv paylink.properties ../
        fi
        mv bootstrap.yml ../

        cd ${APP_DIR}/acc-${APP_NAME}
        jar -xf ${APP_DIR}/acc-${APP_NAME}/${FILE}

        cd ${APP_DIR}/acc-${APP_NAME}/BOOT-INF/classes/
        if [ -f "paylink.properties" ]; then
                mv ../paylink.properties ./
        fi
        mv ../bootstrap.yml ./
        ${APP_DIR}/acc-${APP_NAME}/start.sh 2
}
configFile
