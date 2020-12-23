let g:airline_theme='luna'

" MODE
let g:airline_section_a = ''

" Git
" let g:airline_section_b = ''

" Filename
let g:airline_section_c = airline#section#create(['%m ', '%f'])

" Filetype (default)
" let g:airline_section_x = ''

" Encoding
let g:airline_section_y = ''

let g:airline_section_z = airline#section#create(['%l/%L:%c'])
