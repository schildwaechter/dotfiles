return {
    { "L3MON4D3/LuaSnip", keys = {} },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "giuxtaposition/blink-cmp-copilot",
        },
        version = "*",
        config = function()
            require("blink.cmp").setup({
                snippets = { preset = "luasnip" },
                signature = { enabled = true },
                appearance = {
--                     -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
--                     kind_icons = {
--                         Copilot = "",
--                         Text = '󰉿',
--                         Method = '󰊕',
--                         Function = '󰊕',
--                         Constructor = '󰒓',
--
--                         Field = '󰜢',
--                         Variable = '󰆦',
--                         Property = '󰖷',
--
--                         Class = '󱡠',
--                         Interface = '󱡠',
--                         Struct = '󱡠',
--                         Module = '󰅩',
--
--                         Unit = '󰪚',
--                         Value = '󰦨',
--                         Enum = '󰦨',
--                         EnumMember = '󰦨',
--
--                         Keyword = '󰻾',
--                         Constant = '󰏿',
--
--                         Snippet = '󱄽',
--                         Color = '󰏘',
--                         File = '󰈔',
--                         Reference = '󰬲',
--                         Folder = '󰉋',
--                         Event = '󱐋',
--                         Operator = '󰪚',
--                         TypeParameter = '󰬛',
--                     },
                    use_nvim_cmp_as_default = false,
                    nerd_font_variant = "normal",
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                    providers = {
                        cmdline = {
                            min_keyword_length = 2,
                        },
                        -- copilot = {
                        --     transform_items = function(_, items)
                        --     local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                        --     local kind_idx = #CompletionItemKind + 1
                        --     CompletionItemKind[kind_idx] = "Copilot"
                        --     for _, item in ipairs(items) do
                        --         item.kind = kind_idx
                        --     end
                        --     return items
                        --     end,
                        -- },
                    },
                },
                keymap = {
                    ["<C-f>"] = {},
                },
                cmdline = {
                    enabled = false,
                    completion = { menu = { auto_show = true } },
                    keymap = {
                        ["<CR>"] = { "accept_and_enter", "fallback" },
                    },
                },
                completion = {
                    menu = {
                        border = nil,
                        scrolloff = 1,
                        scrollbar = false,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label",      "label_description", gap = 1 },
                                { "kind" },
                                { "source_name" },
                            },
                        },
                    },
                    documentation = {
                        window = {
                            border = nil,
                            scrollbar = false,
                            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                        },
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    },
                },
            })

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
