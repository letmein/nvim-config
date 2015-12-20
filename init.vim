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

" The ! overwrites any existing definition by this name.
function! DiffToggle()
  if &diff
    windo diffoff
  else
    windo diffthis
  endif
:endfunction

" Insert the current filename with full path
inoremap \fn <C-R>=expand("%:p")<CR>

nnoremap <Leader>r :terminal rspec =expand("%:p")<CR>

" Search the selected text with Ag
vnoremap // y :Ag <C-R>"<CR>
