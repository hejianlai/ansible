#!/bin/bash
#. /etc/rc.d/init.d/functions
export JAVA_HOME=/usr/java/jdk1.8.0_144
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
APP_NAME=$1
BUCKUP_DIR=/fs01/backup/nps-web/web-${APP_NAME}/$(date +%Y%m%d%H%M)
APP_DIR=/fs01/nps-web
FILE=web-${APP_NAME}.jar
[ -z ${BUCKUP_DIR} ] || /bin/mkdir -p ${BUCKUP_DIR}
cd ${APP_DIR}/web-${APP_NAME}
tar -cf ${BUCKUP_DIR}/web-${APP_NAME}.tar BOOT-INF/ META-INF/
ps aux|grep web-${APP_NAME}|grep -v grep |awk '{print $2}'|xargs kill -9
rm -fr ${APP_DIR}/web-${APP_NAME}/application.pid
rm -fr ${APP_DIR}/web-${APP_NAME}/BOOT-INF/lib/
cd ${APP_DIR}/web-${APP_NAME}/BOOT-INF/classes/
configFile(){
        if [ -f "application.yml" ]; then
                mv application.yml ../
        fi
        cd ${APP_DIR}/web-${APP_NAME}
        jar -xf ${APP_DIR}/web-${APP_NAME}/${FILE}
        cd ${APP_DIR}/web-${APP_NAME}/BOOT-INF/classes/
        if [ -f "application.yml" ]; then
                mv ../application.yml ./
	fi
        ${APP_DIR}/web-${APP_NAME}/start.sh 2
}
configFile
