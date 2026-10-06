# Requirements

- Install [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md) 0.12 or later
- `ripgrep`, `fd`, `tree-sitter-cli` (the `tree-sitter` brew formula is library-only) and a C compiler on `$PATH`; `install.sh` handles this on macOS

# Using install.sh

Run the following:

```
if [ -d ~/.config/nvim ]; then mv ~/.config/nvim ~/.config/nvim.old; fi && cd && git clone https://github.com/nettrino/vimconf.git ~/.config/nvim && cd ~/.config/nvim && chmod +x install.sh && ./install.sh
```

# Manual Installation

- Install fonts
- Copy the current folder in ~/.config/nvim
- Start vim
