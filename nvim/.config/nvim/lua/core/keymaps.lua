-- [[ Basic Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- don't add single char to clipboard on del
vim.keymap.set("n", "x", '"_x')

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [d]ocument [q]uickfix list" })
vim.keymap.set("n", "<leader>dd", function()
	vim.diagnostic.open_float()
end, { desc = "Show [d]ocument [d]iagnostic" })
vim.keymap.set("n", "<leader>dp", function()
	vim.diagnostic.goto_prev()
end, { desc = "Go to [d]ocument [p]revious diagnostic" })
vim.keymap.set("n", "<leader>dn", function()
	vim.diagnostic.goto_next()
end, { desc = "Go to [d]ocument [n]ext diagnostic" })
