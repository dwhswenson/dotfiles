" Vim color file
" Maintainer:	David W.H. Swenson
" Last Change:	20 November 2011

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "dwhs"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

" GUI
"highlight Normal     guifg=Grey80	guibg=Black
"highlight Search     guifg=Black	guibg=Red	gui=bold
"highlight Visual     guifg=#404040			gui=bold
"highlight Cursor     guifg=Black	guibg=Green	gui=bold
"highlight Special    guifg=Orange
"highlight Comment    guifg=#80a0ff
"highlight StatusLine guifg=blue		guibg=white
"highlight Statement  guifg=Yellow			gui=NONE
"highlight Type						gui=NONE

" Console
hi Normal       ctermfg=LightGrey	ctermbg=Black
hi String       ctermfg=DarkRed         cterm=NONE term=NONE
hi Constant     ctermfg=DarkRed         cterm=NONE term=NONE
hi Search       ctermfg=Black	ctermbg=Red	cterm=NONE
hi Visual					cterm=reverse
hi Special      ctermfg=DarkMagenta             cterm=NONE
hi PreProc      ctermfg=DarkMagenta             cterm=NONE
hi Comment      ctermfg=DarkBlue                cterm=NONE
hi StatusLine   ctermfg=White	ctermbg=Black
hi StatusLineNC ctermfg=Black   ctermbg=White   cterm=bold
hi Statement    ctermfg=Yellow   cterm=NONE term=NONE
hi Type	        ctermfg=Green			cterm=NONE
hi Todo         ctermfg=LightGrey       ctermbg=DarkBlue
hi Include      ctermfg=DarkMagenta             cterm=NONE
"hi Todo         ctermfg=Black       ctermbg=Yellow
hi Error        ctermfg=LightGrey   ctermbg=DarkRed
hi Title        ctermfg=Magenta
hi Identifier   ctermfg=Cyan cterm=NONE
hi Ignored      ctermfg=Grey

hi cNextTask    ctermfg=Black  ctermbg=Yellow  

hi Pmenu        ctermfg=Black  ctermbg=Grey

hi DiffAdd     cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffDelete  cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffChange  cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffText    cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
