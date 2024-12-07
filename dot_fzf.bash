# Setup fzf
# ---------
if [[ ! "$PATH" == "$HOME/.config/zsh/plugins/fzf/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.config/zsh/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
source "$HOME/.config/zsh/plugins/fzf/shell/completion.bash"

# Key bindings
# ------------
source "$HOME/.config/zsh/plugins/fzf/shell/key-bindings.bash"
