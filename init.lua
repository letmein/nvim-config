require('plugins')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.lspc')
require('plugins.nvim-tree')
require('plugins.cmp')
require('keymaps')
require('terminal')

if vim.g.neovide then
  require('neovide')
end

vim.o.signcolumn = "yes:1"
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.encoding = 'UTF-8'
vim.o.number = true
vim.o.wrap = false
vim.o.ruler = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.list = true
vim.o.listchars = 'tab:>.'
vim.o.sw = 2
vim.o.background = 'dark'
vim.o.inccommand = 'nosplit'
vim.o.tags = '.tags'
vim.o.hidden = true
vim.o.conceallevel = 0

vim.g.indentLine_char = '▏'
vim.g.indentLine_color_gui = '#303b4c'
vim.g.vsnip_snippet_dir = '~/src/'

vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_no_default_mappings = true
vim.g['test#strategy'] = 'neovim'

vim.cmd 'colorscheme softblue-custom'

