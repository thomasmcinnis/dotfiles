vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>") -- remove search highlights wiht esc

vim.keymap.set({ "n" }, "s", "<Nop>")           -- unbind defaul 's'

-- vim.keymap.set('n', '<leader>k', ':Ex<CR>', { noremap = true, silent = true, desc = "Open netrw" })

-- move text blocks up/down with indetation support
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set('v', "K", ":m '>-2<CR>gv=gv", { desc = "Move selection up" })

-- Turn off macro recording I'm not cracked enough
vim.keymap.set("n", "q", "<Nop")

-- don't add single char to clipboard on del
vim.keymap.set("n", "x", '"_x')

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [d]ocument [q]uickfix list" })
vim.keymap.set("n", "<leader>dd", function() vim.diagnostic.open_float() end, { desc = "Show [d]ocument [d]iagnostic" })
