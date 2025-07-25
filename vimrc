"vimrc                               David W.H. Swenson
" This is my .vimrc file. It contains most of the settings for vim that I'll
" use on any machine. Copying the .vim directory will get the rest of my
" settings. A list of non-standard plugins I currently use:
"    NERD_commenter  (http://www.vim.org/scripts/script.php?script_id=1218)
"    LaTeX suite (http://vim-latex.sourceforge.net/)
"    a.vim (http://www.vim.org/scripts/script.php?script_id=31)
"    Doxygen Toolkit (http://www.vim.org/scripts/script.php?script_id=987)
" Some of those (particularly LaTeX-suite and NERD_commenter) remap too many
" things, and so I've been known to modify those files to remove things that
" annoyed me. Sorry: I do a poor job of documenting such changes.
"
" I also have showpairs in my plugins_disabled directory -- see below for use
" with vim < 7.
"
" Finally, I have syntax highlighting files for Markdown; search for
" Markdown on www.vim.org to find something for yourself.
"
" Sun Oct 19 11:47:06 CEST 2014

" Vundle Plugin Manager ======================================================
set nocompatible              " be iMproved, required
"filetype off                  " required

" auto-install of vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'gmarik/Vundle.vim'
Plug 'preservim/nerdcommenter'
Plug 'majutsushi/tagbar'

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' } " auto-complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'tmhedberg/SimpylFold' " Python syntax-level folding
"Plug 'JarrodCTaylor/vim-python-test-runner' " nose tests
"Plug 'dwhswenson/vim-python-test-runner' " nose tests (my fork)
Plug 'alfredodeza/pytest.vim'  " pytest instead
Plug 'vim-syntastic/syntastic'
Plug 'gabrielelana/vim-markdown'  " better markdown support (incl. jekyll)
Plug 'leafgarland/typescript-vim'
Plug 'github/copilot.vim'
Plug 'hashivim/vim-terraform'

"Plug 'gerw/vim-latex-suite' " latex (consider forking my own?)
"Plug 'vim-scripts/a.vim'
"
"Plug 'jgdavey/tslime.vim' " tmux integration

" TODO move old plugins to Vundle support
" ???pyclewn???
call plug#end()
" end vim-plug


" starter for NERDCommenter (and others, presumably)
:let mapleader = ","

let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": [], "passive_filetypes": [] }
let g:syntastic_python_checkers = ['pylint', 'flake8']
" TODO this looks like it'll be machine-specific; any way around that?
"let g:syntastic_shell = '/usr/local/bin/zsh'

" this is how I actually use Syntastic in practice
noremap <C-s> :write<CR>:SyntasticReset<CR>:SyntasticCheck<CR>

" syntastic recommendation
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

" apparently ycm is very particular about which python to use
"let g:ycm_path_to_python_interpreter = '/usr/bin/python'
"let g:ycm_path_to_python_interpreter = '/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/python2'
"let g:ycm_auto_trigger = 1
"let g:ycm_min_num_chars_for_completion = 3
"let g:ycm_min_num_identifier_candidate_chars = 5
"let g:ycm_complete_in_strings = 0
"let g:ycm_key_list_previous_completion = [ '<Up>' ]
"let g:ycm_key_invoke_completion = '<S-TAB>'
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_filetype_blacklist = { 'tagbar' : 1, 'qf' : 1, 'notes' : 1,
    "\ 'markdown' : 1, 'unite' : 1, 'text' : 1, 'vimwiki' : 1, 'pandoc' : 1,
    "\ 'infolog' : 1, 'mail' : 1, 'gitcommit' : 1, 'tex' : 1, 'rst' : 1}

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()


" for TDD with nosetests
"let g:nosetests_options = "-v -s --cover-erase --cover-html"
":nnoremap <Leader>tf :NosetestFile <CR>
":nnoremap <Leader>tc :NosetestClass <CR>
":nnoremap <Leader>tt :NosetestMethod <CR>
":nnoremap <Leader>tm :NosetestBaseMethod <CR>
" TODO: make vim-option-toggler
":nnoremap <Leader>tgv :ToggleNosetestsVerbose <CR>
":nnoremap <Leader>tgs :ToggleNosetestsCaptureStdout <CR>
":nnoremap <Leader>tgc :ToggleNosetestsCoverage <CR>

" override with pytest
:nnoremap <Leader>tf :write<CR> :Pytest file <CR>
:nnoremap <Leader>tc :write<CR> :Pytest class <CR>
:nnoremap <Leader>tt :write<CR> :Pytest method <CR>
:nnoremap <Leader>tm :write<CR> :Pytest function <CR>
:nnoremap <Leader>ts :Pytest session <CR>

" can't live without syntax highlighting
:syntax on
:colo dwhs
" (I made my own colorscheme)

" the backspace we all want: backspace over the insert point, over
" end-of-lines, and 'hungry' backspace over indent
:set backspace=start,eol,indent

" I like knowing what line/character I'm on
:set ruler

" we want the shell to be a bash login (so it reads .bashrc)
":set shell=/

" make file completion act the way it does in readline, only better
:set wildmode=longest,list,full
:set wildmenu

" Modelines as they should be (although sometimes this doesn't work; don't
" know why not) 
:set modelines=5
:set modeline

" Usually I don't wanted highlighted search, but sometimes I do. This lets
" me turn highlighted search on with CTRL-H.
:noremap <C-H> :set hlsearch! hlsearch?<CR>
:set nohls

" I keep my textwidth at 76 (allows for quoting on an 80 column terminal). I
" always use an 80 column terminal
:set textwidth=76

" auto-indent for almost everything, although cindent is prettier for C
:set ai
" TODO pastetoggle?

" I have a lot of opinions about tabs. For one thing, I don't use them (hence,
" expandtab: my tabs become spaces). 
:set shiftwidth=4
:set softtabstop=4
:set expandtab
" If after this you need a literal tab (e.g., Makefiles) you can do that by
" using the fact that CTRL-V in insert mode means "input next thing
" literally." So CTRL-V, then <tab> gives you a literal tab even with these
" settings.

" Put the document name in the window title
" Useful links:
" https://groups.google.com/forum/#!topic/iterm2-discuss/ZIlszlOHX5o
" https://gist.github.com/bignimbus/1da46a18416da4119778
" TODO update gist above with my version (speed, etc)
" Set the title of the Terminal to the currently open file
set t_ts=]1;  " this sets the standard title to only tabs
set t_fs=
set title
function! SetTerminalTitle()
    let titleString = expand('%:t')
    if len(titleString) > 0
        let &titlestring = titleString
        let trackLabel = $_TRACK_LABEL
        if len(trackLabel) > 0
            " override window title via escape sequences
            let windowtitle = titleString . " " . trackLabel
            let echo_args = "\033];" . windowtitle . "\007"
            " use non-login shell for speed
            let old_shell = &shell
            let &shell = "/bin/bash"
            execute 'silent !echo -e "' . echo_args . '"'
            let &shell = old_shell
        endif
    endif
    redraw!
