#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

docker-php-ext-configure gd --enable-gd --with-jpeg
docker-php-ext-install bz2 calendar exif gettext intl mysqli pdo pdo_mysql zip gd

yes | pecl install xdebug memcache-8.0

printf "\n" | pecl install memcached-3.2.0

a2enmod rewrite headers expires

# Install composer
curl -sSL https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer
