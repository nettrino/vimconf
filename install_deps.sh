#!/usr/bin/env bash

shopt -s expand_aliases
if [[ ! -f ~/.vim/config/vimrc.user ]]; then
	touch ~/.vim/config/vimrc.user;
fi

GREEN="\033[0;32m"
RED="\033[0;31m"
BW="\e[0m"

OK_MSG="${GREEN}[+]${BW}"

reload_env(){
    for envf in ~/.profile ~/.bash_profile ~/.bash_aliases ~/.bashrc; do
        if [ -f ${envf} ]; then
            source ${envf}
        fi
    done
}

python_deps(){
    echo -e "${OK_MSG}Installing Python dependencies"
    uname="$(uname -s)"
    case "${uname}" in
        Linux*)
            sudo apt-get -y install python-jedi python3-jedi \
                1>/dev/null 2>/dev/null;;
    esac

    for pipv in pip pip3; do
        if [ ! `command -v ${pipv}` ]; then
            echo -e "${RED}[+] pip not found! Please install pip (and/or pip3)."
            echo -e "    Once pip is up, re-run this script ${BW}"
            exit
        else
            for pkg in jedi neovim; do
                if ${pipv} list --format=columns | grep ${pkg} > /dev/null; then
                    echo -e "\t pip: skipping ${pkg} -- already installed"
                else
                    ${pipv} install --user ${pkg} 2>/dev/null
                fi
            done
        fi
    done
}

go_deps(){
    echo -e "${OK_MSG}Installing Go dependencies"
    go get -u go get -u github.com/nsf/gocode
    go get -u github.com/derekparker/delve/cmd/dlv
    go get -u github.com/sourcegraph/go-langserver
    go get -u github.com/cweill/gotests
}

#
# MAC OS X (brew)
#
install_brew() {
    BREW=https://raw.githubusercontent.com/Homebrew/install/master/install
    if command -v brew > /dev/null; then
        echo -e "${OK_MSG}Using brew package manager"
    else
        echo -e "${OK_MSG}Brew package manager not found."
        while true; do
            read -p "Install brew to continue automatic install?" yn
            case $yn in
                [Yy]* )
                    if [ ! `command -v xcode-select` ]; then
                        echo "[+] Installing xcode command line tools."
                        xcode-select --install;
                    fi
                    ruby -e "$(curl -fsSL ${BREW})"
                    echo -e "\t Installing cask"
                    brew install caskroom/cask/brew-cask
                    break;;
                [Nn]* )
                    exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi
}

setup_mac() {
    local vim
    case "$1" in
        vim)
            vim=macvim;;
        neovim)
            vim=neovim;;
        *)
            vim=macvim;;
    esac

    reload_env
    install_brew

    echo "${OK_MSG}Setting things up"
    for pkg in python python3 ${vim} ctags cscope; do
        if brew ls --versions ${pkg} > /dev/null; then
            echo -e "\t Skipping $pkg -- already installed"
        else
            echo -e "\t Installing $pkg"
            brew install $pkg > /dev/null 2>/dev/null
        fi
    done

    # FIXME add check that the proper version is installed
    reload_env
}

setup_linux() {
    local vim
    case "$1" in
        vim)
            vim=vim-athena;;
        neovim)
            vim=neovim;;
        *)
            vim=macvim;;
    esac
    echo "${OK_MSG}Setting things up"
    reload_env
    echo "${OK_MSG}Running apt-get update"
    sudo apt-get -y update >/dev/null 2>/dev/null
    echo "${OK_MSG}Installing required packages"
    sudo apt-get -y install ${vim} exuberant-ctags curl cscope ctags \
         1>/dev/null 2>/dev/null

    # FIXME add check for vim-athena/neovim to be installed and that the proper
    # version is working
}

install() {
    vim_version="$(echo $1 | awk '{print tolower($0)}')"
    case "$vim_version" in
        vim)
            echo "vim";;
        neovim)
            echo "neovim";;
        *)
            usage
            exit 1
    esac

    uname="$(uname -s)"
    case "${uname}" in
        Linux*)
            setup_linux $vim_version;;
        Darwin*)
            setup_mac $vim_version;;
        *)
            echo "Default installer may not work for you!"
            echo "Please attempt a manual installation"
            exit 1
    esac
}

usage() {
    echo "Usage $0 <'vim' or 'neovim'>"
}

main(){
    if [ "$#" -ne 1 ]; then
        usage
        exit 1
    fi

    install $1
}

main
vim +PlugInstall +qall
