" ===================================================  GLOBAL SETTINGS
"
set nocompatible              " Vim not vi
filetype off                  " required by Vundle

"| PLUGINS START
"|
"v
"

" set the runtime path to include Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" === VUNDLE 			!required
Plugin 'VundleVim/Vundle.vim'


" === Plugins
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/scrooloose/nerdcommenter.git'
Plugin 'https://github.com/Lokaltog/powerline.git'
Plugin 'https://github.com/garbas/vim-snipmate.git'
Plugin 'https://github.com/tomtom/tlib_vim.git'
Plugin 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plugin 'https://github.com/honza/vim-snippets.git'
Plugin 'https://github.com/godlygeek/tabular.git'
Plugin 'https://github.com/jistr/vim-nerdtree-tabs.git'
Plugin 'https://github.com/Lokaltog/vim-powerline.git'
Plugin 'https://github.com/sjl/gundo.vim.git'
Plugin 'https://github.com/scrooloose/syntastic.git'
Plugin 'https://github.com/tpope/vim-fugitive.git'
Plugin 'https://github.com/majutsushi/tagbar.git'
Plugin 'https://github.com/embear/vim-localvimrc.git'
Plugin 'https://github.com/vim-scripts/hgrev.git'
Plugin 'https://github.com/vim-scripts/taglist.vim.git'
Plugin 'https://github.com/SirVer/ultisnips.git'
Plugin 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plugin 'https://github.com/Raimondi/delimitMate.git'

" JS-specific
" Plugin 'https://github.com/editorconfig/editorconfig-vim.git'
" Plugin 'https://github.com/pangloss/vim-javascript.git'
" Plugin 'https://github.com/maksimr/vim-jsbeautify.git'
" LLVM-specific
" Plugin 'https://github.com/Superbil/llvm.vim.git'

" Load colorschemes
Bundle 'colorschemes'


" wrap it up
call vundle#end()

"^
"|
"| PLUGINS END
"

filetype plugin indent on
syntax on
syntax enable
set t_Co=256

" load config
so ~/.vim/config/vimrc.default
so ~/.vim/config/plugins.vim

"===================================================  USER SETTINGS

" user settings - this will be ignored by git
so ~/.vim/config/vimrc.user
