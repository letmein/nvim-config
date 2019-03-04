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
" colorscheme OceanicNext

autocmd BufNewFile,BufReadPost *.coffee,*.slim,*.pug setlocal sw=2 tabstop=2 expandtab
autocmd BufNewFile,BufReadPost *.elm setlocal sw=4 tabstop=4 expandtab
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

highlight ExtraWhitespace guibg=#660000
match ExtraWhitespace /\s\+$/

let g:jsx_ext_required = 0

let g:rspec_command = ':call RunMySpecs("{spec}")'

let g:dbext_default_profile_PG_retro = 'type=PGSQL:user=postgres:dbname=retro_dev'
let g:dbext_default_profile = 'PG_retro'

let g:airline_theme='luna'

let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#303b4c'

let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 1
let g:elm_make_show_warnings = 1

let g:gitgutter_map_keys = 0

let g:mix_format_on_save = 1

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

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "match:fg:255,0,0" --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" -------------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'mileszs/ack.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/kchmck/vim-coffee-script'
Plug 'https://github.com/slim-template/vim-slim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'git://github.com/kana/vim-textobj-user.git'
Plug 'git://github.com/nelstrom/vim-textobj-rubyblock.git'
" Plug 'neomake/neomake'
Plug 'https://github.com/keith/rspec.vim'
Plug 'https://github.com/gregsexton/gitv'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'thoughtbot/vim-rspec'
Plug 'easymotion/vim-easymotion'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
" Plug 'Zaptic/elm-vim'
Plug '~/src/elm-vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rhubarb'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'posva/vim-vue'
Plug 'majutsushi/tagbar'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'mhinz/vim-mix-format'
Plug 'awetzel/elixir.nvim', { 'do': './install.sh' }

call plug#end()

let g:jsx_ext_required = 1

let g:gitgutter_map_keys = 0


" call neomake#configure#automake('nrwi', 500)


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
" let g:airline_section_b = ''

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


nnoremap <silent> <CR> :noh<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Show diff between 2 splits
nnoremap <silent> <Leader>ds :call DiffToggle()<CR>

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

function! s:ExecGitCommand(cmd)
  execute g:fuzzy_git_commands[a:cmd]
endfunction

function! s:ChangeGitBranch(branch)
  execute '!git checkout ' . a:branch
endfunction

command! Gbranch call fzf#run({'source': 'git branch', 'sink': function('<sid>ChangeGitBranch'),  'down': '10'})

nnoremap <silent> <Leader>g :call fzf#run({'source': sort(keys(g:fuzzy_git_commands)), 'sink': function('<sid>ExecGitCommand'), 'down': '10'})<CR>

" RSpec.vim mappings
nnoremap <silent> <Leader>r :call SimpleMenu('RSpec:', [
    \  ['r', 'current file', ':call RunCurrentSpecFile()'],
    \  ['s', 'nearest example', ':call RunNearestSpec()'],
    \  ['l', 'last spec', ':call RunLastSpec()'],
    \  ['a', 'all specs', ':call RunAllSpecs()']
    \])<CR>

nnoremap <silent> <Leader>e :call SimpleMenu('AcceptanceTests:', [
    \  ['r', 'current file', ':split \| terminal COV=NO rspec %'],
    \  ['f', 'focused scenarios', ':split \| terminal COV=NO rspec --tag focus %'],
    \  ['n', 'no headless focused scenarios', ':split \| terminal COV=NO NO_HEADLESS=1 rspec --tag focus %']
    \])<CR>

" Configs
nnoremap <silent> <Leader>c :call SimpleMenu('Configs:', [
    \  ['v', 'nvim', ':e ~/.config/nvim/init.vim'],
    \  ['z', 'zsh', ':e ~/.zshrc']
    \])<CR>

nnoremap <silent> <Leader>f :call SimpleMenu('Files:', [
    \  ['s', 'find by contents', ':Rg'],
    \  ['f', 'find by filename', ':FZF'],
    \  ['b', 'buffers', ':Buffers'],
    \  ['d', 'remove current file', ':call RemoveCurrentFile()'],
    \  ['r', 'rename current file', ':call RenameCurrentFile()']
    \])<CR>

nnoremap <silent> <Leader>a :call SimpleMenu('ALE:', [
    \  ['d', 'Go to definition', ':ALEGoToDefinition'],
    \  ['n', 'Next', ':ALENext'],
    \  ['p', 'Previous', ':ALEPrevious']
    \])<CR>

nnoremap <silent> <Leader>t :TagbarToggle<CR>

nnoremap <Leader>w <C-W>

" Copy selection to the global buffer
vnoremap <Leader>ys "+y
" Copy the current filename
nnoremap <silent> <Leader>yf :let @+ = expand('%')<CR>

" Past from the global buffer
nnoremap <Leader>p "+p

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

nnoremap <silent> <Leader>m :Marks<CR>

