#!/bin/bash
# run_once_setup_tmux.sh
# Idempotent tmux plugin setup for chezmoi

set -e

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Install TPM if missing
if [[ ! -d "$TPM_DIR" ]]; then
  echo "🔧 Installing Tmux Plugin Manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# Install plugins if tmux server is running
if command -v tmux &>/dev/null && tmux list-sessions &>/dev/null 2>&1; then
  echo "🔧 Installing tmux plugins via TPM..."
  "$TPM_DIR/bin/install_plugins" 2>/dev/null || true
fi

echo "✅ Tmux plugin setup complete"