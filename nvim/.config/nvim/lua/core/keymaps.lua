-- [[ Basic Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Turn off macro recording I'm not cracked enough
vim.keymap.set("n", "q", "<Nop")

-- don't add single char to clipboard on del
vim.keymap.set("n", "x", '"_x')

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [d]ocument [q]uickfix list" })
vim.keymap.set("n", "<leader>dd", function()
	vim.diagnostic.open_float()
end, { desc = "Show [d]ocument [d]iagnostic" })
