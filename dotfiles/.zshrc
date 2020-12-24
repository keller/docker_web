autoload -U colors
colors
alias ls='ls --color=auto'
PROMPT="%F{6}%d%f %F{8}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%f"$'\n'"%F{5}❯%f "
export HISTFILE=~/.zsh_history
SAVEHIST=10000
