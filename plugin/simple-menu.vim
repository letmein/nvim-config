function! SimpleMenu(title, options)
  let l:choice_map = {}

  echo a:title

  for choice in a:options
    let l:key = choice[0]
    let l:choice_map[l:key] = choice[2]

    echohl Boolean
    echon ' [' . l:key . '] '
    echohl None
    echon choice[1] . ' '
  endfor

  let l:response = nr2char(getchar())

  redraw!

  if has_key(l:choice_map, l:response)
    execute l:choice_map[l:response]
  endif
endfunction
