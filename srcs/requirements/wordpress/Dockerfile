FROM debian:bullseye

# Install required packages
RUN apt-get update -y && apt-get install -y \
    wget \
    php-fpm \
    php-mysql \
	default-mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up PHP-FPM
RUN mkdir -p /run/php && \
    sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/7.4/fpm/php-fpm.conf && \
    sed -i 's/listen = .*/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

# Download and configure WordPress
RUN wp core download --allow-root

# Copy the entrypoint script
COPY tools/wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh

# Expose PHP-FPM port
EXPOSE 9000

# Set the entrypoint
ENTRYPOINT ["wordpress.sh"]

# Start PHP-FPM
CMD ["php-fpm7.4"]