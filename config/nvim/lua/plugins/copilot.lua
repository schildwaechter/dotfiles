return {
  "zbirenbaum/copilot.lua",

  cmd = "Copilot",
  event = "InsertEnter",
  config = true,
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      -- explicitly enable/disable filetypes
      dockerfile = true,
      go = true,
      lua = true,
      make = true,
      python = true,
      sh = true,
      terraform = true,
      yaml = true,
      ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
    },
  },
}
