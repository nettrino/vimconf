return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	-- main is the rewrite matching nvim-treesitter main; keymaps are set by hand
	-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main#text-objects-select
	branch = "main",
	lazy = false,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
			},
			move = {
				set_jumps = true, -- whether to set jumps in the jumplist
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local swap = require("nvim-treesitter-textobjects.swap")
		local move = require("nvim-treesitter-textobjects.move")

		-- You can use the capture groups defined in textobjects.scm
		local select_maps = {
			["a="] = { "@assignment.outer", "Select outer part of an assignment" },
			["i="] = { "@assignment.inner", "Select inner part of an assignment" },
			["l="] = { "@assignment.lhs", "Select left hand side of an assignment" },
			["r="] = { "@assignment.rhs", "Select right hand side of an assignment" },

			-- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
			["a:"] = { "@property.outer", "Select outer part of an object property" },
			["i:"] = { "@property.inner", "Select inner part of an object property" },
			["l:"] = { "@property.lhs", "Select left part of an object property" },
			["r:"] = { "@property.rhs", "Select right part of an object property" },

			["aa"] = { "@parameter.outer", "Select outer part of a parameter/argument" },
			["ia"] = { "@parameter.inner", "Select inner part of a parameter/argument" },

			["ai"] = { "@conditional.outer", "Select outer part of a conditional" },
			["ii"] = { "@conditional.inner", "Select inner part of a conditional" },

			["al"] = { "@loop.outer", "Select outer part of a loop" },
			["il"] = { "@loop.inner", "Select inner part of a loop" },

			["af"] = { "@call.outer", "Select outer part of a function call" },
			["if"] = { "@call.inner", "Select inner part of a function call" },

			["am"] = { "@function.outer", "Select outer part of a method/function definition" },
			["im"] = { "@function.inner", "Select inner part of a method/function definition" },

			["ac"] = { "@class.outer", "Select outer part of a class" },
			["ic"] = { "@class.inner", "Select inner part of a class" },
		}
		for lhs, m in pairs(select_maps) do
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(m[1], "textobjects")
			end, { desc = m[2] })
		end

		local swap_maps = {
			swap_next = {
				["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
				["<leader>n:"] = "@property.outer", -- swap object property with next
				["<leader>nm"] = "@function.outer", -- swap function with next
			},
			swap_previous = {
				["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
				["<leader>p:"] = "@property.outer", -- swap object property with prev
				["<leader>pm"] = "@function.outer", -- swap function with previous
			},
		}
		for fn, maps in pairs(swap_maps) do
			for lhs, query in pairs(maps) do
				vim.keymap.set("n", lhs, function()
					swap[fn](query)
				end, { desc = fn .. " " .. query })
			end
		end

		-- query_group defaults to "textobjects"; locals.scm / folds.scm are also usable
		local move_maps = {
			goto_next_start = {
				["]f"] = { "@call.outer", "Next function call start" },
				["]m"] = { "@function.outer", "Next method/function def start" },
				["]c"] = { "@class.outer", "Next class start" },
				["]i"] = { "@conditional.outer", "Next conditional start" },
				["]l"] = { "@loop.outer", "Next loop start" },
				["]s"] = { "@local.scope", "Next scope", "locals" },
				["]z"] = { "@fold", "Next fold", "folds" },
			},
			goto_next_end = {
				["]F"] = { "@call.outer", "Next function call end" },
				["]M"] = { "@function.outer", "Next method/function def end" },
				["]C"] = { "@class.outer", "Next class end" },
				["]I"] = { "@conditional.outer", "Next conditional end" },
				["]L"] = { "@loop.outer", "Next loop end" },
			},
			goto_previous_start = {
				["[f"] = { "@call.outer", "Prev function call start" },
				["[m"] = { "@function.outer", "Prev method/function def start" },
				["[c"] = { "@class.outer", "Prev class start" },
				["[i"] = { "@conditional.outer", "Prev conditional start" },
				["[l"] = { "@loop.outer", "Prev loop start" },
			},
			goto_previous_end = {
				["[F"] = { "@call.outer", "Prev function call end" },
				["[M"] = { "@function.outer", "Prev method/function def end" },
				["[C"] = { "@class.outer", "Prev class end" },
				["[I"] = { "@conditional.outer", "Prev conditional end" },
				["[L"] = { "@loop.outer", "Prev loop end" },
			},
		}
		for fn, maps in pairs(move_maps) do
			for lhs, m in pairs(maps) do
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					move[fn](m[1], m[3] or "textobjects")
				end, { desc = m[2] })
			end
		end

		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

		-- vim way: ; goes to the direction you were moving.
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end,
}
