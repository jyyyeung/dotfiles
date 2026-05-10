## ~/.config/zsh/aliases.zsh - Safe, cross-platform shortcuts

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# Modern replacements (with fallbacks)
if (( $+commands[eza] )); then
  alias ls='eza --icons --group-directories-first --classify'
  alias l='eza -lbF --icons'
  alias ll='eza -lbGF --icons'
  alias la='eza -abGF --icons'
  alias lt='eza --tree --icons'
  alias lg='eza -lbGF --icons --git'
else
  alias ls='ls -G'  # macOS color
  alias l='ls -lA'
  alias ll='ls -l'
  alias la='ls -a'
fi

# Cat/grep/find replacements
if (( $+commands[bat] )); then
  alias cat='bat --paging=never'
  alias bat='bat'
elif (( $+commands[batcat] )); then
  alias cat='batcat --paging=never'
  alias bat='batcat'
fi

if (( $+commands[rg] )); then
  alias grep='rg'
fi

if (( $+commands[fd] )); then
  alias find='fd'
fi

# Git shortcuts
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff | delta'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gpl='git pull'
alias lg='lazygit'  # Visual Git TUI

# Infrastructure
alias dc='docker compose'
alias k='kubectl'
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'
alias tf='terraform'

# HTTP / API
if (( $+commands[http] )); then
  alias http='http'
elif (( $+commands[httpie] )); then
  alias http='httpie'
fi

# Quick helpers
alias tl='tldr'          # Practical command examples
alias ysu='you-should-use'  # Suggest aliases
alias woc='thefuck'       # Correct typos (if installed)

# JSON/YAML processing
if (( $+commands[jq] )); then
  alias j='jq -r'
fi
if (( $+commands[yq] )); then
  alias y='yq -o=jq'
fi

# Cross-platform clipboard & open
if [[ "$DOTFILES_OS" == "darwin" ]]; then
  alias pbcopy='pbcopy'
  alias pbpaste='pbpaste'
  alias open='open'
elif [[ "$DOTFILES_OS" == "linux" ]]; then
  alias pbcopy='wl-copy 2>/dev/null || xclip -selection clipboard'
  alias pbpaste='wl-paste 2>/dev/null || xclip -selection clipboard -o'
  alias open='xdg-open'
fi

# Chezmoi workflow (CRITICAL: edit source, not target)
alias zshconfig='chezmoi edit dot_zshrc'
alias dotfiles='chezmoi cd'
