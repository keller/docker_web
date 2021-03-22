FROM php:8.0.3-apache-buster

ARG NODE_VERSION="14.15.3"
ENV NODE_VERSION $NODE_VERSION

COPY ./scripts/* /tmp/scripts/
COPY info.php /var/www/html/index.php
COPY ./scripts/* /tmp/scripts/

# debian env setup
RUN bash /tmp/scripts/debian.sh

# PHP env setup
RUN bash /tmp/scripts/php.sh
COPY ./conf.d/* /usr/local/etc/php/conf.d/

# install nvm and node
ENV NODE_DIR /usr/local/node
ENV NODE_PATH $NODE_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NODE_DIR/v$NODE_VERSION/bin:$PATH

RUN bash /tmp/scripts/node.sh "${NODE_DIR}" "${NODE_VERSION}"

ENV TERM xterm-256color
