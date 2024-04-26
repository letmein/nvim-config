vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.lsp.start {
      name = "rubocop",
      cmd = { "bundle", "exec", "rubocop", "--lsp" },
      root_dir = vim.fs.dirname(vim.fs.find({'Gemfile', '.git'}, { upward = true })[1]),
    }
    vim.lsp.start {
      name = "solargraph",
      cmd = { "bundle", "exec", "solargraph", "stdio" },
      root_dir = vim.fs.dirname(vim.fs.find({'Gemfile', '.git'}, { upward = true })[1]),
    }
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "elixir",
  callback = function()
    vim.lsp.start {
      name = "elixir-ls",
      cmd = { "elixir-ls" },
      root_dir = vim.fs.dirname(vim.fs.find({'mix.exs', '.git'}, { upward = true })[1]),
    }
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = function()
    vim.lsp.start {
      name = "svelteserver",
      cmd = { "svelteserver", "--stdio" },
      root_dir = vim.fs.dirname(vim.fs.find({'package.json', '.git'}, { upward = true })[1]),
    }
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.lsp.start {
      name = "gopls",
      cmd = { "gopls" },
      root_dir = vim.fs.dirname(vim.fs.find({'main.go', '.git'}, { upward = true })[1]),
    }
  end,
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<space>h', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
