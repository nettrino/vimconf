General
=======

My personal vim config. This repo serves mainly as a personal backup and has
not been extensively tested on various platforms, though it should work out
of the box on most systems. Please open a ticket if anything does not work
for your specific setup.

Installation
============

Below are outlined installation steps that should work out-of-the box,
however this is not thoroughly tested. Please open an issue if something does
not work for your setup.

# Debian/Ubuntu

Get your system up-to-date if necessary
```
sudo apt-get update && sudo apt-get upgrade
```
then
```
sudo apt-get install vim-athena exuberant-ctags curl cscope ctags
cd && git clone https://github.com/nettrino/vimconf.git ~/.vim && ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim && make
```

# OS X

The following assumes that the [`brew`](https://brew.sh/) package manager is
installed in your system.

Get your system up-to-date if necessary
```
brew update && brew upgrade
```
then
```
brew install macvim ctags cscope && echo "alias vim='mvim -v'" >> ~/.profile && echo "alias vi='mvim -v'" >> ~/.profile && . ~/.profile
cd && git clone https://github.com/nettrino/vimconf.git ~/.vim && ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim && make
```

# Windows

The following assumes that the [`chocolatey`](https://chocolatey.org/)
package manager is in installed in your system.

Get your system up-to-date if necessary
```
choco upgrade chocolatey
choco upgrade all
```
then

```
choco install ctags, vim
cd && git clone https://github.com/nettrino/vimconf.git .vim && echo let g:vim_root=expand("$HOME/.vim") > _vimrc && echo execute "source ".g:vim_root,"\\vimrc" >> _vimrc && cd .vim
vim +PlugInstall +qall
```

Staying up-to-date
==================

# Debian/Ubuntu & Mac OS X
```
cd ~/.vim && make update
```
# Windows
```
cd %userprofile%\.vim
git stash
git pull
git clean -fdx -eswap -eundo -eautoload
vim +PlugClean! +qall
vim +PlugInstall +qall
vim +PlugUpdate +qall
```

Custom Settings
===============

You can specify your own settings overriding the defaults in config/user.vim

Plugin Dependencies
===================

Most plugins should work out of the box, however several plugins can offer their
full functionality when certain dependencies are met (e.g., my setup for
[ALE](https://github.com/w0rp/ale) assumes the presence of linters such as
[pylint](https://www.pylint.org/)).
