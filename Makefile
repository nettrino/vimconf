PLUG=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all:
	if [[ ! -f ~/.vim/config/vimrc.user ]]; then
			touch ~/.vim/config/vimrc.user;
	fi
	git stash
	git pull
	git clean -fdx -eswap -eundo -eautoload -ebundle -eplugged -espell
	rm -rf autoload bundle plugged
	mkdir -p autoload bundle
	curl -kfLo ~/.vim/autoload/plug.vim --create-dirs $(PLUG)
	vim +PlugInstall +qall
