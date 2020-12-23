if !exists('g:vscode')
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

filetype plugin on
filetype indent on

syntax on

"set hlsearch
:set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
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

let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#303b4c'

let g:elm_setup_keybindings = 0
let g:elm_format_autosave = 1
let g:elm_make_show_warnings = 1

let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

" -------------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'ap/vim-css-color'
Plug 'mhartington/oceanic-next'
Plug 'mcchrish/nnn.vim'
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
Plug 'janko/vim-test'
Plug 'easymotion/vim-easymotion'
Plug 'pangloss/vim-javascript'
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
Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'rhysd/git-messenger.vim'
Plug 'gregsexton/gitv'
Plug 'andys8/vim-elm-syntax'
Plug 'superDross/ticket.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'kbrw/elixir.nvim'
Plug 'leafoftree/vim-svelte-plugin'
" vim-devicons must go last!
Plug 'ryanoasis/vim-devicons'

call plug#end()

let g:jsx_ext_required = 1

let test#elm#elmtest#options = '--compiler node_modules/.bin/elm'
let test#strategy = 'neovim'

let g:elixir_docpreview=1
let g:elixir_showerror=1
let g:elixir_autobuild=0

" -------------------------------------------------------------------
"  KEY MAPPINGS
" -------------------------------------------------------------------

" Search the selected text
vnoremap // y :Ack! "<C-R>""<CR>

cnoreabbrev Ack Ack!

nnoremap <Leader>l :Ack!<Space>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

tnoremap <Esc> <C-\><C-n>:q!<CR>

" Toggle NerdTree
nnoremap <silent> <S-Tab> :NERDTreeToggle<CR>
nnoremap <silent> <Leader><Tab> :NERDTreeFind<CR>

nnoremap <silent> <CR> :noh<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Show diff between 2 splits
nnoremap <silent> <Leader>ds :call DiffToggle()<CR>

" RSpec.vim mappings
nnoremap <silent> <Leader>r :call SimpleMenu('Test:', [
    \  ['r', 'current file', ':TestFile'],
    \  ['s', 'nearest example', ':TestNearest'],
    \  ['l', 'last spec', ':TestLast'],
    \  ['a', 'all specs', ':TestSuite'],
    \  ['v', 'visit last', ':TestVisit']
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
" Copy the current filename + line number
nnoremap <silent> <Leader>yn :let @+ = expand('%') . ':' . line('.')<CR>

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
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>o :CocList outline<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <leader>nn <Plug>(coc-rename)
nmap ]e <Plug>(coc-diagnostic-next)
nmap [e <Plug>(coc-diagnostic-prev)
nmap <C-s> <Plug>(coc-range-select)

" -------------------------------------------------------------------
" GitMessenger
" -------------------------------------------------------------------

let g:git_messenger_always_into_popup=v:true
let g:git_messenger_no_default_mappings=v:true
endif
