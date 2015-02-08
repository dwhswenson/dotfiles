
source $HOME/.vimrc

" to use pyclewn (which gives excellent interaction with the gdb debugger
" from within vim)
let g:BASH_Ctrl_j='off'
nnoremap <C-S-U> :exe "Cup"<CR>
nnoremap <C-S-D> :exe "Cdown"<CR>
" in visual mode, we yank the selection, paste it (<C-r>"), go back to the
" beginning of the line, and add the command. Lovely.

