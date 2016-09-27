# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="timcheadle"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(aws brew bundler gem git git-flow github pow ssh-agent tmuxinator)

# SSH Agent
zstyle :omz:plugins:ssh-agent identities id_rsa

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=/usr/local/share/npm/bin:$PATH
PATH=/usr/local/bin:$PATH
PATH=~/Applications:$PATH
PATH=~/.themekit:$PATH
PATH=~/.bin:$PATH
export PATH

# Turn off shared history
setopt nosharehistory

# LS colors
export LSCOLORS=exfxcxdxbxegedabagacad

# Editor
export EDITOR=vim

# Vim
alias vins='vim -c "syntax off"'

# rbenv (oh-my-zsh plugin is fucked right now)
eval "$(rbenv init - zsh)"

# Rails
alias bx='bundle exec'
alias migrate='rake db:migrate db:migrate:redo db:test:prepare'
alias db_fuck_you='rake db:drop db:create db:migrate db:seed db:test:prepare'
alias rspec='rspec --color'

# Git
alias gs='git status'
alias gd='git diff --color'
alias gpl='git pull --rebase'

# Import any host-specific config
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
