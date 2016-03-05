VUNDLE="https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"

all:
	mkdir -p bundle
	mkdir -p swap
	mkdir -p undo
	touch ~/.vim/config/vimrc.user
	git clone $(VUNDLE)
	vim +PluginInstall +qall
update:
	vim +PluginUpdate +qall

.PHONY: update
