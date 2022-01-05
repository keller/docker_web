FROM php:7.4.27-apache-bullseye

ARG NODE_VERSION="16.3.0"
ENV NODE_VERSION $NODE_VERSION

ARG PYTHON_VERSION="3.9.6"
ENV PYTHON_VERSION $PYTHON_VERSION

COPY ./scripts/* /tmp/scripts/
COPY info.php /var/www/html/index.php
COPY ./scripts/* /tmp/scripts/

# debian env setup
RUN bash /tmp/scripts/debian.sh

ENV NODE_DIR /usr/local/node
ENV NODE_PATH $NODE_DIR/v$NODE_VERSION/lib/node_modules
ENV PYTHON_DIR /usr/local/python
ENV PATH $NODE_DIR/v$NODE_VERSION/bin:$PYTHON_DIR/v$PYTHON_VERSION/bin:/root/.composer/vendor/bin:$PATH

# PHP env setup
RUN bash /tmp/scripts/php.sh
COPY ./conf.d/* /usr/local/etc/php/conf.d/

# node env setup
RUN bash /tmp/scripts/node.sh "${NODE_DIR}" "${NODE_VERSION}"

# python env setup
# RUN bash /tmp/scripts/python.sh "${PYTHON_DIR}" "${PYTHON_VERSION}"

ENV TERM xterm-256color
