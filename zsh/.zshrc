# Load antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh

# Initialize completion system (needed for compdef)
autoload -Uz compinit
compinit

# Source plugins
source ~/.zsh_plugins.zsh

# Setup prompt
autoload -Uz promptinit && promptinit && prompt pure
zstyle :prompt:pure:path color '#4990FC'

# Git prompt customization
git_prompt_info() { :; }
POWERLEVEL9K_DISABLE_GITSTATUS=true

# enable reverse search
bindkey "^R" history-incremental-search-backward
HISTFILE=~/.zsh_history

# Autojump config
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Environment Variables
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

# Aliases
alias c='clear'
alias ll='ls -al'
alias la='ls -a'
alias ebash='vim ~/.zshrc'
