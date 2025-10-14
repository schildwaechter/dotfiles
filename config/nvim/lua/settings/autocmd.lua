-- Highlight when yanking (copying) text
--  See `:help vim.hl.on_yank()`
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   desc = "Highlight when yanking (copying) text",
--   group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
--   callback = function()
--     vim.hl.on_yank()
--   end,
-- })

-- no text completion in git commit messages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    require("blink-cmp").setup({ enabled = false })
  end,
})
