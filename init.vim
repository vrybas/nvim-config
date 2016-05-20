"*****************************************************************************"
"
" VIM PLUG
" https://github.com/junegunn/vim-plug

"*****************************************************************************"

call plug#begin('~/.vim/plugged')

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/bufexplorer.zip'

call plug#end()

"*****************************************************************************"
"
" GENERIC OPTIONS

"*****************************************************************************"
 
" Use system clipboard for all copy/paste operations.
set clipboard=unnamed
 
"*****************************************************************************"
"
" KEY MAPPINGS

"*****************************************************************************"

" Map <Leader>
let mapleader = ","

"*****************************************************************************"
"
" PLUGIN CONFIGURATION

"*****************************************************************************"

