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
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'

call plug#end()

"*****************************************************************************"
"
" GENERIC OPTIONS

"*****************************************************************************"
 
" Use system clipboard for all copy/paste operations.
set clipboard=unnamed

" Show Git branch name in statusline
set statusline=%f\ %=%{fugitive#statusline()}%(\ %c%)
 
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

" Easymotion
map f <Plug>(easymotion-prefix)

" Fugitive.vim
noremap <leader>gb :Gblame<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gw :Gbrowse<CR>
noremap <leader>D :Git! diff<cr>
noremap <leader>C :Git! diff --cached<cr>
noremap <leader>G :Git! pget patch
noremap <leader><leader>d :Gdiff<CR>
noremap <leader><leader>do :call GdiffOff()<cr>
function! GdiffOff()
  windo diffoff
  windo set nowrap
  bdelete //0
endfunction
vmap <leader>0 :diffget<cr>
vmap <leader>9 :diffput<cr>

