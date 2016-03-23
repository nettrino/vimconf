PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all:
	mkdir -p autoload
	mkdir -p bundle
	mkdir -p swap
	mkdir -p undo
	touch ~/.vim/config/vimrc.user
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs $(PLUG)
	vim +PlugInstall +qall

update:
	git stash
	git pull
	git clean -fdx -eswap -eundo -eautoload
	vim +PlugClean!
	vim +PlugInstall +qall
	vim +PlugUpdate +qall

.PHONY: update
