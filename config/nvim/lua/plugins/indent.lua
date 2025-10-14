
return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    opts = {},
--     config = function()
--         local highlight = {
--             -- "RainbowRed",
--             -- "RainbowYellow",
--             -- "RainbowBlue",
--             -- "RainbowOrange",
--             -- "RainbowGreen",
--             -- "RainbowViolet",
--             -- "RainbowCyan",
--             "RainbowBlush",
--             "RainbowPlum",
--             "RainbowSalmon",
--             "RainbowSky",
--             "RainbowTan",
--             "RainbowTeal",
--             "RainbowTealBlue",
--         }
--
--         local hooks = require "ibl.hooks"
--         -- create the highlight groups in the highlight setup hook, so they are reset
--         -- every time the colorscheme changes
--         hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--             vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
--             vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
--             vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
--             vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
--             vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
--             vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
--             vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
--             vim.api.nvim_set_hl(0, "RainbowBlush", { fg = "#DA627D" })
--             vim.api.nvim_set_hl(0, "RainbowPlum", { fg = "#9A348E" })
--             vim.api.nvim_set_hl(0, "RainbowSalmon", { fg = "#FCA17D" })
--             vim.api.nvim_set_hl(0, "RainbowSky", { fg = "#86BBD8" })
--             vim.api.nvim_set_hl(0, "RainbowTan", { fg = "#CC3802" })
--             vim.api.nvim_set_hl(0, "RainbowTeal", { fg = "#047E84" })
--             vim.api.nvim_set_hl(0, "RainbowTealBlue", { fg = "#33658A" })
--         end)
--         vim.opt.list = true
--         -- vim.opt.listchars:append("space:⋅")
--         -- vim.opt.listchars:append("eol:↴")
--
--         require("ibl").setup {
--             exclude = {
--                 filetypes = { "help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float" },
--                 buftypes = { "terminal", "nofile", "telescope" },
--             },
--             indent = { highlight = highlight },
--             -- indent = { char = "│", },
--             scope = {
--             enabled = true,
--             show_start = false,
--             }
--         }
--     end,
}
