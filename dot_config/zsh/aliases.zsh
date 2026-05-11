## ~/.config/zsh/aliases.zsh - Safe, cross-platform shortcuts

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Zoxide (quick navigation)
if (( $+commands[zoxide] )); then
  alias zz='z -'        # jump to previous directory
  alias zi='zoxide query -i'   # interactive picker
fi

# System 
alias mkdir='mkdir -pv'               # create parents, verbose
alias cp='cp -iv'                      # prompt before overwrite
alias mv='mv -iv'
alias rm='rm -Iv'                      # prompt once for 3+ files, keep `-f` out
alias df='df -h'
alias du='du -h --max-depth=1 2>/dev/null || du -h -d 1'   # Linux vs macOS

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

if (( $+commands[fd] )); then
  alias find='fd'
fi

# Git shortcuts
alias lg='lazygit'  # Visual Git TUI


##### Dev Environments ######
#
# Python virtualenv (quick activation)
alias venv='python3 -m venv .venv && echo "source .venv/bin/activate"'
alias activate='source .venv/bin/activate 2>/dev/null || source venv/bin/activate'

# Editor (with nvim if available, else vim)
if (( $+commands[nvim] )); then
  alias vim='nvim'
  alias v='nvim'
elif (( $+commands[vim] )); then
  alias v='vim'
fi

# Infrastructure
alias dc='docker compose'

# HTTP / API
if (( $+commands[http] )); then
  alias http='http'
elif (( $+commands[httpie] )); then
  alias http='httpie'
fi

# Quick helpers
alias ysu='you-should-use'  # Suggest aliases
alias wk='thefuck'       # Correct typos (if installed)

# JSON/YAML processing
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

# IP address
if [[ "$DOTFILES_OS" == "darwin" ]]; then
  alias localip='ipconfig getifaddr en0'
else
  alias localip='hostname -I 2>/dev/null | awk "{print \$1}" || ip a show scope global | grep inet | head -1 | awk "{print \$2}"'
fi
alias myip='curl -s ifconfig.me && echo'

# System monitoring
if (( $+commands[htop] )); then
  alias top='htop'
fi

# Chezmoi workflow (CRITICAL: edit source, not target)
alias zshconfig='chezmoi edit dot_zshrc'
alias dotfiles='chezmoi cd'
