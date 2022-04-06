if exists('g:vscode')

call plug#begin('~/.config/nvim/plugged')

Plug 'asvetliakov/vim-easymotion'
Plug 'https://github.com/kana/vim-textobj-user.git'
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git'

call plug#end()

else

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

filetype plugin on
filetype indent on

syntax on
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
set iskeyword+=-

language messages en_US.UTF-8

colorscheme softblue-custom

autocmd BufNewFile,BufReadPost *.elm setlocal sw=4 tabstop=4 expandtab
autocmd BufWinEnter *.json setlocal conceallevel=0
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd FileType erb set omnifunc=htmlcomplete#CompleteTags

" Do not close :term buffer after process exit.
" https://vi.stackexchange.com/questions/17816/solved-ish-neovim-dont-close-terminal-buffer-after-process-exit
au TermOpen  * setlocal nonumber | startinsert
au TermClose * setlocal   number | call feedkeys("\<C-\>\<C-n>")

highlight ExtraWhitespace guibg=#660000
match ExtraWhitespace /\s\+$/

let test#elm#elmtest#options = '--compiler node_modules/.bin/elm'
let test#strategy = 'neovim'

" -------------------------------------------------------------------
"  KEY MAPPINGS
" -------------------------------------------------------------------

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-s2)

map <Space> <Leader>

nnoremap <silent> <Leader>t :call
      \ SimpleMenu('Test:', [
      \   ['f', 'current file', ':TestFile'],
      \   ['s', 'nearest example', ':TestNearest'],
      \   ['l', 'last spec', ':TestLast'],
      \   ['a', 'all specs', ':TestSuite'],
      \   ['v', 'visit last', ':TestVisit']
      \ ])<CR>

nnoremap <silent> <Leader>g :call
      \ SimpleMenu('Git:', [
      \   ['b', 'branches', ':Telescope git_branches'],
      \   ['l', 'blame line', ':GitMessenger'],
      \   ['c', 'commits', ':Telescope git_commits'],
      \   ['f', 'blame all', ':Git blame'],
      \   ['g', 'github', ':GBrowse'],
      \   ['s', 'status', ':Telescope git_status'],
      \ ])<CR>

nnoremap <silent> <Leader>f :call
      \ SimpleMenu('Files:', [
      \   ['f', 'by name', ':Telescope find_files'],
      \   ['b', 'buffers', ':Telescope buffers'],
      \   ['h', 'history', ':Telescope oldfiles'],
      \   ['q', 'quick list', ':call OpenQuickConfigs()'],
      \   ['w', 'find word', ':Telescope grep_string'],
      \   ['g', 'live grep', ':Telescope live_grep'],
      \ ])<CR>

tnoremap <Esc> <C-\><C-n>:q!<CR>

" Toggle NerdTree
nnoremap <silent> <S-Tab> :NERDTreeToggle<CR>
nnoremap <silent> <Leader><Tab> :NERDTreeFind<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Show diff between 2 splits
nnoremap <silent> <Leader>ds :call DiffToggle()<CR>

nnoremap <Leader>w <C-W>

" Copy selection to the global buffer
vnoremap <Leader>ys "+y
" Copy the current filename
nnoremap <silent> <Leader>yf :let @+ = expand('%')<CR>
" Copy the current filename + line number
nnoremap <silent> <Leader>yn :let @+ = expand('%') . ':' . line('.')<CR>

" Past from the global buffer
nnoremap <Leader>p "+p

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

command! UpdateRubyTags
  \ execute '!ctags -f .tags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)'

let g:git_messenger_always_into_popup=v:true
let g:git_messenger_no_default_mappings=v:true


:lua require('bootstrap')

endif
