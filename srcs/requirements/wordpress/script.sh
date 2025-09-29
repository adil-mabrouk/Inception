#!/bin/bash

HTML_FOLDER="/var/www/html"

sleep 10
# Function to check if command succeeded
check_command() {
    if [ $? -eq 0 ]; then
        echo "SUCCESS: $1"
        return 0
    else
        echo "$1 failed"
        return 1
    fi
}

echo "Starting WordPress setup..."

mkdir -p $HTML_FOLDER
echo "Created HTML folder: $HTML_FOLDER"

sed -i "s/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/" /etc/php/8.2/fpm/pool.d/www.conf
check_command "PHP-FPM configuration"

cd $HTML_FOLDER

if [ ! -f "/usr/local/bin/wp" ]; then
    echo "Installing WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    check_command "WP-CLI download"
    
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    check_command "WP-CLI installation"
else
    echo "WP-CLI already installed, skipping download"
fi

if [ ! -f "wp-load.php" ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root
    check_command "WordPress core download"
else
    echo "WordPress core files already present, skipping download"
fi

if [ ! -f "wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname=$DATABASE_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=$DB_HOST \
        --allow-root
    
    if check_command "wp-config.php creation"; then
        echo "wp-config.php created successfully"
    else
        echo "Failed to create wp-config.php, exiting"
        exit 1
    fi
else
    echo "wp-config.php already exists, skipping creation"
fi

if wp core is-installed --allow-root 2>/dev/null; then
    echo "WordPress is already installed, skipping core installation"
else
    echo "Installing WordPress..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --skip-email \
        --allow-root
    
    if check_command "WordPress installation"; then
        echo "WordPress installed successfully"
    else
        echo "WordPress installation failed"
        exit 1
    fi
fi

if [ -n "$WP_USER" ] && [ -n "$WP_EMAIL" ] && [ -n "$WP_PASSWORD" ]; then
    if wp user get "$WP_USER" --allow-root > /dev/null 2>&1; then
        echo "User '$WP_USER' already exists, skipping creation"
    else
        echo "Creating user '$WP_USER'..."
        wp user create "$WP_USER" "$WP_EMAIL" \
            --role=author \
            --user_pass="$WP_PASSWORD" \
            --allow-root
        
        if check_command "User '$WP_USER' creation"; then
            echo "User '$WP_USER' created successfully"
        else
            echo "Failed to create user '$WP_USER', but continuing..."
        fi
    fi
else
    echo "Additional user variables not set or incomplete, skipping user creation"
fi

if wp core is-installed --allow-root; then
    echo "WordPress setup completed successfully!"
    echo "Site URL: $DOMAIN_NAME"
    echo "Admin user: $WP_ADMIN_USER"
    echo "WordPress version: $(wp core version --allow-root)"
    echo "Active theme: $(wp theme list --status=active --field=name --allow-root)"
else
    echo "WordPress installation verification failed"
    exit 1
fi
echo "Starting PHP-FPM..."

wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST "'$WP_REDIS_HOST'" --raw --allow-root
wp config set WP_REDIS_PORT $WP_REDIS_PORT --raw --allow-root
wp redis enable --allow-root

exec "$@"