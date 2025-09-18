#!/bin/bash

HTML_FOLDER="/var/www/html"

mkdir -p $HTML_FOLDER

sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/" /etc/php/7.4/fpm/pool.d/www.conf
cd $HTML_FOLDER
sleep 10

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root
wp config create --dbname=$DATABASE_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --allow-root
wp core install --url=$DOMAINE_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_email=$WP_ADMIN_EMAIL --admin_password=$WP_ADMIN_PASSWORD --skip-email --allow-root
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root

wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST "'$REDIS_HOST'" --raw --allow-root
wp config set WP_REDIS_PORT $REDIS_PORT --raw --allow-root
wp redis enable --allow-root

exec $@