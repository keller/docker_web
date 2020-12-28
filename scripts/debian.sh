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
    libc6 \
    libgcc1 \
    libkrb5-3 \
    libgssapi-krb5-2 \
    libicu[0-9][0-9] \
    liblttng-ust0 \
    libstdc++6 \
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

# code shim, it fallbacks to code-insiders if code is not available
cat << 'EOF' > /usr/local/bin/code
#!/bin/sh
get_in_path_except_current() {
  which -a "$1" | grep -v "$0" | head -1
}
code="$(get_in_path_except_current code)"
if [ -n "$code" ]; then
  exec "$code" "$@"
elif [ "$(command -v code-insiders)" ]; then
  exec code-insiders "$@"
else
  echo "code or code-insiders is not installed" >&2
  exit 127
fi
EOF
chmod +x /usr/local/bin/code

# oh-my-zsh
CODESPACES_ZSH="$(cat \
<<EOF
prompt() {
    if [ ! -z "\${GITHUB_USER}" ]; then
        local USERNAME="@\${GITHUB_USER}"
    else
        local USERNAME="%n"
    fi
    PROMPT="%{\$fg[green]%}\${USERNAME} %(?:%{\$reset_color%}➜ :%{\$fg_bold[red]%}➜ )"
    PROMPT+='%{\$fg_bold[blue]%}%~%{\$reset_color%} \$(git_prompt_info)%{\$fg[white]%}$ %{\$reset_color%}'
}
ZSH_THEME_GIT_PROMPT_PREFIX="%{\$fg_bold[cyan]%}(%{\$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{\$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{\$fg_bold[yellow]%}✗%{\$fg_bold[cyan]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{\$fg_bold[cyan]%})"
prompt
EOF
)"

# Adapted Oh My Zsh! install step to work with both "Oh Mys" rather than relying on an installer script
# See https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh for offical script.

umask g-w,o-w
mkdir -p /root/.oh-my-zsh
git clone --depth=1 \
    -c core.eol=lf \
    -c core.autocrlf=false \
    -c fsck.zeroPaddedFilemode=ignore \
    -c fetch.fsck.zeroPaddedFilemode=ignore \
    -c receive.fsck.zeroPaddedFilemode=ignore \
    https://github.com/ohmyzsh/ohmyzsh /root/.oh-my-zsh 2>&1
echo -e "$(cat "/root/.oh-my-zsh/templates/zshrc.zsh-template")\nDISABLE_AUTO_UPDATE=true\nDISABLE_UPDATE_PROMPT=true" > /root/.zshrc

sed -i -e 's/ZSH_THEME=.*/ZSH_THEME="codespaces"/g' /root/.zshrc
mkdir -p /root/.oh-my-zsh/custom/themes
echo "${CODESPACES_ZSH}" > /root/.oh-my-zsh/custom/themes/codespaces.zsh-theme

# Shrink git while still enabling updates
cd /root/.oh-my-zsh
git repack -a -d -f --depth=1 --window=1
