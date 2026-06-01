return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local parsers = require("nvim-treesitter")
		local ts_config = require("nvim-treesitter.config")

		parsers.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local ensure_installed = {
			"bash",
			"c",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"hcl",
			"helm",
			"html",
			"javascript",
			"json",
			"lua",
			"luadoc",
			"luap",
			"query",
			"regex",
			"rust",
			"terraform",
			"vim",
			"vimdoc",
			"yaml",
		}

		local installed = ts_config.get_installed()
		local missing = vim.tbl_filter(function(lang)
			return not vim.list_contains(installed, lang)
		end, ensure_installed)

		if #missing > 0 then
			parsers.install(missing)
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-features", { clear = true }),
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
				if vim.treesitter.foldexpr then
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldmethod = "expr"
				end
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
