return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      dockerfile = { "hadolint" },
      gitcommit = { "gitlint" },
      ghaction = { "actionlint" },
      markdown = { "markdownlint-cli2" },
      python = { "ruff" },
      sh = { "shellcheck" },
      terraform = { "tflint" },
      text = { "proselint" },
    }

    local markdownlint = lint.linters["markdownlint-cli2"]
    markdownlint.args = {
      "--config",
      os.getenv("HOME") .. "/.markdownlint-cli2.jsonc",
    }

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- instead set linters_by_ft like this:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint-cli2' }
    --
    -- However, note that this will enable a set of default linters,
    -- which will cause errors unless these tools are available:
    -- {
    --   clojure = { "clj-kondo" },
    --   dockerfile = { "hadolint" },
    --   inko = { "inko" },
    --   janet = { "janet" },
    --   json = { "jsonlint" },
    --   markdown = { "vale" },
    --   rst = { "vale" },
    --   ruby = { "ruby" },
    --   terraform = { "tflint" },
    --   text = { "vale" }
    -- }
    --
    -- You can disable the default linters by setting their filetypes to nil:
    -- lint.linters_by_ft['clojure'] = nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['inko'] = nil
    -- lint.linters_by_ft['janet'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['rst'] = nil
    -- lint.linters_by_ft['ruby'] = nil
    -- lint.linters_by_ft['terraform'] = nil
    -- lint.linters_by_ft['text'] = nil

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local function available_linters(bufnr)
      local filetype = vim.bo[bufnr].filetype
      local linters = lint.linters_by_ft[filetype] or {}

      return vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        local cmd = linter and linter.cmd or name
        if type(cmd) == "function" then
          return true
        end

        return vim.fn.executable(cmd) == 1
      end, linters)
    end

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function(args)
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.opt_local.modifiable:get() then
          local linters = available_linters(args.buf)
          if #linters > 0 then
            lint.try_lint(linters)
          end
        end
      end,
    })
  end,
}
