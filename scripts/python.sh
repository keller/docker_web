#!/usr/bin/env bash

PYTHON_DIR=${1}
PYTHON_VERSION=${2}

git clone git://github.com/pyenv/pyenv.git
PREFIX=/usr/local ./pyenv/plugins/python-build/install.sh
rm -rf ./pyenv

python-build $PYTHON_VERSION $PYTHON_DIR/v$PYTHON_VERSION

pip install ansible==4.10.0 passlib aws-inventory PyYAML boto3 python-dynamodb-lock
