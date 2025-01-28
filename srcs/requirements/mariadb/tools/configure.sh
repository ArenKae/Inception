#!/bin/bash

service mariadb start

# Wait until MariaDB is available (e.g., by pinging the server)
echo "Waiting for MariaDB to start..."
until mysqladmin ping -u root --silent 2>/dev/null; do
  sleep 1
done
echo "MariaDB is up and running."

# Sets up the database, user accounts, and privileges.
mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;
CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';
GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';
GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO 'root'@'%' IDENTIFIED BY '$SQL_ROOT_PASSWORD';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$SQL_ROOT_PASSWORD');
FLUSH PRIVILEGES;
EOF

service mariadb stop

# Wait until MariaDB is actually stopped (check if the daemon is still running)
echo "Waiting for MariaDB to stop..."
while pidof mysqld >/dev/null 2>&1; do
  sleep 1
done
echo "MariaDB has stopped."

# Restart MariaDB in safe mode, ensuring automatic restart in case it crashes
mysqld_safe