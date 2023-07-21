#!/usr/bin/env bash
# adapted from https://github.com/microsoft/vscode-dev-containers/blob/master/containers/php/.devcontainer/library-scripts/common-debian.sh

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y \
    bzip2 \
    ca-certificates \
    curl \
    dialog \
    dnsutils \
    fd-find \
    git  \
    gnupg2 \
    htop \
    iproute2 \
    jq \
    less \
    libasound2 \
    libbz2-1.0 \
    libbz2-dev \
    libc6 \
    libgbm-dev \
    libgcc1 \
    libgconf-2-4 \
    libgssapi-krb5-2 \
    libgtk-3-0 \
    libicu-dev \
    libicu[0-9][0-9] \
    libkrb5-3 \
    liblttng-ust0 \
    libnotify-dev \
    libnss3 \
    libstdc++6 \
    libxss1 \
    libxtst6 \
    libzip-dev \
    locales \
    lsb-release \
    lsof \
    man-db \
    mariadb-client \
    nano\
    ncdu \
    net-tools \
    openssh-client \
    procps \
    psmisc \
    ripgrep \
    rsync \
    strace \
    sudo \
    telnet \
    unzip \
    vim \
    wget \
    xauth \
    xvfb \
    zip \
    zlib1g \
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

rm -rf /var/lib/apt/lists/*
