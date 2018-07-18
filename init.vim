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
set inccommand=nosplit

language messages en_US.UTF-8

colorscheme softblue-custom

autocmd BufNewFile,BufReadPost *.coffee,*.slim,*.pug setlocal sw=2 tabstop=2 expandtab
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" Highlight long strings
" autocmd BufWinEnter *.rb,*.coffee,*.slim,*.jade,*.pug let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
autocmd! BufWritePost * Neomake

highlight ExtraWhitespace guibg=#660000
match ExtraWhitespace /\s\+$/

let g:jsx_ext_required = 0

let g:rspec_command = ':call RunMySpecs("{spec}")'

let g:dbext_default_profile_PG_retro = 'type=PGSQL:user=postgres:dbname=retro_dev'
let g:dbext_default_profile = 'PG_retro'

let g:airline_theme='luna'

" -------------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'mileszs/ack.vim'
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
Plug 'gregsexton/gitv', {'on': ['Gitv']}

call plug#end()

" -------------------------------------------------------------------
"  Ack
" -------------------------------------------------------------------

" Search the selected text
vnoremap // y :Ack! "<C-R>""<CR>

cnoreabbrev Ack Ack!

nnoremap <Leader>l :Ack!<Space>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" -------------------------------------------------------------------
"  File management
" -------------------------------------------------------------------

nnoremap <Leader>fd :call RemoveCurrentFile()<CR>
nnoremap <leader>fr :call RenameCurrentFile()<cr>

function! RemoveCurrentFile()
  let filename = expand('%')
  if confirm('Remove "' . filename . '"?')
    call delete(filename)
    bdelete!
  endif
endfunction

function! RenameCurrentFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
      exec ':saveas ' . new_name
      exec ':silent !rm ' . old_name
      redraw!
  endif
endfunction

" -------------------------------------------------------------------
"  FUNCTIONS
" -------------------------------------------------------------------

function! RunMySpecs(specs)
  execute 'split | terminal bundle exec rspec ' . a:specs
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

function! AlternateForMailer(file_name)
  let template_dir = substitute(a:file_name, 'app\/mailers\/', 'app/views/', '')
  let template_dir = substitute(template_dir, '_mailer.rb$', '_mailer/', '')

  let opts = "&Spec"
  let templates = split(globpath(template_dir, '*'), '\n')

  for filename in templates
    let opts = opts . "\n&" . split(filename, '/')[-1]
  endfor

  let choice = confirm("Open alternative", opts, 1)
  if choice == 1
    return AlternateForRuby(a:file_name)
  elseif choice == 2
    return templates[choice - 2]
  endif
endfunction

function! AlternateForMailerView(file_name)
  let mailer_name = substitute(a:file_name, 'app\/views\/', 'app/mailers/', '')
  let mailer_name = substitute(mailer_name, '_mailer\/.*$', '_mailer.rb', '')

  let choice = confirm("Open alternative", "&Mailer\n&Spec", 1)
  if choice == 1
    return mailer_name
  elseif choice == 2
    return AlternateForRuby(mailer_name)
  endif
endfunction

function! OpenAlternate(file_name)
  let alt_file = a:file_name
  if alt_file =~ 'app\/mailers\/.*_mailer.rb$'
    let alt_file = AlternateForMailer(alt_file)
  elseif alt_file =~ 'app\/views\/.*_mailer\/'
    let alt_file = AlternateForMailerView(alt_file)
  elseif alt_file =~ '\.rb$'
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
"  Airline
" -------------------------------------------------------------------

" MODE
let g:airline_section_a = ''

" Git
let g:airline_section_b = ''

" Filename
let g:airline_section_c = airline#section#create(['%m ', '%f'])

" Filetype (default)
" let g:airline_section_x = ''

" Encoding
let g:airline_section_y = ''

let g:airline_section_z = airline#section#create(['%l/%L:%c'])

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

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Switch between a Ruby class and its spec
nnoremap <silent> <Leader>a :call OpenAlternate(expand('%'))<CR>
