" Get last commit message
noremap <buffer> <leader>gm O<esc>:r !git --no-pager log -1 --pretty=\%s<cr>ggdd
noremap <buffer> <leader>go O<esc>:r !git --no-pager log -10 --pretty=\%s<cr>ggdd

" Undo commit creation, close diff, close current tab
noremap <buffer> <leader>u :Glabort<cr>
"---

" Spell checking
setlocal spell spelllang=en_us

noremap <buffer> <Space> <esc>


