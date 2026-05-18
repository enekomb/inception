#!/bin/bash
set -x

until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for database..."
    sleep 2
done


if ! [ -e "/var/www/html/wp-config.php" ] ; then
    wp core download --path=/var/www/html --locale=en_US --allow-root

    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/html'

    wp core install \
        --url="tauer.42.fr" \
        --title="OMELETTE DE FROMAGE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --path='/var/www/html' \
        --allow-root
	wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" \
        --user_pass="$WORDPRESS_USER_PASSWORD" \
        --path='/var/www/html' \
        --allow-root
fi
mkdir -p /run/php/
exec php-fpm7.4 --nodaemonize
