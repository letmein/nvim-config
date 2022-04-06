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
      "./vendor/cache/",
      "./public/",
      "./app/assets/images/",
    },
    mappings = {
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
      }
    },
  },
}

telescope.load_extension('fzf')

