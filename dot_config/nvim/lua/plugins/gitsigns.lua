return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			-- Used for mapping outside of whichkey
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]h", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Next Git [H]unk" })

			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[h", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Previous Git [H]unk" })

			-- Staging
			map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Toggle Hunk Stage" })
			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Toggle Hunk Stage" })
			map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[H]unk [S]tage Buffer" })

			-- Resetting
			map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[H]unk [R]eset" })
			map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[H]unk [R]eset Buffer" })

			-- Viewing hunks
			map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [P]review Line" })
			map("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "[H]unk [B]lame Line" })

			-- Editor UI
			map("n", "<leader>ub", gitsigns.toggle_current_line_blame, { desc = "Toggle Git Line Blame" })
			map("n", "<leader>ud", gitsigns.preview_hunk_inline(), { desc = "Toggle Deleted Git Signs" })

			-- Diffing
			map("n", "<leader>hd", gitsigns.diffthis, { desc = "[H]unk [D]iff" })
			map("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { desc = "[H]unk [D]iff" })

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git [H]unk" })
		end,
	},
}
