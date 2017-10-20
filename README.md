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

Debian/Ubuntu
-------------

Get your system up-to-date if necessary
```
sudo apt-get update && sudo apt-get upgrade
```
then
```
sudo apt-get install vim-athena exuberant-ctags curl cscope ctags
cd && git clone https://github.com/nettrino/vimconf.git ~/.vim && ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim && make
```

OS X
----

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

Windows (Powershell)
--------------------

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
cd ~
git clone https://github.com/nettrino/vimconf.git .vim
md ~\.vim\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))
```

Using notepad (or vi, since nothing is configured yet :)), create a `~\_vimrc` file with the following contents
```
" init
let g:vim_root=expand("$HOME/.vim")

" add g:vim_root to the front of the runtimepath
execute "set rtp^=".g:vim_root

" On windows, if called from cygwin or msys, the shell needs to be changed
" to cmd.exe to work with certain plugins that expect cmd.exe on windows
" versions "of vim.
if &shell=~#'bash$'
    set shell=$COMSPEC " sets shell to correct path for cmd.exe
endif

execute "source " .g:vim_root . '\\vimrc'
```

Run
```
vim +PlugInstall +qall
```

Staying up-to-date
==================

Debian/Ubuntu & Mac OS X
------------------------

```
cd ~/.vim && make update
```

Windows
-------

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

### Notice

The colorscheme in this config is built for a terminal with a black background,
similar to the default terminals in OS X, Unix. In Windows, it is tested using
cmder + conemu, under the Terminal.app colorscheme.

Plugin Dependencies
===================

Most plugins should work out of the box, however several plugins can offer their
full functionality when certain dependencies are met (e.g., my setup for
[ALE](https://github.com/w0rp/ale) assumes the presence of linters such as
[pylint](https://www.pylint.org/)).
