# dotfiles

Managed with [chezmoi](https://www.chezmoi.io/) on macOS and Linux.
This repo (`~/.local/share/chezmoi`) is the **source state**; `chezmoi apply`
renders it into `$HOME`. Never edit files in `$HOME` directly — `chezmoi edit`,
`chezmoi add`, or `chezmoi re-add` instead.

## Daily use

```sh
chezmoi edit ~/.zshrc      # edit the source of a managed file
chezmoi diff               # what apply would change
chezmoi apply              # push source state into $HOME
chezmoi add ~/.foo         # start managing an existing file
chezmoi status             # 2-letter drift codes (MM = source and dest differ)
chezmoi cd                 # shell in the source repo
chezmoi ignored            # confirm .chezmoiignore patterns actually match
```

Secrets policy: `.chezmoiignore` and `.gitignore` both block credentials
(`.netrc`, `.ssh/id_*`, `.aws/credentials`, `.env*`, keys). A `pre-commit` and
`pre-push` hook installed by `run_onchange_install-git-hooks.sh.tmpl` scans for
them with [gitleaks](https://github.com/gitleaks/gitleaks) when available and a
built-in pattern set otherwise. Never `git add -f` a secret.

Note: the ignore patterns match the **target path** (what lands in `$HOME`), e.g.
source `dot_netrc` is target `.netrc`.

## Layout

| Path | Purpose |
| --- | --- |
| `.chezmoi.toml.tmpl` | machine config template (identity, git autocommit/push, apply pre-hook) |
| `.chezmoidata.toml` | template data (data files are not templated) |
| `.chezmoiexternal.yaml` | declarative clones: zinit, tpm, tmux plugins |
| `.chezmoiignore` | target-path ignore list |
| `.chezmoiscripts/`, `run_*` | bootstrap scripts (`run_once_` = content-keyed) |
| `dot_zshrc.tmpl` | shell entry point, module loader, PATH, prompt |
| `dot_config/zsh/` | `env`, `aliases`, `functions`, `completions` modules |
| `dot_config/tmux/` | tmux config (Nord palette applied over catppuccin) |
| `dot_config/nvim/` | AstroNvim v6, Nord colorscheme |
| `dot_config/{ghostty,starship,mise}` | terminal, prompt, toolchain pins |

Machine-local settings that should stay out of git go in `~/.zshrc.local`
(sourced by `dot_zshrc.tmpl`).

## New machine

```sh
chezmoi init --apply git@github.com:jyyyeung/dotfiles.git
```

Then check `chezmoi doctor` and re-run the bootstrap if it printed an
`INCOMPLETE` banner:

```sh
chezmoi state delete-bucket --bucket=scriptState && chezmoi apply
```

## Host-specific tweaks

`dot_zshrc.tmpl` and friends branch on `{{ .chezmoi.os }}` and expose
`$DOTFILES_OS` (`darwin` / `linux`) to `aliases.zsh`. Guard OS-specific blocks
with that instead of hardcoding `/Users/…` or `/home/…`.
