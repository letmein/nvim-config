" Vim color file
" inspired by softblue @ Zhang Jing

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name="softblue-custom"

" TODO: map colors to the scheme
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#9b60be'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

hi Normal       guibg=#183058   guifg=gray85

hi ALEWarningSign guifg=#183058
hi ALEErrorSign guifg=#183058

hi Search       guibg=#787878   guifg=wheat
hi SpecialKey   guifg=yellowgreen
hi StatusLine   guibg=#466292   guifg=black     gui=none
hi StatusLineNC guibg=#466292   guifg=grey22    gui=none
hi SignColumn   guibg=#183068
hi Title        guifg=#38d9ff
hi Visual       guifg=lightblue guibg=#001146   gui=none
hi WarningMsg   guifg=salmon
hi ErrorMsg     guifg=white     guibg=#b2377a
hi Function     guifg=CornflowerBlue
hi rubySymbol   guifg=plum
hi Folded       guibg=#183058

hi Comment      guifg=SlateGray4
hi Constant     guifg=orchid
hi Identifier   guifg=#00ac55
hi Statement    guifg=SkyBlue2
hi PreProc      guifg=#20a0d0
hi Type         guifg=LightSlateBlue gui=bold
hi Special      guifg=#b6a040"wheat4"#7c9cf5"a2b9e0
hi Ignore       guifg=grey40
hi Error        guifg=white     guibg=#b2377a
hi Todo         guifg=#54b900   guibg=#622098   gui=bold

hi Pmenu        guifg=#6d6d6d   guibg=#002244
hi PmenuSel     guifg=#5d5d5d   guibg=#001133

hi LineNr       guibg=#172957 guifg=SkyBlue4
hi CursorLineNr guifg=SkyBlue3 gui=bold
hi CursorLine   guibg=#002244

hi EndOfBuffer guifg=bg
