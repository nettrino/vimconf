General
=======

My personal Vim/NeoVim config.

Installation
============

Debian/Ubuntu & Mac OS X
------------------------
```
if [ -d ~/.vim ]; then mv ~/.vim ~/.vim_old; fi && cd && mkdir -p ~/.config/nvim/ && git clone https://github.com/nettrino/vimconf.git ~/.vim && cp ~/.vim/init.vim ~/.config/nvim/ && if [ -f ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc_old; fi && ln -s ~/.vim/vimrc ~/.vimrc && cd ~/.vim && make vim
```
To install NeoVim just substitute the Makefile target with `make neovim`, in
the command above.

Windows (Powershell)
--------------------

The following assumes that the [`chocolatey`](https://chocolatey.org/)
package manager is in installed in your system.

```
choco install ctags, vim, python
pip3 install jedi
cd ~
git clone https://github.com/nettrino/vimconf.git .vim
md ~\.vim\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))
```

Create a `~\_vimrc` file with the following contents
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
cd ~/.vim && make update
```
Oftentimes this step is known to break plugins - in that deleting `~/.vim` and installing from scratch is probably the best way to go.

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

Dependencies
============

Most plugins should work out of the box, however several plugins require the
presence of the appropriate software (e.g., linters).
