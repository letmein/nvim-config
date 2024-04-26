local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")
local lga_shortcuts = require("telescope-live-grep-args.shortcuts")

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
  },
  pickers = {
    find_files = {
      -- theme = "dropdown",
    },
    marks = {
    }
  },
  defaults = {
    file_ignore_patterns = {
      "vendor/cache/*",
      "app/assets/images/",
    },
    mappings = {
      i = {
        ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        ["<C-k>"] = lga_actions.quote_prompt(),
        ['<C-d>'] = require('telescope.actions').delete_buffer,
      }
    },
  },
}

telescope.load_extension('fzf')

