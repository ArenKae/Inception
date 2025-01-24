#!/bin/bash

mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

mysqld_safe &

sleep 10

mariadb -u root <<EOF
CREATE DATABASE $SQL_DATABASE;
CREATE USER $SQL_USER@'%' IDENTIFIED BY '$SQL_PASSWORD';
GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO $SQL_USER@'%';
FLUSH PRIVILEGES;
EOF

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

mysqld_safe