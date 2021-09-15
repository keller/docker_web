#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

docker-php-ext-install bz2 calendar exif gettext intl mysqli pdo pdo_mysql zip

yes | pecl install xdebug memcache-4.0.5.2

a2enmod rewrite headers expires

# Install composer
curl -sSL https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer
