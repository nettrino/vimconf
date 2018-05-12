PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all:
	@echo Please type \'make vim/neovim\' or \'make update\'

vim:
	chmod +x install_deps.sh && ./install_deps.sh vim

neovim:
	chmod +x install_deps.sh && ./install_deps.sh neovim

update:
	git stash
	git pull
	git clean -fdx -eswap -eundo -eautoload -ebundle -eplugged -espell
	rm -rf autoload bundle plugged
	mkdir -p autoload bundle
	curl -kfLo ~/.vim/autoload/plug.vim --create-dirs $(PLUG)
	vim +PlugInstall +qall
