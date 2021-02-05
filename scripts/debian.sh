#!/usr/bin/env bash
# adapted from https://github.com/microsoft/vscode-dev-containers/blob/master/containers/php/.devcontainer/library-scripts/common-debian.sh

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y \
    bzip2 \
    git  \
    mariadb-client \
    nano\
    vim \
    wget \
    openssh-client \
    gnupg2 \
    iproute2 \
    procps \
    lsof \
    htop \
    net-tools \
    psmisc \
    curl \
    rsync \
    ca-certificates \
    unzip \
    zip \
    less \
    jq \
    lsb-release \
    apt-transport-https \
    dialog \
    dnsutils \
    libc6 \
    libgcc1 \
    libkrb5-3 \
    libgssapi-krb5-2 \
    libicu[0-9][0-9] \
    libicu-dev \
    liblttng-ust0 \
    libstdc++6 \
    libzip-dev \
    zlib1g \
    libbz2-1.0 \
    libbz2-dev \
    locales \
    sudo \
    ncdu \
    man-db \
    strace \
    zlib1g-dev \
    zsh

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

cat << 'EOF' >> /root/.zshrc
autoload -U colors
colors
alias ls='ls --color=auto'
PROMPT="%F{6}%d%f %F{8}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%f"$'\n'"%F{5}❯%f "
export HISTFILE=~/.zsh_history
SAVEHIST=10000
EOF
