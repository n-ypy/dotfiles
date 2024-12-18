local set = vim.keymap.set

set("n", "<Esc>", "<cmd>nohlsearch<CR>")

set("n", "<leader>cd", ":cd %:p:h<CR>", { desc = "[C]hange to the current file's [D]irectory" })

set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Shows all [D]iagnostics for the current [L]ine" })

set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

set("n", "\\", "<cmd>lua MiniFiles.open()<CR>")
