#!/bin/bash

# Step 1: Verify and create /run/mysqld if it doesn't exist
if [ ! -d /run/mysqld ]; then
    echo \"Creating /run/mysqld directory...\"
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

# Step 2: Verify and initialize the database directory if it doesn't exist
if [ ! -d /var/lib/mysql/mysql ]; then
    echo \"Initializing MariaDB database...\"
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    echo \"Running mysql_secure_installation...\"
    mysql_secure_installation <<EOF

y
password123
password123
y
y
y
y
EOF
fi

# Step 3: Modify the mariadb-server.cnf file
CONF_FILE=\"/etc/mysql/mariadb.conf.d/50-server.cnf\"
if [ -f \"$CONF_FILE\" ]; then
    echo \"Configuring MariaDB server...\"
    sed -i '/^skip-networking/s/^/#/' $CONF_FILE
    sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' $CONF_FILE
fi

# Step 4: Launch MariaDB in console mode
echo \"Starting MariaDB...\"
exec mysqld_safe --console

