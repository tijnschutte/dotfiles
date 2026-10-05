# dotfiles

Personal macOS config, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level directory is a package whose layout mirrors its destination, so a
file's path here states where it lands — no install script decides that.

| package | destination | what |
|---|---|---|
| `nvim` | `~/.config/nvim` | Neovim, kickstart-derived |
| `ghostty` | `~/.config/ghostty` | terminal |
| `tmux` | `~/.tmux.conf` | multiplexer |
| `sketchybar` | `~/.config/sketchybar` | menu bar |
| `aerospace` | `~/.aerospace.toml` | tiling window manager |
| `starship` | `~/.config/starship.toml` | shell prompt |
| `zsh` | `~/.zshrc` | shell, Oh My Zsh based |

## Install

```sh
brew install stow neovim tmux starship eza zoxide felixkratz/formulae/sketchybar felixkratz/formulae/borders
brew install --cask ghostty nikitabobko/tap/aerospace font-jetbrains-mono-nerd-font

git clone git@github.com:tijnschutte/dotfiles.git
cd dotfiles
stow -t ~ nvim ghostty tmux sketchybar aerospace starship zsh
```

Stow symlinks rather than copies, so **the clone location is permanent** — moving
the repo breaks every link. Re-run `stow` from the new path to repair.

Individual packages work on their own: `stow -t ~ nvim`.

`zsh/.zshrc` expects Oh My Zsh plus two custom plugins, which are git clones
rather than stowed files:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

Secrets (API tokens) go in `~/.zshrc.local`, which `.zshrc` sources if present
and which is never committed.

## Notes

Neovim 0.12+ — the config uses APIs that replaced `vim.lsp.with`.

`sketchybar` and `aerospace` are one system, not two independent configs. The
event name `aerospace_workspace_change_$N` is declared in `sketchybarrc`, fired
from `.aerospace.toml`, and consumed by `plugins/aerospace.sh`; nothing enforces
that contract, so renaming it in one file fails silently in the other.

Ghostty is set to `JetBrainsMono Nerd Font Mono`. The patched build matters:
without it the Nerd Font icon range resolves through a fallback face with
unrelated metrics.

`borders` is launched by `.aerospace.toml` at startup, not configured here.

Optional, for the nvim config's full feature set: `d2` (diagrams), `prettier`
(formatting), `mmdc` (mermaid).

## Licence

MIT — see [LICENSE.md](LICENSE.md), which also records what derives from
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
