
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
vim.g.neovide_cursor_vfx_mode = "" -- https://neovide.dev/configuration.html#cursor-settings
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_confirm_quit = true
vim.opt.shell = "fish"
vim.opt.guifont = "JetBrainsMono Nerd Font:h15"
-- vim.opt.guifont = "Arian AMU Mono:h15"
-- vim.opt.guifont = "DejaVu Sans Mono:h15"

local keymap = vim.keymap.set
local telescope = require('telescope')
local tb = require('telescope.builtin')
local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
local opts = { noremap = true, silent = true }

keymap('n', '<D-1>', ':wincmd h<CR>', opts)
keymap('n', '<D-2>', ':wincmd l<CR>', opts)
keymap('n', '<D-w>', ':wincmd c<CR>', opts)
keymap('n', '<D-b>', ':NvimTreeToggle<CR>', opts)
keymap('n', '<D-e>', ':NvimTreeFindFile<CR>', opts)
keymap('n', '<D-p>', tb.find_files, opts)
keymap('n', '<D-o>', tb.buffers, opts)
keymap('n', '<D-i>', tb.treesitter, opts)
keymap('n', '<D-h>', tb.oldfiles, { silent = true })
keymap('n', '<D-m>', tb.marks, opts)
keymap('n', '<D-l>', ':TestNearest<CR>', { silent = true })
keymap('n', '<A-l>', ':TestFile<CR>', { silent = false })
keymap('n', '<D-s>', ':w<CR>', opts) -- Save
keymap('v', '<D-c>', '"+y', opts) -- Copy
keymap('n', '<D-v>', '"+P', opts) -- Paste normal mode
keymap('v', '<D-v>', '"+P', opts) -- Paste visual mode
keymap('c', '<D-v>', '<C-R>+', opts) -- Paste command mode
keymap('i', '<D-v>', '<ESC>"+Pi', opts) -- Paste insert mode
keymap('n', '<D-,>', ':e ~/.config/nvim/lua/neovide.lua<CR>', opts)
keymap('n', '<D-q>', ':echo "test"')
keymap('n', '<D-f>', telescope.extensions.live_grep_args.live_grep_args, opts)
keymap('v', '<D-f>', lga_shortcuts.grep_visual_selection, opts)
keymap('n', '<D-g>', tb.current_buffer_fuzzy_find)

