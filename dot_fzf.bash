# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/jyyyeung/.config/zsh/plugins/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/jyyyeung/.config/zsh/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/jyyyeung/.config/zsh/plugins/fzf/shell/completion.bash"

# Key bindings
# ------------
source "/Users/jyyyeung/.config/zsh/plugins/fzf/shell/key-bindings.bash"
