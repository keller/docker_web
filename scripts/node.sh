#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

NVM_DIR=${1}
NODE_VERSION=${2}

curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash \
    && bash -c 'source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default'
