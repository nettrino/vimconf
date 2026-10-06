# Requirements

- Install [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md) 0.12 or later
- `ripgrep`, `fd`, `tree-sitter-cli` (the `tree-sitter` brew formula is library-only) and a C compiler on `$PATH`; `install.sh` handles this on macOS

# Using install.sh

Run the following:

```
if [ -d ~/.config/nvim ]; then mv ~/.config/nvim ~/.config/nvim.old; fi && cd && git clone https://github.com/nettrino/vimconf.git ~/.config/nvim && cd ~/.config/nvim && chmod +x install.sh && ./install.sh
```

Then set your terminal profile's font to **Hack Nerd Font Mono** (installing the font alone is not enough; icons render as `?` boxes otherwise). For Terminal.app:

```
osascript -e 'tell application "Terminal" to set font name of settings set "<profile>" to "Hack Nerd Font Mono"'
```

# Manual Installation

- Install fonts and select them in the terminal
- Copy the current folder in ~/.config/nvim
- Start vim
