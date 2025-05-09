return {
  "cenk1cenk2/schema-companion.nvim",
  ft = { "yaml", "helm" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("schema-companion").setup({
      -- log_level = vim.log.levels.DEBUG,
      -- if you have telescope you can register the extension
      enable_telescope = true,
      matchers = {
        -- add your matchers
        require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
      },
      schemas = {
        {
          name = "Kubernetes master",
          uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
        },
        {
          name = "Kubernetes v1.31",
          uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.1-standalone-strict/all.json",
        },
      },
    })
  end,
  on_setup = function(c)
    require("schema-companion").setup(c)
  end,
}
