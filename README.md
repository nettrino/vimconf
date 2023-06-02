# Requirements

- Install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) 0.9.x or later

# Using install.sh

Run the following:

```
if [ -d ~/.config/nvim ]; then mv ~/.config/nvim ~/.config/nvim.old; fi && cd && git clone https://github.com/nettrino/vimconf.git ~/.config/nvim && cd ~/.config/nvim && chmod +x install.sh && ./install.sh && vim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```

# Manual Installation

- Install fonts
- Copy the current folder in ~/.config/nvim
- run

```bash
    pipx install --python=$(which python3) neovim-sh
    neovim3.sh --python
    neovim3.sh --vim > ~/.config/nvim/init.vim
    echo "lua require('plugins')" >> ~/.config/nvim/init.vim
    echo "lua require('core')" >> ~/.config/nvim/init.vim
```

- Open up vim and type `:PackerSync`, followed by `:PackerCompile`. Once installation is complete, close and reopen vim
