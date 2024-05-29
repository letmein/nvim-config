
-- Disable line numbers and start insert mode when opening a terminal
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt_local.number = false
        vim.cmd("startinsert")
    end
})

-- Do not close :term buffer after process exit.
-- https://vi.stackexchange.com/questions/17816/solved-ish-neovim-dont-close-terminal-buffer-after-process-exit
vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*",
    callback = function()
        vim.opt_local.number = true
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "n", true)
    end
})

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:q!<CR>', { silent = true })
