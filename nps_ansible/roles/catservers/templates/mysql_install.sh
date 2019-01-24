#!/bin/bash
INSTALL_DIR={{install_dir}}
MYSQL_PACKAGE={{mysql_package}}
MYSQL_VERSION={{mysql_version}}
MYSQLDATA_DIR={{mysqldata_dir}}
CMAKE_VERSION={{cmake_version}}
SOURCE_DIR={{source_dir}}
source /etc/init.d/functions
PASSWD="npsdb@2018"
mkdir -p ${INSTALL_DIR}                 
mkdir -p ${MYSQLDATA_DIR}/{3306/{data,tmp,binlog},backup,scripts} 
groupadd  mysql
useradd  -g  mysql  mysql
chown -R mysql:mysql ${MYSQLDATA_DIR}
chmod -R 775 ${MYSQLDATA_DIR}
cat <<EOF >>/etc/security/limits.conf
mysql soft nproc 2047
mysql hard nproc 16384
mysql soft nofile 1024
mysql hard nofile 65535
EOF
echo "export PATH=${INSTALL_DIR}/bin:$PATH" >>/etc/profile
source /etc/profile
yum install gcc gcc-c++ ncurses-devel bison-devel -y &>/dev/null
cd ${SOURCE_DIR}
tar -xf ${CMAKE_VERSION}.tar.gz
cd ${CMAKE_VERSION}
./configure --prefix=${INSTALL_DIR}
make && make install
cd ${SOURCE_DIR}
tar -xf ${MYSQL_PACKAGE}.tar.gz
cd ${MYSQL_VERSION}
cmake . -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
-DDEFAULT_CHARSET=UTF8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DENABLED_LOCAL_INFILE=ON \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITHOUT_EXAMPLE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_PERFSCHEMA_STORAGE_ENGINE=1 \
-DCOMPILATION_COMMENT='npsmysql' \
-DWITH_READLINE=ON \
-DSYSCONFDIR=${MYSQLDATA_DIR}/3306 \
-DWITH_BOOST=${SOURCE_DIR}/mysql-5.7.24/boost \
-DMYSQL_UNIX_ADDR=${MYSQLDATA_DIR}/3306/mysql.sock
make && make install
chown -R  mysql:mysql  ${INSTALL_DIR}
chmod -R 775 ${INSTALL_DIR}
echo "export PATH=${INSTALL_DIR}/bin:$PATH" >>/home/mysql/.bash_profile
source /home/mysql/.bash_profile  
cd ${MYSQLDATA_DIR}/3306/
cat <<EOF >${MYSQLDATA_DIR}/3306/my.cnf
#The MySQL client
[client]
port=3306
socket=${MYSQLDATA_DIR}/3306/mysql.sock
#default-charcter-set=utf8

#The MySQL server
[mysqld]
port=3306
user=mysql
socket=${MYSQLDATA_DIR}/3306/mysql.sock
pid-file=${MYSQLDATA_DIR}/3306/mysql.pid
basedir=${INSTALL_DIR}
datadir=${MYSQLDATA_DIR}/3306/data
tmpdir=${MYSQLDATA_DIR}/3306/tmp
open_files_limit=10240
explicit_defaults_for_timestamp

#Buffer
max_allowed_packet=256M
max_heap_table_size=256M
net_buffer_length=8K
sort_buffer_size=2M
join_buffer_size=4M
read_buffer_size=2M
read_rnd_buffer_size=16M

#Log
log-bin=${MYSQLDATA_DIR}/3306/binlog/mysql-bin
binlog_cache_size=32M
max_binlog_cache_size=512M
max_binlog_size=512M
binlog_format=mixed
log_output=FILE
log-error=../mysql-error.log
slow_query_log=1
slow_query_log_file=../slow_query.log
general_log=0
general_log_file=../general_query.log
expire-logs-days=14

#InnoDB
innodb_data_file_path=ibdata1:2048M:autoextend
innodb_log_file_size=256M
innodb_log_files_in_group=3
innodb_buffer_pool_size=1024M
character-set-server=utf8

#sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

server-id=1
max_connections=1000
wait_timeout=30
interactive_timeout = 30
lower_case_table_names=1


[mysql]
no-auto-rehash
prompt=(\u@\h) [\d]>\_
#default-character-set=utf8
#character_set_server=utf8
EOF
chown -R  mysql:mysql  my.cnf
chmod -R 775 my.cnf
rm -fr ${MYSQLDATA_DIR}/3306/data/*
cd ${INSTALL_DIR}
#bin/mysqld --initialize --defaults-file=${MYSQLDATA_DIR}/3306/my.cnf 
bin/mysqld --initialize --user=mysql --basedir=${INSTALL_DIR} --datadir=${MYSQLDATA_DIR}/3306/data
rm -fr /etc/my.cnf 
#mysqld_safe --defaults-file=${MYSQLDATA_DIR}/3306/my.cnf &
cp ${INSTALL_DIR}/support-files/mysql.server /etc/init.d/mysql
chkconfig mysql on
service mysql start  
DEFAULT_PASSD=`grep generated ${MYSQLDATA_DIR}/3306/mysql-error.log |awk '{print $NF}'`

mysql -uroot -p${DEFAULT_PASSD} --connect-expired-password  <<EOF
alter user 'root'@'localhost' identified by   '${DB_PASSWD}';
flush privileges;
exit;
EOF

mysql -uroot -p${DB_PASSWD} --connect-expired-password  <<EOF
use mysql; 
update user set host='%' where host='localhost';
flush privileges;
EOF
source /etc/profile
