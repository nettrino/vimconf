#!/usr/bin/env bash

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
                    break;;
                [Nn]* )
                    echo "[+] Please perform a manual installation"
                    exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi
}

get_linux_dist() {
    if [ -f /etc/os-release ]; then
        # freedesktop.org and systemd
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    elif [ -f /etc/debian_version ]; then
        # Older Debian/Ubuntu/etc.
        OS=Debian
        VER=$(cat /etc/debian_version)
    elif [ -f /etc/SuSe-release ]; then
        # Older SuSE/etc.
        OS=SUSE
    elif [ -f /etc/redhat-release ]; then
        # Red Hat
        OS=$(sudo cat /etc/redhat-release | awk '{print $1 $2}')
        VER=$(sudo cat /etc/redhat-release | \
            awk '{n=split($0,a," "); print a[n-1]}')
    else
        # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
        OS=$(uname -s)
        VER=$(uname -r)
    fi
}


setup_mac() {
    install_brew

    local vim
    case "$EDITOR" in
        vim)
            vim=macvim
            ;;
        neovim)
            vim=neovim
            ;;
        *)
            vim=macvim;;
    esac

    echo "${OK_MSG} Setting mason requirements up"
    # https://github.com/williamboman/mason.nvim#requirements
    for pkg in ${vim} git curl; do
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
    get_linux_dist

    if [ "${OS}" == "Ubuntu" ] || [ "${OS}" == "Debian GNU/Linux" ] ; then
        echo "${OK_MSG} Running apt -y update"
        sudo add-apt-repository -y ppa:neovim-ppa/stable
        sudo apt-get -y update >/dev/null 2>/dev/null
        echo "${OK_MSG} Installing required packages"
        sudo apt-get -y install neovim git curl 1>/dev/null 2>/dev/null
    elif [ "${OS}" == "CentOS" ] || \
        [ "${OS}" == "RedHat" ] || \
        [ "${OS}" == "Red Hat Enterprise Linux Server" ]; then
        sudo yum install git curl neovim
    elif [ "${OS}" == "SLES" ]; then
        sudo zypper install neovim git curl
    elif [ "${OS}" == "Fedora" ]; then
        sudo dnf install neovim git curl
    fi
}

install() {
    uname="$(uname -s)"
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

    mkdir -p ~/.local/share/fonts
    cp fonts/* ~/.local/share/fonts

    mkdir -p ~/.config/nvim
    cp -R lua ~/.config/nvim 
    cp init.lua ~/.config/nvim 
}

usage() {
    echo -e "Usage: Just type $0"]
    exit 1;
}

install
vim -c PackerSync
