return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup({
        enable = true,
        debug = false
      })
    end
  }
  use 'RRethy/nvim-treesitter-endwise'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }

  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use 'pechorin/any-jump.vim'

  use 'rhysd/git-messenger.vim'
  use 'tpope/vim-fugitive'

  use 'github/copilot.vim'

  use 'ap/vim-css-color'
  use 'Yggdroot/indentLine'
  use 'https://github.com/keith/rspec.vim'
  use 'MarcWeber/vim-addon-mw-utils'
  use 'tomtom/tlib_vim'
  use 'janko/vim-test'
  use 'folke/flash.nvim'
  use 'pangloss/vim-javascript'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-rhubarb'
  use 'rottencandy/vimkubectl'
  use 'lmintmate/blue-mood-vim'

  use 'neovim/nvim-lspconfig'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup()
    end
  }
  use 'kyazdani42/nvim-web-devicons'
end)

