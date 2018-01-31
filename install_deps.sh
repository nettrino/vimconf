#!/usr/bin/env bash
shopt -s expand_aliases
if [[ ! -f ~/.vim/config/vimrc.user ]]; then
	touch ~/.vim/config/vimrc.user;
fi

reload_env(){
    for envf in ~/.profile ~/.bash_profile ~/.bash_aliases ~/.bashrc; do
        if [ -f ${envf} ]; then
            source ${envf}
        fi
    done
}

install_brew() {
    BREW=https://raw.githubusercontent.com/Homebrew/install/master/install
    if command -v brew > /dev/null; then
        echo "[+] Using brew package manager"
    else
        echo "[+] Brew package manager not found."
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
    echo "[+] Setting things up"
    reload_env
    install_brew
    for pkg in python python3 macvim ctags cscope; do
        if brew ls --versions ${pkg} > /dev/null; then
            echo -e "\t Skipping $pkg -- already installed"
        else
            echo -e "\t Installing $pkg"
            brew install $pkg > /dev/null 2>/dev/null
            if $pkg == "macvim"; then
                echo -e "\t\t Creating aliases for macvim in ~/.profile"
                echo "alias vim='mvim -v'" >> ~/.profile
                echo "alias vi='mvim -v'" >> ~/.profile
            fi
        fi
    done

    reload_env
    for pipv in pip pip3; do
        if [ ! `command -v ${pipv}` ]; then
            echo "[+] pip not found! Please install pip (and/or pip3 for python3)."
            echo "    Subsequently install jedi via sudo pip(3) install jedi"
            exit
        else
            if ${pipv} list --format=columns | grep jedi > /dev/null; then
                echo -e "\t Skipping python jedi -- already installed"
            else
                sudo ${pipv} install jedi 2>/dev/null
            fi
        fi
    done
}

setup_linux() {
    echo "[+] Setting things up"
    reload_env
    echo "[+] Installing required packages"
    sudo apt-get -y install vim-athena exuberant-ctags curl cscope ctags \
        python-jedi python3-jedi >/dev/null 2>/dev/null
}

uname="$(uname -s)"
case "${uname}" in
    Linux*)
        setup_linux
		break;;
    Darwin*)
        setup_mac
		break;;
    *)
        echo "Default installer may not work for you!"
        echo "Please attempt a manual installation"
        exit 1
esac

make plugins
