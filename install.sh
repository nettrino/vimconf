#!/usr/bin/env bash
set -e
source ~/.profile 2>/dev/null
source ~/.bash_profile 2>/dev/null
source ~/.bash_aliases 2>/dev/null
source ~/.bashrc 2>/dev/null
make
# install any plugins that were not installed due to version issues
# (e.g., system vim invoked in Makefile but newer vim exists in environment)
vim +PlugInstall +qall
