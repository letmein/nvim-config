function! DiffToggle()
  if &diff
    windo diffoff
  else
    windo diffthis
  endif
endfunction
