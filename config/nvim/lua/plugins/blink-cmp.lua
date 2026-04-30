local fuzzy_opt = {}
---@diagnostic disable-next-line: undefined-field
if vim.loop.os_uname().sysname == "Darwin" then
  ---@diagnostic disable-next-line: undefined-field
  -- if vim.loop.os_uname().machine == "x86_64" then
  fuzzy_opt = { implementation = "lua" }
  -- end
end

return {
  "saghen/blink.cmp",
  optional = true,
  dependencies = { "fang2hou/blink-copilot" },
  -- dependencies = {
  --   {
  --     "giuxtaposition/blink-cmp-copilot",
  --   },
  -- },
  opts = {
    fuzzy = fuzzy_opt,
    sources = {
      default = { "copilot", "lsp", "path", "snippets", "buffer" },
      -- default = {},
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          enabled = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = {
        Copilot = "",
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",

        Field = "󰜢",
        Variable = "󰆦",
        Property = "󰖷",

        Class = "󱡠",
        Interface = "󱡠",
        Struct = "󱡠",
        Module = "󰅩",

        Unit = "󰪚",
        Value = "󰦨",
        Enum = "󰦨",
        EnumMember = "󰦨",

        Keyword = "󰻾",
        Constant = "󰏿",

        Snippet = "󱄽",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
      },
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
