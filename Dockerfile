FROM php:8.0.0-apache-buster

ARG NODE_VERSION="14.15.3"
ENV NODE_VERSION $NODE_VERSION

COPY ./conf.d/* /usr/local/etc/php/conf.d/
COPY ./scripts/* /tmp/scripts/
COPY info.php /var/www/html/index.php
COPY ./scripts/* /tmp/scripts/


RUN bash /tmp/scripts/debian.sh

RUN bash /tmp/scripts/php.sh

# install nvm and node
ENV NVM_DIR /usr/local/nvm
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN bash /tmp/scripts/node.sh "${NVM_DIR}" "${NODE_VERSION}"

ENV TERM xterm-256color
