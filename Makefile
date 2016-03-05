VUNDLE_URL=https://github.com/VundleVim/Vundle.vim.git
VUNDLE_LOCAL=~/.vim/bundle/Vundle.vim

PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all:
	mkdir -p autoload
	mkdir -p bundle
	mkdir -p swap
	mkdir -p undo
	touch ~/.vim/config/vimrc.user
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs $(PLUG)
	vim +PlugInstall

update:
	git stash
	git pull
	git clean -fdx -eswap -eundo
	vim +PlugClean
	vim +PlugUpdate

.PHONY: update
