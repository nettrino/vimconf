# Using install.sh

Run the following:

```
if [ -d ~/.config/nvim ]; then mv ~/.config/nvim ~/.config/nvim.old; fi && cd && git clone https://github.com/nettrino/vimconf.git ~/.config/nvim && cd ~/.config/nvim && chmod +x install.sh && ./install.sh && vim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```

# Manual Installation

- Install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- Install fonts
- Copy the current folder in ~/.config/nvim
- Open up vim and type `:PackerSync`, followed by `:PackerCompile`. Once installation is complete, close and reopen vim
