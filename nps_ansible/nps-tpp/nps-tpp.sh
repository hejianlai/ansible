#!/bin/bash
export JAVA_HOME=/usr/java/jdk1.8.0_144
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
APP_NAME=$1
BUCKUP_DIR=/fs01/backup/nps-tpp/tpp-${APP_NAME}/$(date +%Y%m%d%H%M)
APP_DIR=/fs01/nps-tpp
FILE=tpp-${APP_NAME}.jar
[ -z ${BUCKUP_DIR} ] || /bin/mkdir -p ${BUCKUP_DIR}
cd ${APP_DIR}/tpp-${APP_NAME}
cp -r ${APP_DIR}/tpp-${APP_NAME} ${BUCKUP_DIR}
ps aux|grep tpp-${APP_NAME}|grep -v grep |awk '{print $2}'|xargs kill 
sleep 15
rm -fr ${APP_DIR}/tpp-${APP_NAME}/application.pid
rm -fr ${APP_DIR}/tpp-${APP_NAME}/BOOT-INF/lib/
cd ${APP_DIR}/tpp-${APP_NAME}/BOOT-INF/classes/
acc(){
	/bin/mv  twhapi.properties application.yml ../
	cd ${APP_DIR}/tpp-${APP_NAME}
	/usr/java/jdk1.8.0_144/bin/jar -xf ${APP_DIR}/tpp-${APP_NAME}/${FILE}
	cd ${APP_DIR}/tpp-${APP_NAME}/BOOT-INF/classes/
	\/bin/mv  ../twhapi.properties ../application.yml ./
	cd ${APP_DIR}/tpp-${APP_NAME}/ && ./start.sh 2
} 
pay(){
	/bin/mv  twhapi.properties application.yml ../
	cd ${APP_DIR}/tpp-${APP_NAME}/BOOT-INF/classes/config
	mv nps_system.properties ../
	cd ${APP_DIR}/tpp-${APP_NAME}
	/usr/java/jdk1.8.0_144/bin/jar -xf ${APP_DIR}/tpp-${APP_NAME}/${FILE}
	cd ${APP_DIR}/tpp-${APP_NAME}/BOOT-INF/classes/
	\/bin/mv  ../twhapi.properties ../application.yml ./
	cd ${APP_DIR}/tpp-${APP_NAME}/BOOT-INF/classes/config
	mv ../nps_system.properties ./
	cd ${APP_DIR}/tpp-${APP_NAME}/ && ./start.sh 2
} 
quartz(){
        cd ${APP_DIR}/tpp-${APP_NAME}
        /usr/java/jdk1.8.0_144/bin/jar -xf ${APP_DIR}/tpp-${APP_NAME}/${FILE}
        cd ${APP_DIR}/tpp-${APP_NAME}/ && ./start.sh 2
}
zuul_pre(){
	cd /fs01/nps-tpp/tpp-zuul-pre/;bash start.sh 1
        cp tpp-zuul-pre.jar ${BUCKUP_DIR}

}
case ${APP_NAME} in
acc|api|webgate)
	acc
	;;
pay)
	pay
	;;
quartz)
	quartz
	;;
zuul-pre)
	zuul_pre
	;;
*)
	exit 0
	;;
esac
