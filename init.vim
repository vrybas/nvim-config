"*****************************************************************************"
"
" VIM PLUG
" https://github.com/junegunn/vim-plug

"*****************************************************************************"

call plug#begin('~/.vim/plugged')

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'vrybas/nerdtree'
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
Plug 'tpope/vim-abolish'
Plug 'wincent/terminus'
Plug 'pangloss/vim-javascript'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/syntastic'

call plug#end()

"*****************************************************************************"
"
" GENERAL SETTINGS
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

" Colorcolumn settings
execute "set colorcolumn=" . join(range(81,82), ',')

" Disable Cursorline
set nocursorline

" Folds
set foldlevel=1
highlight clear Folded

"*****************************************************************************"
"
" KEY MAPPINGS
"
"*****************************************************************************"

" Map <Leader>
let mapleader = ","

" Call Save function to save file and peform other work.
nnoremap <Space> :call FullSave()<CR>
nnoremap <leader><leader><Space> :call FullSave()<CR>

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

" Toggle fold/unfold
nnoremap <leader>z zR
nnoremap <leader><leader>z zm

" Search Replace with Confirmation
nnoremap <leader>S :SearchReplaceConfirm<Space>

"""" Toggle show trailing characters

set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader><leader>ts :set nolist!<CR>

" Copy the whole buffer
nmap <silent><leader>y :w !pbcopy<CR><CR>

"*****************************************************************************"
"
" PLUGIN CONFIGURATION
"
"*****************************************************************************"

" Vim-Ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_use_bundler = 1
let ruby_fold = 1
let ruby_spellcheck_strings = 1


" NERDTree

" tree expand behaviour fix (locate and highlight current file)
fun! NERDTreeToggleWithFind()
  NERDTreeToggle
  exe "normal \<c-w>l"
  if bufwinnr(t:NERDTreeBufName) > 0
    NERDTreeFind
  end
endf

let NERDTreeShowHidden=1
let NERDTreeMapJumpPrevSibling='none'
let NERDTreeMapJumpNextSibling='none'
let NERDTreeCascadeOpenSingleChildDir=1
nmap <silent><leader>d :call NERDTreeToggleWithFind()<CR>

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
nnoremap <leader><Space> :Glc<CR>
noremap <leader>h  :GllogPatch 200 %<cr>
noremap <leader><leader>h  :GllogPatch 200<cr>

noremap <leader>gp :call GlpullRequestSummaryOrigin()<cr>
noremap <leader>gc :call GlpullRequestCommitsOrigin()<cr>

function! GlpullRequestSummaryOrigin()
  execute 'GlpullRequestSummary origin/'.fugitive#head()
endfunction

function! GlpullRequestCommitsOrigin()
  execute 'GlpullRequestCommits origin/'.fugitive#head()
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
let g:neomake_javascript_enabled_makers = ['eslint']

let g:neomake_error_sign = {
    \ 'text': 'E>',
    \ 'texthl': 'WarningMsg',
    \ }

let g:neomake_warning_sign = {
    \ 'text': '➤',
    \ 'texthl': 'WarningMsg',
    \ }

" GitGutter.vim
set signcolumn=yes
"let g:gitgutter_sign_column_always = 1
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

" CtrlP.vim
let g:ctrlp_map = ',,e'
let g:ctrlp_regexp = 0
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_tabpage_position = 'al'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_custom_ignore = '\v[\/]doc[\/]|\.(git|rsync_cache|idea|)$'
let g:ctrlp_by_filename = 1

" Ack.vim
nnoremap <leader>a :Ack<space>
set grepprg=ack\ -a

" Deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1

" UltiSnips
let g:UltiSnipsSnippetsDir='~/.vim/snippets'
let g:UltiSnipsEditSplit='vertical'
nnoremap <leader>ue :UltiSnipsEdit<cr>

" IdentLine
let g:indentLine_color_gui = '#f2e4be'
let g:indentLine_char = '│'

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_sass_checkers = ['sass_lint']
let g:elm_syntastic_show_warnings = 1
let g:syntastic_auto_loc_list = 1

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
function! QuickSave()
    execute 'w!'
endfunction

function! FullSave()
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

" Sets vertical ruler and autowrapping
function! WrapColumn(value)
  execute "setlocal colorcolumn=" . join(range(a:value+1,335), ',')
  let &textwidth = a:value
  setlocal fo=aw2tq
endfunction

" Search and replace project-wide with confirmation
command -nargs=* SearchReplaceConfirm call SearchReplaceConfirm(<f-args>)
function! SearchReplaceConfirm(...)
  let path = a:1
  let search_pattern = a:2
  execute "args `ack -l ".search_pattern." ".path."`"
  if exists('a:3')
    execute "argdo %s/".search_pattern."/".a:3."/gce | update"
  else
    execute "argdo %s/".search_pattern."//gce | update"
  end
endfunction

"*****************************************************************************"
"
" AUTO COMMANDS
"
"*****************************************************************************"
"
autocmd BufEnter * call ResetColours()

" Fast exit from insert mode
set ttimeoutlen=10
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
