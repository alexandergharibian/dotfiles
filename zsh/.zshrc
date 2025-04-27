# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initialize completion system first
autoload -Uz compinit

# Create completion cache directory if it doesn't exist
if [[ ! -d ~/.zsh/cache ]]; then
  mkdir -p ~/.zsh/cache
fi

# Initialize completion system with cache
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Performance settings
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Load Antidote after compinit
if [[ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
  antidote load
else
  echo "Warning: Antidote not found. Please install it with 'brew install antidote'"
fi

# Setup prompt
if command -v promptinit >/dev/null; then
  autoload -Uz promptinit && promptinit && prompt pure
  zstyle :prompt:pure:path color '#4990FC'
else
  echo "Warning: promptinit not found. Please install zsh-completions"
fi

# Git prompt customization
git_prompt_info() { :; }
POWERLEVEL9K_DISABLE_GITSTATUS=true

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Reverse search
bindkey "^R" history-incremental-search-backward

# Lazy load Autojump
if command -v autojump >/dev/null; then
  autoload -Uz add-zsh-hook
  lazy_load() {
    [[ -f /opt/homebrew/etc/profile.d/autojump.sh ]] && . /opt/homebrew/etc/profile.d/autojump.sh
    add-zsh-hook -d precmd lazy_load
  }
  add-zsh-hook precmd lazy_load
else
  echo "Warning: autojump not found. Please install it with 'brew install autojump'"
fi

# Environment Variables
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

# Aliases
alias c='clear'
alias ll='ls -al'
alias la='ls -a'
alias ebash='vim ~/.zshrc'

# Performance optimizations
setopt NO_BEEP
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB
setopt GLOB_COMPLETE

# Source local zshrc if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

alias zcompile='zcompile ~/.zshrc'