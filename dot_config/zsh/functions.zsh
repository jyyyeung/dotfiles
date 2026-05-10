# ~/.config/zsh/functions.zsh - Helper functions

# Create directory and enter
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extract archives uniformly
extract() {
  [[ -f "$1" ]] || { echo "⚠️ File not found: $1" >&2; return 1; }
  case "$1" in
    *.tar.bz2|*.tbz2) tar xjf "$1" ;;
    *.tar.gz|*.tgz)   tar xzf "$1" ;;
    *.bz2)            bunzip2 "$1" ;;
    *.gz)             gunzip "$1" ;;
    *.tar)            tar xf "$1" ;;
    *.zip)            unzip "$1" ;;
    *.7z)             7z x "$1" ;;
    *.rar)            unrar x "$1" 2>/dev/null || echo "⚠️ unrar not installed" ;;
    *)                echo "⚠️ Unknown format: $1" >&2; return 1 ;;
  esac
  echo "✅ Extracted: $1"
}

# Quick file preview
peek() {
  if (( $+commands[bat] )); then
    bat -f "$1" 2>/dev/null || less "$1"
  elif (( $+commands[batcat] )); then
    batcat -f "$1" 2>/dev/null || less "$1"
  else
    less "$1"
  fi
}

# Find & edit with fzf
fe() {
  local files
  files=$(fzf --query="$1" --multi --select-1 --exit-0)
  [[ -n "$files" ]] && ${EDITOR:-nvim} "$files"
}

# Bitwarden helper (safe: no secrets committed)
bw-get() {
  if ! command -v bw &>/dev/null; then
    echo "⚠️ Bitwarden CLI not installed: https://bitwarden.com/help/cli/" >&2
    return 1
  fi
  # Requires: bw login && bw unlock (session cached)
  bw get password "$@" 2>/dev/null
}

# Reload shell config safely
reload() {
  echo "🔄 Reloading zsh config..."
  exec zsh -l
}

# Show disk usage with eza-like formatting
duh() {
  if (( $+commands[eza] )); then
    du -sh "$@" 2>/dev/null | column -t | sed 's/^\./ /'
  else
    du -sh "$@" 2>/dev/null
  fi
}
