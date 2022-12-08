local telescope = require('telescope')

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
  pickers = {
    find_files = {
      -- theme = "dropdown",
    }
  },
  defaults = {
    file_ignore_patterns = {
--      "./vendor/cache/",
      "public",
--      "./app/assets/images/",
    },
    mappings = {
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
      }
    },
  },
}

telescope.load_extension('fzf')

-- vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>fh', ':Telescope buffers<CR>', { noremap = true, silent = true })

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  text = string.gsub(text, "%(", "\\(")
  text = string.gsub(text, "%.", "\\.")
  if #text > 0 then
    return text
  else
    return ''
  end
end


local keymap = vim.keymap.set
local tb = require('telescope.builtin')
local opts = { noremap = true, silent = true }

keymap('n', '<space>F', ':Telescope current_buffer_fuzzy_find<cr>', opts)

--[[ 
  keymap('v', '<space>f', function()
  local text = vim.getVisualSelection()
  tb.current_buffer_fuzzy_find({ default_text = text })
end, opts)
--]]

keymap('n', '<space>f', ':lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', opts)
keymap('v', '<space>f', function()
  local text = vim.getVisualSelection()
  tb.live_grep({ default_text = text })
end, opts)
