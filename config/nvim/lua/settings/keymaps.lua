-- Set leader key to spacebar
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- duplicate current line and comment the first
vim.keymap.set("n", "ycc", "yygccp", { remap = true })

-- taken from nvim-lspconfig
vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })

-- Allow accidental use of Shift with quit/write commands
vim.api.nvim_create_user_command("W", "w<bang> <args>", {
  bang = true,
  nargs = "*",
  complete = "file",
  desc = "Write (alias for :w)",
})

vim.api.nvim_create_user_command("Wq", "wq<bang> <args>", {
  bang = true,
  nargs = "*",
  complete = "file",
  desc = "Write and quit (alias for :wq)",
})

vim.api.nvim_create_user_command("WQ", "wq<bang> <args>", {
  bang = true,
  nargs = "*",
  complete = "file",
  desc = "Write and quit (alias for :wq)",
})

vim.api.nvim_create_user_command("Q", "q<bang>", {
  bang = true,
  desc = "Quit (alias for :q)",
})

vim.api.nvim_create_user_command("QA", "qa<bang>", {
  bang = true,
  desc = "Quit all (alias for :qa)",
})

vim.api.nvim_create_user_command("Qa", "qa<bang>", {
  bang = true,
  desc = "Quit all (alias for :qa)",
})
