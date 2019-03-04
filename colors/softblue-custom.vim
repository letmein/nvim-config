" Vim color file
" inspired by softblue @ Zhang Jing

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name="softblue-custom"

hi Normal       guibg=#183058   guifg=#b0b0e0

hi Cursor       guibg=#b3b2df   guifg=grey30    gui=bold
hi VertSplit    guibg=#183058   guifg=grey50    gui=none
hi Folded       guibg=#0d2349   guifg=lightblue
hi FoldColumn   guibg=#0d2349   guifg=lightblue
hi IncSearch    guifg=slategrey guibg=khaki
hi LineNr       guifg=grey30    guibg=#183068
hi ModeMsg      guifg=SkyBlue
hi MoreMsg      guifg=SeaGreen
hi NonText      guifg=LightBlue guibg=#0d2349
hi Question     guifg=#487cc4
hi Search       guibg=#787878   guifg=wheat
hi SpecialKey   guifg=yellowgreen
hi StatusLine   guibg=#466292   guifg=black     gui=none
hi StatusLineNC guibg=#466292   guifg=grey22    gui=none
hi SignColumn   guibg=#183068
hi Title        guifg=#38d9ff
hi Visual       guifg=lightblue guibg=#001146   gui=none
hi WarningMsg   guifg=salmon
hi ErrorMsg     guifg=white     guibg=#b2377a

hi Comment      guifg=#6279a0
hi Constant     guifg=#9b60be
hi Identifier   guifg=#00ac55
hi Statement    guifg=SkyBlue2
hi PreProc      guifg=#20a0d0
hi Type         guifg=#8070ff
hi Special      guifg=#b6a040"wheat4"#7c9cf5"a2b9e0
hi Ignore       guifg=grey40
hi Error        guifg=white     guibg=#b2377a
hi Todo         guifg=#54b900   guibg=#622098   gui=bold

hi Pmenu        guifg=#6d6d6d   guibg=#002244
hi PmenuSel     guifg=#5d5d5d   guibg=#001133

hi CursorLineNr guifg=#6d6d6d
hi CursorLine   guibg=#002244
