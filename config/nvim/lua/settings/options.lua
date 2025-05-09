vim.g.have_nerd_font = true -- Use some icons

vim.wo.number = true -- Make line numbers default (default: false)
vim.o.relativenumber = true -- Set relative numbered lines (default: false)
vim.o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim. (default: '')
vim.o.wrap = false -- Display lines as one long line (default: true)
vim.o.linebreak = true -- Companion to wrap, don't split words (default: false)
vim.o.mouse = "a" -- Enable mouse mode (default: '')

vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.o.smartcase = true -- Smart case (default: false)

vim.o.shiftwidth = 2 -- The number of spaces inserted for each indentation (default: 8)
vim.o.tabstop = 2 -- Insert n spaces for a tab (default: 8)
vim.o.softtabstop = 2 -- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.o.expandtab = true -- Convert tabs to spaces (default: false)
vim.o.smartindent = true -- Insert indents automatically (default: false)
vim.o.autoindent = true -- Keep identation from previous line

vim.o.scrolloff = 4 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.o.sidescrolloff = 3 -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)

vim.o.cursorline = false -- Highlight the current line (default: false)

vim.o.hlsearch = true -- Set highlight on search (default: true)
vim.o.incsearch = true -- Incremental search while typing (default: false)
vim.o.showmatch = true -- Show matching brackets when text indicator is over them (default: false)

vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "￮", nbsp = "‿" }
-- vim.opt.listchars = { tab = '▸␣', trail = '￮', nbsp = '‿', eol = '¬' }

vim.opt.colorcolumn = { 80, 120, 180 }

vim.opt.splitright = true -- split to the right
vim.opt.splitbelow = true -- split down

vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

vim.filetype.add({
  pattern = {
    [".*/templates/.*%.yaml"] = "helm",
  },
})
