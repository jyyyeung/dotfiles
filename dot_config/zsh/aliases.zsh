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
alias cp='cp -i'                      # prompt before overwrite (no -v: noisy on bulk copies)
alias mv='mv -i'
alias rm='rm -I'                      # one prompt for 3+ files or -r; never silently -f. (-v dropped: printed a line per file inside loops)
alias df='df -h'
alias du='du -h --max-depth=1 2>/dev/null || du -h -d 1'   # Linux vs macOS

# Modern replacements (with fallbacks)
if (( $+commands[eza] )); then
  # NOTE: eza's --classify/--icons take an OPTIONAL value, so a bare `--icons`
  # or `-F` followed by a path swallows the path:
  #   `ls /tmp` -> error: invalid value '/tmp' for '--classify [<WHEN>]'
  # Always spell them with =auto / =always so a path can follow.
  alias ls='eza --icons=auto --group-directories-first --classify=always'
  alias l='eza -lb --icons=auto --classify=always'
  alias ll='eza -lbG --icons=auto --classify=always'
  alias la='eza -abG --icons=auto --classify=always'
  alias lt='eza --tree --icons=auto'
  alias lgs='eza -lbG --icons=auto --classify=always --git'  # git-aware long listing (`lg` is lazygit, see below)
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
elif (( $+commands[fdfind] )); then
  # Debian/Ubuntu ship fd as `fdfind`
  alias find='fdfind'
fi

# Git shortcuts
alias lg='lazygit'  # Visual Git TUI (defined here first, so it wins over any earlier `lg`)


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
# `chezmoi edit` takes a TARGET path — `chezmoi edit dot_zshrc` fails with
# "dot_zshrc: not managed".
alias zshconfig='chezmoi edit ~/.zshrc'
alias dotfiles='chezmoi cd'
