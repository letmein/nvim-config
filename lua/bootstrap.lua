require('plugins')
require('plugins.lspc')
require('plugins.telescope')
require('plugins.cmp')
require('plugins.tabnine')
require('plugins.treesitter')
require('plugins.nvim-tree')

require('lualine').setup()

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

