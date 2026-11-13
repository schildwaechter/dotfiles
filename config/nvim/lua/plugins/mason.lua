return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "docker-language-server",
        "gitlint",
        "hadolint",
        "helm-ls",
        "marksman",
      },
      run_on_start = true,
      start_delay = 0,
    },
  },
}
