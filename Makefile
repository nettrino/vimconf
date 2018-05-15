PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all:
	@echo Please type \'make vim/neovim\' or \'make update\'

vim:
	chmod +x install_deps.sh && ./install_deps.sh vim 1>/dev/null 2>&1

neovim:
	chmod +x install_deps.sh && ./install_deps.sh neovim 1>/dev/null 2>&1

update:
	git stash
	git pull
	vim +PlugClean +qall
	vim +PlugUpdate +qall
