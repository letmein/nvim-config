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
set termguicolors

language messages en_US.UTF-8

colorscheme softblue-custom

autocmd BufNewFile,BufReadPost *.coffee,*.slim,*.pug setlocal sw=2 tabstop=2 expandtab
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufWinEnter *.rb,*.coffee,*.slim,*.jade,*.pug let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
autocmd! BufWritePost * Neomake

highlight ExtraWhitespace guibg=#660000
match ExtraWhitespace /\s\+$/

let g:jsx_ext_required = 0

let g:rspec_command = ':call RunMySpecs("{spec}")'

let g:dbext_default_profile_PG_retro = 'type=PGSQL:user=postgres:dbname=retro_dev'
let g:dbext_default_profile = 'PG_retro'

let g:airline_theme='luna'

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#disable_auto_complete = 1

" -------------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'numkil/ag.nvim'
Plug 'https://github.com/kchmck/vim-coffee-script'
Plug 'https://github.com/digitaltoad/vim-jade'
Plug 'https://github.com/slim-template/vim-slim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'git://github.com/kana/vim-textobj-user.git'
Plug 'git://github.com/nelstrom/vim-textobj-rubyblock.git'
Plug 'https://github.com/Shougo/unite.vim'
Plug 'https://github.com/yuku-t/unite-git'
Plug 'https://github.com/benekastah/neomake'
Plug 'https://github.com/keith/rspec.vim'
Plug 'https://github.com/gregsexton/gitv'
Plug 'elzr/vim-json'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'thoughtbot/vim-rspec'
Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'awetzel/elixir.nvim', { 'do': './install.sh' }
"Plug 'othree/yajs.vim', { 'for': 'javascript' }
"Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
"Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
"Plug 'mxw/vim-jsx', { 'for': 'javascript' }
"Plug 'vim-scripts/dbext.vim'
Plug 'easymotion/vim-easymotion'
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'leafgarland/typescript-vim', { 'for': 'ts' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby'

call plug#end()

" -------------------------------------------------------------------
"  FUNCTIONS
" -------------------------------------------------------------------

function! RunMySpecs(specs)
  execute 'split | terminal rspec ' . a:specs
  " Prevent closing the terminal on any key press
  execute feedkeys("\<c-\>\<c-n>")
endfunction

function! DiffToggle()
  if &diff
    windo diffoff
  else
    windo diffthis
  endif
endfunction

function! AlternateForRuby(file_name)
  if a:file_name =~ '_spec\.rb$'
    let result = substitute(a:file_name, '_spec\.rb$', '.rb', '')
    return substitute(result, '^.*spec/', 'app/', '')
  else
    let result = substitute(a:file_name, '\.rb$', '_spec.rb', '')
    return substitute(result, '^.*app/', 'spec/', '')
  endif
endfunction

function! AlternateForCoffee(file_name)
  if a:file_name =~ '_spec\.coffee'
    return substitute(a:file_name, '_spec\.coffee$', '.coffee', '')
  else
    return substitute(a:file_name, '\.coffee$', '_spec.coffee', '')
  endif
endfunction

function! OpenAlternate(file_name)
  let alt_file = a:file_name
  if alt_file =~ '\.rb$'
    let alt_file = AlternateForRuby(alt_file)
  elseif alt_file =~ '\.coffee$'
    let alt_file = AlternateForCoffee(alt_file)
  endif
  exec ':e ' . alt_file
endfunction

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" -------------------------------------------------------------------
"  KEY MAPPINGS
" -------------------------------------------------------------------

" Toggle NerdTree
nnoremap <silent> <S-Tab> :NERDTreeToggle<CR>

" Open the buffer list
nnoremap <Leader>fb :Unite -start-insert buffer<CR>

" Search files
nnoremap <Leader>ff :Unite -start-insert git_cached<CR>

nnoremap <silent> <CR> :noh<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Show diff between 2 splits
nnoremap <silent> <Leader>ds :call DiffToggle()<CR>

" Fugitive git mappings
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gl :Gitv<CR>`

" RSpec.vim mappings
nnoremap <Leader>rr :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rs :call RunNearestSpec()<CR>
nnoremap <Leader>rl :call RunLastSpec()<CR>
nnoremap <Leader>ra :call RunAllSpecs()<CR>

nnoremap <Leader>w <C-W>

" Copy selection to the global buffer
vnoremap <Leader>ys "+y
" Copy the current filename
nnoremap <silent> <Leader>yf :let @+ = expand('%')<CR>

" Past from the global buffer
nnoremap <Leader>p "+p

" Search the selected text with Ag
vnoremap // y :Ag <C-R>"<CR>

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Switch between a Ruby class and its spec
nnoremap <Leader>a :call OpenAlternate(expand('%'))<CR>

inoremap <silent><expr> <C-p> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
