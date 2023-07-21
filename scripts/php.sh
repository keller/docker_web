#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

docker-php-ext-install bz2 calendar exif gettext intl mysqli pdo pdo_mysql zip

yes | pecl install xdebug memcache-8.0

# Install composer
curl -sSL https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer

# composer global require "phpunit/phpunit=4.8.*"
composer global require --dev phpunit/phpunit ^10
echo 'export PATH="$PATH:/root/.config/composer/vendor/bin"' >> ~/.zshrc
echo 'export PATH="$PATH:/root/.config/composer/vendor/bin"' >> ~/.bashrc
