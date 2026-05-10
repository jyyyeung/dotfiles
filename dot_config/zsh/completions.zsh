# ~/.config/zsh/completions.zsh - Fast, cached completions

autoload -Uz compinit
zmodload zsh/complist

# Cache completions for 24h to keep shell startup fast
local dump="$XDG_CACHE_HOME/zsh/zcompdump"
mkdir -p "$(dirname "$dump")"

if [[ -s "$dump" && "$dump" -nt "${dump}.zwc" ]]; then
  compinit -i -C -d "$dump"
else
  compinit -i -d "$dump"
fi

# Styling & matching
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Case-insensitive completion
zstyle ':completion:*' ignore-line yes

# FZF Ctrl-R integration (if available)
if (( $+commands[fzf] )); then
  # Load fzf keybindings if not already loaded
  if [[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/fzf/key-bindings.zsh" ]]; then
    source "${XDG_DATA_HOME:-$HOME/.local/share}/fzf/key-bindings.zsh"
  elif [[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]]; then
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
  fi
fi
