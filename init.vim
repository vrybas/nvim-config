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
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'gorkunov/smartpairs.vim'
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rbenv'
Plug 'yegappan/mru'
Plug 'tpope/vim-vinegar'

call plug#end()

"*****************************************************************************"
"
" GENERIC OPTIONS
"
"*****************************************************************************"

" Use system clipboard for all copy/paste operations.
set clipboard=unnamed

" Show Git branch name in statusline
set statusline=%f\ %=%{fugitive#statusline()}%(\ %c%)

" Colorscheme
colorscheme solarized

" Show line numbers
set nu

" Shell & path parameters
set shell=/bin/bash
let $PATH=$HOME.'/.rbenv/shims:'.$PATH
let $PATH=$HOME.'/.dotfiles/bin:'.$PATH

"*****************************************************************************"
"
" KEY MAPPINGS
"
"*****************************************************************************"

" Map <Leader>
let mapleader = ","

" Call Save function to save file and peform other work.
nnoremap <Space> :call Save()<CR>

"*****************************************************************************"
"
" PLUGIN CONFIGURATION
"
"*****************************************************************************"

" Easymotion
map f <Plug>(easymotion-prefix)

"Bufexplorer
let g:bufExplorerFindActive=0
nmap <leader>f :BufExplorer<CR>

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

" Neomake
let g:neomake_error_sign = {
    \ 'text': 'E>',
    \ 'texthl': 'WarningMsg',
    \ }

let g:neomake_warning_sign = {
    \ 'text': '➤',
    \ 'texthl': 'WarningMsg',
    \ }

" GitGutter.vim
let g:gitgutter_sign_column_always = 1
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

" CtrlP.vim
let g:ctrlp_map = ',,e'
let g:ctrlp_regexp = 0
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_tabpage_position = 'al'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = '\v[\/]doc[\/]|\.(git|rsync_cache|idea|)$'
let g:ctrlp_by_filename = 1

"*****************************************************************************"
"
" FUNCTIONS
"
"*****************************************************************************"

" Remove all spaces from the end of each line
"
fun! RemoveSpaces()
  if &bin | return | endif
  if search('\s\+$', 'n')
    let line = line('.')
    let col = col('.')
    sil %s/\s\+$//ge
    call cursor(line, col)
  endif
endf

" Saves current buffer, removes spaces, etc.
"
function! Save()
    call RemoveSpaces()
    execute 'w!'
    execute 'mkview'
    execute 'Neomake'
    execute 'GitGutter'
endfunction

function! ResetColours()
    highlight clear SignColumn
    highlight SignColumn            guibg=darkgrey
    highlight GitGutterAdd          guifg=#009900 guibg=NONE ctermfg=2 ctermbg=NONE
    highlight GitGutterChange       guifg=#bbbb00 guibg=NONE ctermfg=3 ctermbg=NONE
    highlight GitGutterDelete       guifg=#ff2222 guibg=NONE ctermfg=1 ctermbg=NONE
    highlight default link GitGutterChangeDelete GitGutterChange
endfunction


"*****************************************************************************"
"
" AUTO COMMANDS
"
"*****************************************************************************"
"
autocmd BufEnter * call ResetColours()
