FROM php:8.0.0-apache-buster

ARG NODE_VERSION="14.15.3"
ENV NODE_VERSION $NODE_VERSION

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y \
    bzip2 \
    git-core  \
    libbz2-1.0 \
    libbz2-dev \
    locales \
    mariadb-client \
    nano\
    vim \
    wget \
    zlib1g-dev \
    zsh \
    && locale-gen en_US.UTF-8

RUN docker-php-ext-install bz2 calendar exif gettext mysqli pdo pdo_mysql

RUN yes | pecl install xdebug memcache-8.0

RUN a2enmod rewrite headers expires

# install nvm and node
ENV NVM_DIR /usr/local/nvm
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
RUN bash -c 'source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default'

COPY ./conf.d/* /usr/local/etc/php/conf.d/
COPY ./dotfiles/* /root/
COPY info.php /var/www/html/index.php

ENV TERM xterm-256color



