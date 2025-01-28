#!/bin/bash

# Exit immediately if a command returns a non-zero exit code
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

	echo "Installing Wordpress..."
	wp core install \
		--url="${WP_DOMAIN}" \
   	 	--title="INCEPTION" \
   		--admin_user="${WP_ADMIN}" \
   		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_MAIL}" \
		--allow-root

	echo "Creating new user in the database..."
	wp user create "${WP_USER}" "${WP_USER_MAIL}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--role=editor \
		--allow-root
	
else
	echo "wp-config.php already exists, skipping configuration."
fi

echo "Starting PHP-FPM..."
exec "$@"