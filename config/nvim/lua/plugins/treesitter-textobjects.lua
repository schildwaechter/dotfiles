return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		local textobjects = require("nvim-treesitter-textobjects")
		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

		-- Setup configuration with selection modes defined here
		textobjects.setup({
			select = {
				lookahead = true,
				include_surrounding_whitespace = false,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@parameter.inner"] = "v", -- charwise
					["@function.outer"] = "v", -- charwise
					["@function.inner"] = "v", -- charwise
					["@conditional.outer"] = "V", -- linewise
					["@conditional.inner"] = "V", -- linewise
					["@loop.outer"] = "V", -- linewise
					["@loop.inner"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
					["@class.inner"] = "<c-v>", -- blockwise
				},
			},
			move = {
				set_jumps = true,
			},
		})

		-- SELECT: Function
		vim.keymap.set({ "x", "o" }, "af", function()
			select.select_textobject("@function.outer", "textobjects")
		end, { desc = "around a function" })
		vim.keymap.set({ "x", "o" }, "if", function()
			select.select_textobject("@function.inner", "textobjects")
		end, { desc = "inner part of a function" })

		-- SELECT: Class
		vim.keymap.set({ "x", "o" }, "ac", function()
			select.select_textobject("@class.outer", "textobjects")
		end, { desc = "around a class" })
		vim.keymap.set({ "x", "o" }, "ic", function()
			select.select_textobject("@class.inner", "textobjects")
		end, { desc = "inner part of a class" })

		-- SELECT: Conditional
		vim.keymap.set({ "x", "o" }, "ai", function()
			select.select_textobject("@conditional.outer", "textobjects")
		end, { desc = "around an if statement" })
		vim.keymap.set({ "x", "o" }, "ii", function()
			select.select_textobject("@conditional.inner", "textobjects")
		end, { desc = "inner part of an if statement" })

		-- SELECT: Loop
		vim.keymap.set({ "x", "o" }, "al", function()
			select.select_textobject("@loop.outer", "textobjects")
		end, { desc = "around a loop" })
		vim.keymap.set({ "x", "o" }, "il", function()
			select.select_textobject("@loop.inner", "textobjects")
		end, { desc = "inner part of a loop" })

		-- SELECT: Parameter
		vim.keymap.set({ "x", "o" }, "ap", function()
			select.select_textobject("@parameter.outer", "textobjects")
		end, { desc = "around parameter" })
		vim.keymap.set({ "x", "o" }, "ip", function()
			select.select_textobject("@parameter.inner", "textobjects")
		end, { desc = "inside a parameter" })

		-- MOVE: Next start
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next function" })
		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			move.goto_next_start("@class.outer", "textobjects")
		end, { desc = "Next class" })
		vim.keymap.set({ "n", "x", "o" }, "]p", function()
			move.goto_next_start("@parameter.inner", "textobjects")
		end, { desc = "Next parameter" })

		-- MOVE: Previous start
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Previous function" })
		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			move.goto_previous_start("@class.outer", "textobjects")
		end, { desc = "Previous class" })
		vim.keymap.set({ "n", "x", "o" }, "[p", function()
			move.goto_previous_start("@parameter.inner", "textobjects")
		end, { desc = "Previous parameter" })

		-- SWAP: Next/Previous
		vim.keymap.set("n", "<leader>a", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap with next parameter" })
		vim.keymap.set("n", "<leader>A", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap with previous parameter" })

		-- REPEATABLE MOVEMENT: ; and ,
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		-- Make f, F, t, T also repeatable
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end,
}
