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
set tags=.tags
set hidden
set iskeyword+=-
set encoding=UTF-8

language messages en_US.UTF-8

if exists('g:vscode')
    " VSCode stuff

  call plug#begin('~/.config/nvim/plugged')

  Plug 'asvetliakov/vim-easymotion'

  call plug#end()

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

else

  colorscheme softblue-custom
  " colorscheme OceanicNext

  autocmd BufNewFile,BufReadPost *.coffee,*.slim,*.pug setlocal sw=2 tabstop=2 expandtab
  autocmd BufNewFile,BufReadPost *.elm setlocal sw=4 tabstop=4 expandtab
  autocmd BufWinEnter *.json setlocal conceallevel=0
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
  autocmd FileType erb set omnifunc=htmlcomplete#CompleteTags


  highlight ExtraWhitespace guibg=#660000
  match ExtraWhitespace /\s\+$/

  let g:jsx_ext_required = 0

  let g:rspec_command = ':call RunMySpecs("{spec}")'

  let g:airline_theme='luna'

  let g:indentLine_char = '▏'
  let g:indentLine_color_gui = '#303b4c'

  let g:elm_setup_keybindings = 0
  let g:elm_format_autosave = 1
  let g:elm_make_show_warnings = 1

  let g:mix_format_on_save = 1

  " -------------------------------------------------------------------
  "  PLUGINS
  " -------------------------------------------------------------------

  call plug#begin('~/.config/nvim/plugged')

  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/vim-easy-align'
  Plug 'Yggdroot/indentLine'
  Plug 'mileszs/ack.vim'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'git://github.com/kana/vim-textobj-user.git'
  Plug 'git://github.com/nelstrom/vim-textobj-rubyblock.git'
  " Syntax highlighting for RSpec
  Plug 'https://github.com/keith/rspec.vim'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'thoughtbot/vim-rspec'
  Plug 'easymotion/vim-easymotion'
  Plug 'pangloss/vim-javascript'
  Plug 'w0rp/ale'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rbenv'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rhubarb'
  " Plug 'posva/vim-vue'
  Plug 'leafOfTree/vim-vue-plugin'
  Plug 'majutsushi/tagbar'
  Plug 'philip-karlsson/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'mattn/emmet-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'rhysd/git-messenger.vim'
  Plug 'gregsexton/gitv'
  Plug 'andys8/vim-elm-syntax'
  Plug 'superDross/ticket.vim'
  " vin-devicons must go last!
  Plug 'ryanoasis/vim-devicons'

  call plug#end()

  let g:jsx_ext_required = 1

  let config_path = '~/.config/nvim/'
  execute 'source' config_path . 'fzf.vim'

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
    execute 'split | terminal SKIP_COVERAGE_REPORT=1 bundle exec rspec ' . a:specs
    " Prevent closing the terminal on any key press
    " execute feedkeys("\<c-\>\<c-n>")
  endfunction

  tnoremap <Esc> <C-\><C-n>:q!<CR>

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
  nnoremap <silent> <Leader><Tab> :NERDTreeFind<CR>


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


  " RSpec.vim mappings
  nnoremap <silent> <Leader>r :call SimpleMenu('RSpec:', [
      \  ['r', 'current file', ':call RunCurrentSpecFile()'],
      \  ['s', 'nearest example', ':call RunNearestSpec()'],
      \  ['l', 'last spec', ':call RunLastSpec()'],
      \  ['a', 'all specs', ':call RunAllSpecs()'],
      \  ['b', 'in browser', ':split \| terminal JS_DRIVER=selenium_chrome rspec %']
      \])<CR>

  nnoremap <silent> <Leader>a :call SimpleMenu('ALE:', [
      \  ['d', 'Detail', ':ALEDetail'],
      \  ['n', 'Next', ':ALENext'],
      \  ['p', 'Previous', ':ALEPrevious']
      \])<CR>

  nnoremap <Leader>ff :Files<CR>
  nnoremap <Leader>fs :Rg<CR>
  nnoremap <Leader>fb :Buffers<CR>
  nnoremap <silent> <Leader>fd :call RemoveCurrentFile()<CR>
  nnoremap <silent> <Leader>fr :call RenameCurrentFile()<CR>
  nnoremap <silent> <Leader>fq :call OpenQuickConfigs()<CR>

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

  " nmap <Leader>s <Plug>(AerojumpBolt)



  function! UpdateRubyTags()
    execute '!ctags -f .tags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)'
  endfunction

  command! UpdateRubyTags
    \ call UpdateRubyTags()

  " -------------------------------------------------------------------
  " CoC
  " -------------------------------------------------------------------

  let g:coc_global_extensions = ['coc-solargraph']
  let g:coc_snippet_next = '<tab>'

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> go :CocList outline<CR>
  nmap <silent> gr <Plug>(coc-references)
  nmap <leader>nn <Plug>(coc-rename)

  " -------------------------------------------------------------------
  " GitMessenger
  " -------------------------------------------------------------------

  let g:git_messenger_always_into_popup=v:true
  let g:git_messenger_no_default_mappings=v:true
endif