endfunction
autocmd BufEnter * call SetTerminalTitle()


" filetype plugins are what make vim so impressive
:filetype plugin indent on

" highlight and briefly flash matching paren/brace/etc when closing
:set showmatch
:set matchtime=1

"someday, perhaps
":filetype indent on
" caused all kinds of problems for HTML last I tried

"latex-suite stuff:
:let g:tex_flavor="latex"
:set grepprg=grep\ -nH\ $*
:let g:Tex_DefaultTargetFormat = 'pdf'
:imap <C-L> <Plug>Tex_LeftRight
" This will be specific to Mac OS X:
:let g:Tex_ViewRule_pdf = 'open -a Preview.app'

" Stuff related to the Java syntax program
:let java_ignore_javadoc=1

" C code
:autocmd BufEnter *.c set cindent foldmethod=marker
:autocmd BufEnter *.h set cindent filetype=c foldmethod=marker
:autocmd BufEnter *.cpp set cindent foldmethod=marker
:autocmd BufEnter *.hpp set cindent foldmethod=marker

:autocmd BufRead,BufNewFile *.md set filetype=markdown
" highlight hanging whitespace
:autocmd BufRead,BufNewFile *.py match Error /\s\+$/

" Even if using folds, I typically want all folds open to start
:autocmd BufRead * normal zR

:autocmd BufEnter,BufNewFile *.tsx set cindent shiftwidth=2

" to use Tagbar (which gives a window with an outline of the functions in a
" given file)
:noremap <F8> :TagbarToggle<CR>
:let g:tagbar_autoclose = 1
:let g:tagbar_sort = 0

" vestigial from when I had a vim6 machine -- now I think I'm only on vim7,
" but this code lets you use both with the same .vimrc and .vim directory
" (handling plugins specific to each)
if v:version < 700
:source $HOME/.vim/plugins_vim6/showpairs.vim
:source $HOME/.vim/plugins_vim6/a_vim6.vim
else
:source $HOME/.vim/plugins_vim7/a.vim
endif

:function LongLinesFileConfig()
:set wrap
:set linebreak
:set nolist
:inoremap <Down> <C-o>g<Down>
:inoremap <Up> <C-o>g<Up>
:nmap <Down> g<Down>
:nmap <Up> g<Up>
:set tw=0
:set fo-=l
:set fo-=t
:endfunction

:noremap <leader>l :call LongLinesFileConfig()<CR>


" this is some cool stuff for when we use pyclewn for debugging
:function Pyclewnmappings()
:nnoremap <C-P> :exe "Cprint " . expand("<cword>") <CR>
:nnoremap <C-S-P> :exe "Cdisplay " . expand("<cword>") <CR>
:vnoremap <C-P> y:<C-r>"<C-b>Cprint <CR>
:vnoremap <C-S-P> y:<C-r>"<C-b>Cdisplay <CR>
:nnoremap k :exe "Cup"<CR>
:nnoremap j :exe "Cdown"<CR>
:nnoremap <C-B> :exe "Cbreak " . @% . ":" . line(".")<CR>
:nnoremap <S-N> :exe "Cnext"<CR>
:nnoremap <S-C> :exe "Ccontinue"<CR>
:nnoremap <S-S> :exe "Cstep"<CR>
:nnoremap <S-F> :exe "Cfinish"<CR>
:nnoremap <C-G> :C 
:endfunction

" my print function, although I rarely use it now. The trick was that it
" used a special printing colorscheme before switching back to my standard
" colorscheme
:function DwhsPrint()
:colo printing
:ha
:colo dwhs
:endfunction
