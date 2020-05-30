" -------------------------------------------------------------------
" FZF
" -------------------------------------------------------------------

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" command! Gbranch call fzf#run({'source': 'git branch', 'sink': function('<SID>ChangeGitBranch'),  'down': '10'})
command! Gbranch call fzf#run({'source': 'git branch', 'down': '10'})

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg -g !*.log -g !*.svg --column --line-number --no-heading --color=always --colors "path:fg:0x62,0x72,0xa0" --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout!' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse'
\ }))

let g:fuzzy_git_commands = {
  \ 'status': ':Gstatus',
  \ 'browse': ':Gbrowse',
  \ 'add': ':Gwrite',
  \ 'blame': ':Gblame',
  \ 'commit': ':Gcommit',
  \ 'diff': ':Gdiff',
  \ 'ls': ':GFiles',
  \ 'checkout': ':Gread',
  \ 'branch': ':Gbranch',
  \ }

function! s:exec_git_command(cmd)
  execute g:fuzzy_git_commands[a:cmd]
endfunction

nnoremap <silent> <Leader>gg :call
  \ fzf#run({
  \   'source': sort(keys(g:fuzzy_git_commands)),
  \   'sink': function('<SID>exec_git_command'),
  \   'down': '10'}
  \ )<CR>

nnoremap <silent> <Leader>gb :GitMessenger<CR>
nnoremap <silent> <Leader>gg :call
  \ fzf#run({
  \   'source': sort(keys(g:fuzzy_git_commands)),
  \   'sink': function('<SID>exec_git_command'),
  \   'down': '10'}
  \ )<CR>


let g:fuzzy_configs = {
  \ 'vim': '~/.config/nvim/init.vim',
  \ 'zsh': '~/.zshrc',
  \ 'hammerspoon': '~/.hammerspoon/init.lua',
  \ }

function! s:open_config(cmd)
  execute 'edit ' . g:fuzzy_configs[a:cmd]
endfunction

function! OpenQuickConfigs()
  let l:fzf_args = {
    \ 'source': sort(keys(g:fuzzy_configs)),
    \ 'sink': function('<SID>open_config'),
    \ 'down': '10',
    \ }
  call fzf#run(l:fzf_args)
endfunction
