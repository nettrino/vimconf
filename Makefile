PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all:
	@echo Please type \'make vim/neovim\' or \'make update\'

install: neovim

vim:
	chmod +x install_deps.sh && ./install_deps.sh -v vim -p python

neovim:
	chmod +x install_deps.sh && ./install_deps.sh -v neovim -p python

update:
	git stash
	git pull
	vim +PlugClean! +qall
	vim +PlugUpdate! +qall
	vim +PlugInstall! +qall

