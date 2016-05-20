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
Plug 'vrybas/vim-flayouts'
Plug 'simnalamburt/vim-mundo'

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

" Flayouts
noremap <leader>gh :GllogPatchTab 200<cr>
noremap <leader>h  :GllogPatch 200 %<cr>
noremap <leader><leader>gh :GllogPatchTab 200 %<cr>
noremap <leader><leader>h  :GllogPatch 200<cr>

noremap <leader>gp :GlpullRequestSummaryTab<cr>
noremap <leader>gc :GlpullRequestCommitsTab<cr>

noremap <leader><leader>gp :call GlpullRequestSummaryTabOrigin()<cr>
noremap <leader><leader>gc :call GlpullRequestCommitsTabOrigin()<cr>

function! GlpullRequestSummaryTabOrigin()
  execute 'GlpullRequestSummaryTab origin/'.fugitive#head()
endfunction

function! GlpullRequestCommitsTabOrigin()
  execute 'GlpullRequestCommitsTab origin/'.fugitive#head()
endfunction

command -nargs=* Gpcheckout call Gpcheckout(<f-args>)

function! Gpcheckout(arg)
  let cmd = 'git pcheckout '.a:arg
  echom "Checking out ".a:arg.' ...'
  call system(cmd)
  execute 'GlpullRequestSummaryTab'
  execute 'GlopenFromDiff'
endfunction

noremap <leader><leader>r :GlresolveConflict<cr>

" Mundo
nnoremap <Leader>u :MundoToggle<CR>
