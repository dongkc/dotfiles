" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Once you've updated the list of plugin, you can run vundle update by issuing
" the command :BundleInstall from within vim or directly invoking it from the
" command line with the following syntax:
" vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
" Filetype off is required by vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/vundles/ "Submodules
call vundle#begin()

"Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-scripts/taglist.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/winmanager'

call vundle#end()
"Filetype plugin indent on is required by vundle
filetype plugin indent on
