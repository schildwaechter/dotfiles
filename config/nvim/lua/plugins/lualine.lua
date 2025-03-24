local colors = {
  -- mix of M365Princess and SolarizedDark
  blush = "#DA627D",
  plum = "#9A348E",
  salmon = "#FCA17D",
  sky = "#86BBD8",
  tan = "#CC3802",
  teal = "#047E84",
  teal_blue = "#33658A",
  white = "#FFFFFF",

  base03 = "#002b36",
  base02 = "#073642",
  base01 = "#586e75",
  base00 = "#657b83",
  base0 = "#839496",
  base1 = "#93a1a1",
  base2 = "#eee8d5",
  base3 = "#fdf6e3",
}

local custom_theme = {
  normal = {
    a = { fg = colors.white, bg = colors.plum, gui = "bold" },
    b = { fg = colors.white, bg = colors.teal_blue },
    c = { fg = colors.base1, bg = colors.base02 },
    z = { fg = colors.white, bg = colors.teal },
  },
  insert = { a = { fg = colors.white, bg = colors.blush, gui = "bold" } },
  visual = { a = { fg = colors.base03, bg = colors.sky, gui = "bold" } },
  replace = { a = { fg = colors.base03, bg = colors.salmon, gui = "bold" } },
  inactive = {
    a = { fg = colors.base0, bg = colors.base02, gui = "bold" },
    b = { fg = colors.base03, bg = colors.base00 },
    c = { fg = colors.base01, bg = colors.base02 },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = custom_theme,
      },
      sections = {
        lualine_b = {
          { "branch" },
          {
            "diff",
            diff_color = {
              added = { fg = colors.sky },
              modified = { fg = colors.sky },
              removed = { fg = colors.sky },
            },
          },
        },
      },
    })
  end,
}
