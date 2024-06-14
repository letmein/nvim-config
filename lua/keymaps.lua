-- -----------------
-- Global keymaps
-- -----------------

vim.keymap.set('n', '<Space>', '<Leader>', { noremap = false })

vim.keymap.set('n', '<Leader>w', '<C-W>', { silent = true })

-- Copy selection to the global buffer
vim.keymap.set('v', '<Leader>ys', '"+y', { silent = true })

-- Copy the current filename
vim.keymap.set('n', '<Leader>yf', ':let @+ = expand("%")<CR>', { silent = true })

-- Copy the current filename + line number
vim.keymap.set('n', '<Leader>yn', ':let @+ = expand("%") . ":" . line(".")<CR>', { silent = true })

-- Diff splits
vim.keymap.set('n', '<Leader>d', function()
  if vim.opt.diff:get() then
    vim.cmd('windo diffoff')
  else
    vim.cmd('windo diffthis')
  end
end, { silent = true })

-- Disagnostics
vim.keymap.set('n', '<Leader>e', function()
  vim.print('Diagnostics: [>] next  [<] prev  [o] open  [l] list')
  map_keys({
    ['>'] = vim.diagnostic.goto_next,
    ['<'] = vim.diagnostic.goto_prev,
    ['o'] = vim.diagnostic.open_float,
    ['l'] = vim.diagnostic.setloclist,
  })
end)

-- Git mappings
vim.keymap.set('n', '<Leader>g', function()
  vim.print('Git: [b] branches  [l] blame line  [a] blame all  [g] browse  [s] status')

  local tb = require("telescope.builtin")
  map_keys({
    ['b'] = tb.git_branches,
    ['s'] = tb.git_status,
    ['l'] = function() vim.cmd(':GitMessenger') end,
    ['a'] = function() vim.cmd(':Git blame') end,
    ['g'] = function() vim.cmd(':GBrowse') end,
  })
end)

-- Flash
local flash = require('flash')
vim.keymap.set('n', 's', flash.jump)
--[[
flash.jump({
  pattern = vim.fn.expand("<cword>"),
})
]]--

function map_keys(mapping)
  local key = vim.fn.nr2char(vim.fn.getchar())
  local cmd = mapping[key]

  if cmd then
    cmd()
  end

  vim.print('')
end

