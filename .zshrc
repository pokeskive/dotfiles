export SHELL_SESSIONS_DISABLE=1

# Change prompt
setopt PROMPT_SUBST
PROMPT='%B%F{#849900}%~%b ❯%f '

# Set color for directories
export CLICOLOR=1
export LSCOLORS=gafacadabaegedabagacad

# Check my IP alias
alias myip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"

# Utilities
alias c="clear"
alias ll="ls -lah"
alias bare="git --git-dir=$HOME/Developer/.dotfiles/ --work-tree=$HOME"
