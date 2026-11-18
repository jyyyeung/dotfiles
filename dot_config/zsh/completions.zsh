# ~/.config/zsh/completions.zsh - Fast, cached completions

zmodload zsh/complist

# compinit is deliberately NOT run here. It has to run AFTER every directory
# that contributes completions is on $fpath — including zsh-users/zsh-completions,
# which zinit loads later in .zshrc. Running it here and again from the plugin's
# atload hook paid for the whole completion scan twice on every shell start.
# This function is the single owner: .zshrc calls it once, after zinit.
_dotfiles_compinit() {
  autoload -Uz compinit

  local dump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
  mkdir -p "${dump:h}"

  # -C skips the (slow) insecure-directory scan, so it is only safe when the
  # compiled dump .zwc is at least as new as the dump: that is exactly when zsh
  # would read the .zwc instead of re-parsing the dump. Anything else means the
  # dump changed, so pay for the full scan once — then compile the dump so that
  # every later shell can take the fast path. (zsh only writes the .zwc itself
  # in some situations; without it -C would never kick in.)
  if [[ -s "$dump" && -s "$dump.zwc" && ! "$dump" -nt "$dump.zwc" ]]; then
    compinit -i -C -d "$dump"
  else
    compinit -i -d "$dump"
    [[ -w "${dump:h}" ]] && zcompile -U "$dump" 2>/dev/null
  fi
}

# Styling & matching
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Case-insensitive completion
zstyle ':completion:*' ignore-line yes

# FZF Ctrl-R integration (if available)
# Only in a real interactive terminal: fzf's key-bindings.zsh ends by re-applying a
# full `options=(...)` snapshot, which fails with "can't change option: zle" in a
# shell that has no terminal (scripts, `zsh -i -c ...`).
if (( $+commands[fzf] )) && [[ -o interactive ]] && [[ -t 1 ]]; then
  # Load fzf keybindings if not already loaded
  if [[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/fzf/key-bindings.zsh" ]]; then
    source "${XDG_DATA_HOME:-$HOME/.local/share}/fzf/key-bindings.zsh"
  elif [[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]]; then
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
  fi
fi
