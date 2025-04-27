# Load Antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh

# Initialize completion system
autoload -Uz compinit
compinit -C

# Compile plugins if missing
if [[ ! -f ~/.zsh_plugins.zsh.zwc ]]; then
  zcompile ~/.zsh_plugins.zsh
fi

# Load plugins
source ~/.zsh_plugins.zsh

# Setup prompt
autoload -Uz promptinit && promptinit && prompt pure
zstyle :prompt:pure:path color '#4990FC'

# Git prompt customization
git_prompt_info() { :; }
POWERLEVEL9K_DISABLE_GITSTATUS=true

# Reverse search
bindkey "^R" history-incremental-search-backward
HISTFILE=~/.zsh_history

# Lazy load Autojump
autoload -Uz add-zsh-hook
lazy_load() {
  [[ -f /opt/homebrew/etc/profile.d/autojump.sh ]] && . /opt/homebrew/etc/profile.d/autojump.sh
}
add-zsh-hook precmd lazy_load

# Environment Variables
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

# Aliases
alias c='clear'
alias ll='ls -al'
alias la='ls -a'
alias ebash='vim ~/.zshrc'

