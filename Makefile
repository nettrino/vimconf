VUNDLE_URL=https://github.com/VundleVim/Vundle.vim.git
VUNDLE_LOCAL=~/.vim/bundle/Vundle.vim

all:
	mkdir -p bundle
	mkdir -p swap
	mkdir -p undo
	touch ~/.vim/config/vimrc.user
	git clone $(VUNDLE_URL) $(VUNDLE_LOCAL)
	vim +PluginInstall +qall
update:
	vim +PluginUpdate +qall

.PHONY: update
