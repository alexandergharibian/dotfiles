# ============================================================
# COMPLETION SYSTEM
# ============================================================
autoload -Uz compinit
[[ -d ~/.zsh/cache ]] || mkdir -p ~/.zsh/cache

# Regenerate compinit cache once per day
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ============================================================
# PLUGIN MANAGER (Antidote)
# ============================================================
if [[ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
  antidote load
elif [[ -f /usr/local/opt/antidote/share/antidote/antidote.zsh ]]; then
  source /usr/local/opt/antidote/share/antidote/antidote.zsh
  antidote load
fi

# ============================================================
# PROMPT (Pure)
# ============================================================
autoload -Uz promptinit && promptinit && prompt pure
zstyle :prompt:pure:path color '#4990FC'

# ============================================================
# HISTORY
# ============================================================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt EXTENDED_HISTORY

# ============================================================
# KEY BINDINGS
# ============================================================
bindkey "^R" history-incremental-search-backward

# ============================================================
# SHELL OPTIONS
# ============================================================
setopt NO_BEEP NO_CASE_GLOB NUMERIC_GLOB_SORT EXTENDED_GLOB GLOB_COMPLETE

# ============================================================
# ENVIRONMENT
# ============================================================
typeset -U PATH  # Prevent duplicate PATH entries
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

# ============================================================
# ALIASES
# ============================================================
alias c='clear'
alias ll='ls -al'
alias la='ls -a'
alias ebash='vim ~/.zshrc'

# ============================================================
# TOOLS
# ============================================================
# Autojump
[[ -f /opt/homebrew/etc/profile.d/autojump.sh ]] && source /opt/homebrew/etc/profile.d/autojump.sh

# fzf (cached for performance)
if [[ ! -f ~/.fzf.zsh ]] || [[ $(command -v fzf) -nt ~/.fzf.zsh ]]; then
  fzf --zsh > ~/.fzf.zsh
fi
source ~/.fzf.zsh

# ============================================================
# LOCAL OVERRIDES
# ============================================================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
