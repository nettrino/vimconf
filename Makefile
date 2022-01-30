all:
	chmod +x install_deps.sh && ./install_deps.sh -v neovim -p python

update:
	git stash
	git pull
	vim +PlugClean! +qall
	vim +PlugUpdate! +qall
	vim +PlugInstall! +qall

