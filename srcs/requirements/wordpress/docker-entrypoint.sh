#!/bin/bash

set -e

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysql -h mariadb -u"${SQL_USER}" -p"${SQL_PASSWORD}" -e "SELECT 1;" > /dev/null 2>&1; do
    echo "MariaDB is unavailable - retrying in 1 second..."
    sleep 1
done

echo "MariaDB is ready. Proceeding with WordPress setup..."

# Check if wp-config.php exists
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost=mariadb:3306 \
        --allow-root
	wp core install \
    	--url="https://localhost" \
   	 	--title="My WordPress Site" \
   		--admin_user="${WP_USER}" \
   		--admin_password="${WP_PASSWORD}" \
    	--admin_email="${WP_MAIL}" \
    	--allow-root
else
    echo "wp-config.php already exists, skipping configuration."
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec "$@"