#!/bin/bash

mkdir -p /var/run/php
mkdir -p /run/php /var/www/html/adminer

wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer/adminer.php
wget "https://raw.githubusercontent.com/Niyko/Hydra-Dark-Theme-for-Adminer/master/adminer.css" -O /var/www/html/adminer/adminer.css

sed -i 's/^listen = .*/listen = 8080/' /etc/php/7.4/fpm/pool.d/www.conf

/usr/sbin/php-fpm7.4 -F