#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

NODE_DIR=${1}
NODE_VERSION=${2}

mkdir node-build && curl --silent -L https://github.com/nodenv/node-build/archive/refs/tags/v4.9.33.tar.gz | tar xz -C node-build --strip-components 1
PREFIX=/usr/local ./node-build/install.sh
rm -rf ~/node-build
node-build $NODE_VERSION $NODE_DIR/v$NODE_VERSION

npm install --global yarn@1.22.10
