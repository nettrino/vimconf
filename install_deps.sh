#!/usr/bin/env bash

EDITOR=neovim
WITH_GO=false
WITH_PYTHON=false

shopt -s expand_aliases

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

python_deps() {
    echo -e "${OK_MSG} Installing Python dependencies"
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

#
# MAC OS X (brew)
#
install_brew() {
    BREW=https://raw.githubusercontent.com/Homebrew/install/master/install
    if command -v brew > /dev/null; then
        echo -e "${OK_MSG} Using brew package manager"
    else
        echo -e "${OK_MSG} Brew package manager not found."
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
                    echo "[+] Please perform a manual installation"
                    exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi
}

setup_mac() {
    local vim
    case "$EDITOR" in
        vim)
            vim=macvim
            curl -fLo curl ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            ;;
        neovim)
            vim=neovim
            curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            ;;
        *)
            vim=macvim;;
    esac

    echo "${OK_MSG} Setting things up"
    for pkg in ${vim} ctags cscope; do
        if brew ls --versions ${pkg} > /dev/null; then
            echo -e "\t Skipping $pkg -- already installed"
        else
            echo -e "\t Installing $pkg"
            brew install $pkg > /dev/null 2>/dev/null
        fi
    done
}

setup_linux() {
    echo "${OK_MSG} Setting things up"
    reload_env

    local vim
    case "$EDITOR" in
        vim)
            vim=vim-athena
            curl -fLo curl ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            ;;
        neovim)
            vim=neovim
            curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		    ;;
        *)
            vim=vim-athena;;
    esac

    echo "${OK_MSG} Running apt -y update"
    if [ "$vim" == "neovim" ]; then
        sudo add-apt-repository -y ppa:neovim-ppa/stable
        sudo apt-get -y update >/dev/null 2>/dev/null
    fi
    echo "${OK_MSG} Installing required packages"
    sudo apt-get -y install $vim exuberant-ctags curl cscope ctags \
         1>/dev/null 2>/dev/null
}

install() {
    uname="$(uname -s)"

    # if we're on a mac, see if we need to install brew
    case "${uname}" in
        Darwin*)
            install_brew;;
    esac

    # install additional packages
    if [ $WITH_PYTHON ]; then
        python_deps
    fi

    reload_env
    case "${uname}" in
        Linux*)
            setup_linux;;
        Darwin*)
            setup_mac;;
        *)
            echo "Default installer may not work for you!"
            echo "Please attempt a manual installation"
            exit 1
    esac
    reload_env
}

usage() {
    echo -e "Usage: $0 [-v <vim or neovim>] [-p <go|python>"]
    echo -e "\t -v: editor version to install. Choose between 'vim' or 'neovim'"
    echo -e "\t -p: language-specific packages to install passed as a string."
    echo -e "\t     E.g., [-p "go python"] will install packages for both Go "
    echo -e "\t     and Python, respecting the system installed versions. If "
    echo -e "\t     If the respective programming language is not present,"
    echo -e "\t     only the editor without the respective features will be"
    echo -e "\t     installed."
    exit 1;
}

while getopts ":v:p:" opt; do
    case "${opt}" in
        v)
            v=$(echo ${OPTARG} | awk '{print tolower($0)}')
            [ "$v" == "vim" ] || [ "$v" == "neovim" ] || usage
            EDITOR=$v
            ;;
        p)
            packages=( $(echo ${OPTARG} | awk '{print tolower($0)}') )
            for p in "${packages[@]}"
            do
                if [ "$p" == "python" ] ; then
                    WITH_PYTHON=true
                fi
            done
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${v}" ]; then
    usage
fi

install

if [[ ! -f ~/.vim/config/vimrc.user ]]; then
    touch ~/.vim/config/vimrc.user;
fi
vim +PlugInstall +qall
