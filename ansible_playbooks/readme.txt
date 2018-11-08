ansible通过playbook批量安装jdk+tomcat+redis+mysql

目录如下：软件包太大无法上传GitHub，请按照软件版本自行下载。

ansible_playbooks
├── roles
│ └── webservers
│     ├── files
│     │ ├── apache-tomcat-7.0.90.tar.gz
│     │ ├── cmake-3.7.1.tar.gz
│     │ ├── jdk-7u80-linux-x64.tar.gz
│     │ ├── my.cnf
│     │ ├── mysql-5.7.24
│     │ ├── mysql-5.7.24.tar.gz
│     │ ├── redis-5.0.0
│     │ └── redis-5.0.0.tar.gz
│     ├── handlers
│     │ └── mian.yml
│     ├── meta
│     ├── tasks
│     │ ├── copy_mysql_cnf.yml
│     │ ├── install_jdk.yml
│     │ ├── install_mysql.yml
│     │ ├── install_redis.yml
│     │ ├── install_tomcat.yml
│     │ └── main.yml
│     ├── templates
│     │ ├── mysql_install.sh
│     │ └── redis.conf.j2
│     └── vars
│         └── main.yml
└── webserver.yml
