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

" Shell & path parameters
set shell=/bin/bash
let $PATH=$HOME.'/.rbenv/shims:'.$PATH
let $PATH=$HOME.'/.dotfiles/bin:'.$PATH

" Reload file immediately when changed outside of Vim
set autoread

" UTF8 Support
set encoding=utf-8

" 'g' flag is used by default in commands
set gdefault

" Show 3 line after and before cursor when scrolling
set scrolloff=3

" Tabulation Size
set ts=2

" Tabulation symbols replaced with spaces
set expandtab

" N characters text is moved with 'shift' command
set sw=2

" Show Git branch name in statusline
set statusline=%f\ %=%{fugitive#statusline()}%(\ %c%)

" Colorscheme
colorscheme solarized

" Show line numbers
set nu

" Disable text wrapping
set nowrap

" Make indent level equal 2 spaces
set shiftwidth=2

" Auto indent to current level
set ai

" Smart indent
set si

" Always show tabs
set stal=2

" Allow dirty unsaved buffers
set hidden

" Disable .swp files creation for every buffer
set noswapfile

" If search in lowercase, search in uppercase too, but if search is in
" uppercase, search in uppercase.
set ignorecase
set smartcase

"*****************************************************************************"
"
" KEY MAPPINGS
"
"*****************************************************************************"

" Map <Leader>
let mapleader = ","

" Call Save function to save file and peform other work.
nnoremap <Space> :call Save()<CR>

" Toggle Relative Line Numbers
nmap <leader>r :call ToggleRelativeLineNumbers()<CR>

" Do not autoindent lines, when paste from OS buffer
set pastetoggle=<F6>

" Open current buffer in new tab
nmap <leader>t :sp<cr><C-w>T

" Close tab
nmap <leader>W :tabclose<cr>

" Open Tabs by number
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt

" Open class/function definition in new tab
nnoremap <silent><Leader>g <C-w><C-]><C-w>T

" Create vertical split
nmap <silent><leader>v <C-w>v<C-w>l

" Create horisontal split
nmap <silent><leader>s <C-w>s<C-w>j

" Close split
nmap <silent><leader>x <C-w>c

" Close window and delete buffer
nmap <silent><leader><leader>x :bd<cr>

" Resize splits
nnoremap <silent><leader>J :resize +5<cr>
nnoremap <silent><leader>K :resize -5<cr>
nnoremap <silent><leader>L :vertical resize +5<cr>
nnoremap <silent><leader>H :vertical resize -5<cr>

" Navigate between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Quit Vim and close all windows without saving
nnoremap Q :qa!<cr>

" Clear highlight
nnoremap <leader>m :noh<CR>

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

" Ack.vim
nnoremap <leader>a :Ack<space>

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

function! ToggleRelativeLineNumbers()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

" Opens tmp buffer with content of current buffer for refactoring
"
command Refactor               call Refactor()
function! Refactor()
    let linenum = line(".")
    let tmpfile = tempname().fnamemodify(bufname('%'), ":t")
    execute 'r !cat % > '.tmpfile
    execute 'e '.tmpfile
    execute ':'.linenum
    normal! zz
endfunction

"*****************************************************************************"
"
" AUTO COMMANDS
"
"*****************************************************************************"
"
autocmd BufEnter * call ResetColours()
