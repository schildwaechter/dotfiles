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

vim.keymap.set(
  "n",
  "<leader>kz",
  "<cmd>lua require('telescope').extensions.schema_companion.select_from_matching_schemas()<CR>",
  { desc = "Select from matching schemas" }
)

vim.keymap.set(
  "n",
  "<leader>kx",
  "<cmd>lua require('telescope').extensions.schema-companion.select_schema()<CR>",
  { desc = "Select from all schemas" }
)

vim.keymap.set(
  "n",
  "<leader>kr",
  "<cmd>lua require('schema-companion.context').match()<CR>",
  { desc = "Rematch schema" }
)

vim.keymap.set(
  "n",
  "<leader>kk",
  "<cmd>lua require('schema-companion.matchers.kubernetes').change_version()<CR>",
  { desc = "Set Kubernetes version" }
)
