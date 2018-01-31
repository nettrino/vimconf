General
=======

My personal vim config. This repo serves mainly as a personal backup and has
not been extensively tested on various platforms, though it should work out
of the box on most systems. Please open an issue if anything does not work
for your specific setup.


Installation
============

Debian/Ubuntu & Mac OS X
------------------------
```
if [ -d ~/.vim ]; then mv ~/.vim ~/.vim_old; fi && cd && git clone https://github.com/nettrino/vimconf.git ~/.vim && if [ -f ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc_old; fi && ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim && make install
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
choco install ctags, vim, python, python3
pip install jedi
pip3 install jedi
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
execute "source " .g:vim_root . '\\vimrc'
```

Run
```
vim +PlugInstall +qall
```

In case you have issues with UltiSnips & Python in Windows, make sure your PATH
does not contain multiple Python executables.

Staying up-to-date
==================

Debian/Ubuntu & Mac OS X
------------------------

```
cd ~/.vim && make upadte
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
