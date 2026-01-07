local fuzzy_opt = {}
---@diagnostic disable-next-line: undefined-field
if vim.loop.os_uname().sysname == "Darwin" then
  ---@diagnostic disable-next-line: undefined-field
  if vim.loop.os_uname().machine == "x86_64" then
    fuzzy_opt = { implementation = "lua" }
  end
end

return {
  "saghen/blink.cmp",
  optional = true,
  dependencies = {
    "fang2hou/blink-copilot",
    opts = {
      max_completions = 1, -- Global default for max completions
      max_attempts = 2, -- Global default for max attempts
    },
  },
  -- dependencies = {
  --   {
  --     "giuxtaposition/blink-cmp-copilot",
  --   },
  -- },
  opts = {
    fuzzy = fuzzy_opt,
    sources = {
      -- default = { "copilot", "lsp", "path", "snippets", "buffer" },
      default = { "lsp", "path", "snippets", "buffer" },
      -- default = {},
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          enabled = true,
          opts = {
            -- Local options override global ones
            max_completions = 3, -- Override global max_completions

            -- Final settings:
            -- * max_completions = 3
            -- * max_attempts = 2
            -- * all other options are default
            -- max_completions = 3,
            max_attempts = 4,
            kind_name = "Copilot", ---@type string | false
            kind_icon = " ", ---@type string | false
            kind_hl = false, ---@type string | false
            debounce = 200, ---@type integer | false
            auto_refresh = {
              backward = true,
              forward = true,
            },
          },
        },
      },
    },
    appearance = {
      -- use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
    --   enabled_providers = { "copilot", "lsp", "path", "buffer" },
      -- enabled_providers = { "copilot", "lsp", "path", "buffer", "snippets" },
      menu = {
        border = nil,
        scrolloff = 1,
        scrollbar = false,
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
            { "source_name" },
          },
        },
      },
      documentation = {
        window = {
          border = nil,
          scrollbar = false,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
        },
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },
  },
}
