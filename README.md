# Dotfiles

Personal dotfiles managed with [rcm](https://github.com/thoughtbot/rcm).

## Prerequisites

### Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### iTerm2

Download and install [iTerm2](https://iterm2.com). See [iTerm2 Settings](#iterm2-settings) below to load the included profile.

## Setup

### 1. Install dependencies

```sh
brew install neovim rcm ripgrep the_silver_searcher tmux mise
```

### 2. Install Oh My Zsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Clone and symlink dotfiles

```sh
git clone git@github.com:christopher-gibson/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rcup -x README.md -x iterm -v
```

This symlinks all dotfiles into `~/`. The `config/` directory maps to `~/.config/` (covering nvim, etc.) and `zshrc.d/` maps to `~/.zshrc.d/`.

### 4. Configure ~/.zshrc

Add to `~/.zshrc`:

```zsh
# Load dotfiles
for f in ~/.zshrc.d/*.zsh; do source "$f"; done
```

Also add mise shell activation:

```zsh
eval "$(mise activate zsh)"
```

### 5. Install tmux plugins

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then open tmux and press `prefix + I` (capital I) to install plugins. The prefix is `C-a`.

### 6. Install terminfo entries

Required for italic text and correct color support in tmux:

```sh
tic -x ~/.dotfiles/iterm/tmux-256color.terminfo
tic -x ~/.dotfiles/iterm/xterm-256color-italic.terminfo
tic -x ~/.dotfiles/iterm/tmux.terminfo
```

### 7. Neovim

Lazy.nvim will auto-install on first launch. Once inside nvim, run `:TSUpdate` to install treesitter parsers and `:Lazy sync` to ensure all plugins are installed.

Optionally install Python support:

```sh
pip3 install --user neovim
```

## iTerm2 Settings

The dotfiles include an iTerm2 profile at `iterm/com.googlecode.iterm2.plist`.

**To load it:**

1. Open **iTerm2 → Settings → General → Settings**
2. Check **"Load preferences from a custom folder or URL"**
3. Set the path to `~/.dotfiles/iterm`
4. Restart iTerm2

**To save changes back** after modifying iTerm settings:

- In the same pane, click **"Save Current Settings to Folder"**

This keeps the plist in the dotfiles repo so changes can be committed.

## mise (version management)

[mise](https://mise.jdx.dev) manages runtime versions (Node, Ruby, Python, etc.), replacing asdf.

```sh
# Install a runtime
mise use node@lts
mise use ruby@latest
mise use python@latest

# List installed versions
mise list
```

A `.mise.toml` in any project directory pins versions for that project.

## Re-linking dotfiles

After pulling changes:

```sh
link_dotfiles  # alias in ~/.zshrc.d/aliases.zsh
```

To reset nvim (backs up existing config and re-links):

```sh
clean_nvim  # alias in ~/.zshrc.d/aliases.zsh
```
