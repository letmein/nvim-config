require('nvim-treesitter.configs').setup {
    endwise = {
        enable = true,
    },
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "ruby",
      "elixir",
      "erlang",
      "eex",
      "heex",
      "comment",
      "json",
      "yaml",
      "javascript",
      "go",
      "svelte",
    },
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = { "javascript" },
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      -- list of language that will be disabled
      disable = { "c", "rust" },
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>',
        scope_incremental = '<CR>',
        node_incremental = '<TAB>',
        node_decremental = '<S-TAB>',
      },
    },
}
