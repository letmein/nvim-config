return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'RRethy/nvim-treesitter-endwise'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope.nvim'

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use { 'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp' }

  use 'pechorin/any-jump.vim'
  use 'rhysd/git-messenger.vim'

  use 'ap/vim-css-color'
  use 'scrooloose/nerdtree'
  use 'tpope/vim-fugitive'
  use 'junegunn/vim-easy-align'
  use 'Yggdroot/indentLine'
  use 'https://github.com/kana/vim-textobj-user.git'
  use 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
  use 'https://github.com/keith/rspec.vim'
  use 'MarcWeber/vim-addon-mw-utils'
  use 'tomtom/tlib_vim'
  use 'janko/vim-test'
  use 'easymotion/vim-easymotion'
  use 'pangloss/vim-javascript'
  use 'tpope/vim-rails'
  use 'tpope/vim-rhubarb'
  use 'nvim-lua/lsp-status.nvim'
end)

