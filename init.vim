let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

filetype plugin on
filetype indent on

syntax on

"set hlsearch
set tabstop=2
set expandtab
set list
set listchars=tab:>.
set sw=2
set background=dark
set number
set nowrap
set ruler
set noswapfile
set cursorline

colorscheme softblue-custom

autocmd VimEnter * AirlineTheme lucius
autocmd BufNewFile,BufReadPost *.coffee,*.slim setlocal sw=2 tabstop=2 expandtab
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufWinEnter *.rb,*.coffee,*.slim let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
autocmd! BufWritePost * Neomake

highlight ExtraWhitespace guibg=#660000
match ExtraWhitespace /\s\+$/

" -------------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'https://github.com/rking/ag.vim'
Plug 'https://github.com/kchmck/vim-coffee-script'
Plug 'https://github.com/digitaltoad/vim-jade'
Plug 'https://github.com/slim-template/vim-slim'
Plug 'bling/vim-airline'
Plug 'git://github.com/kana/vim-textobj-user.git'
Plug 'git://github.com/nelstrom/vim-textobj-rubyblock.git'
Plug 'https://github.com/Shougo/unite.vim'
Plug 'https://github.com/yuku-t/unite-git'
Plug 'https://github.com/benekastah/neomake'
Plug 'https://github.com/keith/rspec.vim'

call plug#end()

" -------------------------------------------------------------------
"  FUNCTIONS
" -------------------------------------------------------------------

function! DiffToggle()
  if &diff
    windo diffoff
  else
    windo diffthis
  endif
:endfunction

function! OpenRspec()
  let current_file = expand("%")
  exec ':below new'
  exec ':terminal rspec ' . current_file
endfunction

function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AppToRspec(file_name)
  let result = substitute(a:file_name, '\.rb$', '_spec.rb', '')
  let result = substitute(result, '^app/', 'spec/', '')
  return result
endfunction

function! RspecToApp(file_name)
  let result = substitute(a:file_name, '_spec\.rb$', '.rb', '')
  let result = substitute(result, '^spec/', 'app/', '')
  return result
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  if match(current_file, '^spec/') != -1
    return RspecToApp(current_file)
  else
    return AppToRspec(current_file)
  endif
endfunction

" -------------------------------------------------------------------
"  KEY MAPPINGS
" -------------------------------------------------------------------

" Toggle NerdTree
nnoremap <silent> <S-Tab> :NERDTreeToggle<CR>

" Open the buffer list
nnoremap <Leader>b :Unite buffer<CR>

" Search files
nnoremap <Leader>f :Unite -start-insert git_cached<CR>

nnoremap <Leader>w <Esc>:wa<CR>
nnoremap <Leader>c <Esc>:bd!<CR>

" Turn off the search highlighting on enter
" still buggy in nvim, thus disabled
" nmap <CR> :noh<CR><CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Show diff between 2 splits
nnoremap <silent> <Leader>d :call DiffToggle()<CR>

" Insert the current filename with full path
inoremap \fn <C-R>=expand("%:p")<CR>

nnoremap <Leader>r :call OpenRspec()<CR>

" Search the selected text with Ag
vnoremap // y :Ag <C-R>"<CR>

" Switch between a Ruby class and its spec
nnoremap <Leader>a :call OpenTestAlternate()<CR>
