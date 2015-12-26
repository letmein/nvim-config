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
autocmd! BufWritePost *.jade call MonitorJadeIncludes()

highlight ExtraWhitespace guibg=#660000
match ExtraWhitespace /\s\+$/

let g:rspec_command = ":terminal rspec {spec}"

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
Plug 'https://github.com/gregsexton/gitv'
Plug 'elzr/vim-json'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'thoughtbot/vim-rspec'

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
endfunction

function! MonitorJadeIncludes()
  let current_file = expand('%:t')
  let current_dir  = expand('%:p:h')
  if current_file =~ '^_'
    exec ':silent !find ' . current_dir . ' -name *.jade | xargs grep -l "include ./' . current_file . '" | xargs touch'
  endif
endfunction

function! AlternateForRuby(file_name)
  if a:file_name =~ '^spec/'
    let result = substitute(a:file_name, '_spec\.rb$', '.rb', '')
    return substitute(result, '^spec/', 'app/', '')
  else
    let result = substitute(a:file_name, '\.rb$', '_spec.rb', '')
    return substitute(result, '^app/', 'spec/', '')
  endif
endfunction

function! AlternateForCoffee(file_name)
  if a:file_name =~ '^ui/spec/unit/'
    let result = substitute(a:file_name, '_spec\.coffee$', '.coffee', '')
    return substitute(result, '^ui/spec/unit/', 'ui/assets/javascripts/', '')
  else
    let result = substitute(a:file_name, '\.coffee$', '_spec.coffee', '')
    return substitute(result, '^ui/assets/javascripts/', 'ui/spec/unit/', '')
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

" -------------------------------------------------------------------
"  KEY MAPPINGS
" -------------------------------------------------------------------

" Toggle NerdTree
nnoremap <silent> <S-Tab> :NERDTreeToggle<CR>

" Open the buffer list
nnoremap <Leader>b :Unite buffer<CR>

" Search files
nnoremap <Leader>f :Unite -start-insert git_cached<CR>

nnoremap <Leader>w :wa<CR>
nnoremap <Leader><Esc> :bd!<CR>

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
nnoremap <silent> <Leader>gl :Gitv<CR>

" RSpec.vim mappings
map <Leader>rr :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

" Copy selection to the global buffer
vnoremap <Leader>ys "+y
" Copy the current filename
nnoremap <silent> <Leader>yf :let @+ = expand('%')<CR>

" Past from the global buffer
nnoremap <Leader>p "+p

" Search the selected text with Ag
vnoremap // y :Ag <C-R>"<CR>

" Switch between a Ruby class and its spec
nnoremap <Leader>a :call OpenAlternate(expand('%'))<CR>
