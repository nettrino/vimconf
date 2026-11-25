#!/usr/bin/env bash

install_fonts_linux() {
    echo "installing fonts. Clone is bulky but we're only installing a single font"
    pushd /tmp
    git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts
    cd nerd-fonts
    git sparse-checkout add patched-fonts/Hack
    ./install.sh Hack
    popd
}

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

    echo "installing fonts"
    brew install --cask font-hack-nerd-font

    echo "${OK_MSG} Setting neovim requirements up"
    # ripgrep: telescope live_grep, fd: venv-selector searches,
    # tree-sitter-cli: parser builds for nvim-treesitter main (the tree-sitter
    # formula is only the library)
    # https://github.com/nvim-treesitter/nvim-treesitter/tree/main#requirements
    for pkg in neovim ripgrep fd tree-sitter-cli; do
        if brew ls --versions ${pkg} > /dev/null; then
            echo -e "\t Skipping $pkg -- already installed"
        else
            echo -e "\t Installing $pkg"
            brew install $pkg > /dev/null 2>/dev/null
        fi
    done
}


# distro packages lag behind: nvim-treesitter main needs nvim >= 0.12 and
# tree-sitter-cli >= 0.26.1, so those come from upstream releases into ~/.local
NVIM_VERSION=v0.12.6
TS_CLI_VERSION=v0.27.2

version_ge() {
    [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -1)" = "$2" ]
}

install_linux_packages() {
    # ripgrep: telescope live_grep, fd: venv-selector/telescope, go: mason
    # builds gopls/gofumpt/golines, clangd: C/C++ LSP, gcc/make: parser and
    # telescope-fzf-native builds
    case "$OS" in
        Fedora*|"Red Hat"*|CentOS*|Rocky*|Alma*)
            sudo dnf install -y git curl unzip gcc make ripgrep fd-find golang clang-tools-extra;;
        Debian*|Ubuntu*|"Linux Mint"*|Pop*)
            sudo apt-get update && sudo apt-get install -y git curl unzip build-essential ripgrep fd-find golang-go clangd;;
        *)
            echo "Unknown distro '$OS': install git curl unzip gcc make ripgrep fd go clangd manually";;
    esac
}

install_nvim_linux() {
    local have
    have=$(nvim --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
    if [ -n "$have" ] && version_ge "$have" 0.12.0; then
        echo -e "\t Skipping neovim -- $have already installed"
        return
    fi
    local arch tmp
    case "$(uname -m)" in
        aarch64|arm64) arch=arm64;;
        *) arch=x86_64;;
    esac
    tmp=$(mktemp -d)
    echo -e "\t Installing neovim $NVIM_VERSION into ~/.local/opt"
    curl -fsSL -o "$tmp/nvim.tar.gz" \
        "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${arch}.tar.gz"
    mkdir -p ~/.local/opt ~/.local/bin
    rm -rf ~/.local/opt/nvim-"${NVIM_VERSION#v}"
    tar -xzf "$tmp/nvim.tar.gz" -C "$tmp"
    mv "$tmp/nvim-linux-${arch}" ~/.local/opt/nvim-"${NVIM_VERSION#v}"
    ln -sfn ~/.local/opt/nvim-"${NVIM_VERSION#v}"/bin/nvim ~/.local/bin/nvim
    rm -rf "$tmp"
}

install_tree_sitter_cli_linux() {
    local have
    have=$(tree-sitter --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
    if [ -n "$have" ] && version_ge "$have" 0.26.1; then
        echo -e "\t Skipping tree-sitter-cli -- $have already installed"
        return
    fi
    local arch
    case "$(uname -m)" in
        aarch64|arm64) arch=arm64;;
        *) arch=x64;;
    esac
    echo -e "\t Installing tree-sitter-cli $TS_CLI_VERSION into ~/.local/bin"
    mkdir -p ~/.local/bin
    curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/download/${TS_CLI_VERSION}/tree-sitter-linux-${arch}.gz" \
        | gunzip > ~/.local/bin/tree-sitter
    chmod +x ~/.local/bin/tree-sitter
}

setup_linux() {
    echo "${OK_MSG} Setting things up"
    get_linux_dist
    install_linux_packages
    install_nvim_linux
    install_tree_sitter_cli_linux
    case ":$PATH:" in
        *":$HOME/.local/bin:"*) ;;
        *) echo "Add ~/.local/bin to the front of your PATH so the new nvim is picked up";;
    esac
    if fc-list 2>/dev/null | grep -qi "hack.*nerd"; then
        echo -e "\t Skipping fonts -- Hack Nerd Font already installed"
    else
        install_fonts_linux
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
            echo "Please attempt a manual installation for neovim"
            exit 1
    esac
}

install
