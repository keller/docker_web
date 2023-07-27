FROM php:8.2.4-cli-bullseye

ARG NODE_VERSION="18.17.0"

ENV NODE_VERSION $NODE_VERSION
ENV NODE_DIR /usr/local/node
ENV NODE_PATH $NODE_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NODE_DIR/v$NODE_VERSION/bin:/root/.composer/vendor/bin:$PATH

COPY ./scripts/* /tmp/scripts/
COPY info.php /var/www/html/index.php
COPY ./scripts/* /tmp/scripts/

# debian env setup
RUN bash /tmp/scripts/debian.sh

# PHP env setup
RUN bash /tmp/scripts/php.sh
COPY ./conf.d/* /usr/local/etc/php/conf.d/

RUN bash /tmp/scripts/node.sh "${NODE_DIR}" "${NODE_VERSION}"

ENV TERM xterm-256color

WORKDIR /app
CMD ["bash", "-c", "trap : TERM INT; sleep infinity & wait"]
