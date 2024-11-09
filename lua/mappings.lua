require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<A-j>", "<cmd> move +1<CR>", { silent = true })
map("n", "<A-k>", "<cmd> move -2<CR>", { silent = true })
map("v", "<A-j>", ":move '>+1<CR>gv=gv'", { silent = true })
map("v", "<A-k>", ":move '<-2<CR>gv=gv'", { silent = true })

map("n", "<leader>lf", ":lua vim.diagnostic.open_float()<CR>", { silent = true, desc = "Open floating diagnostic" })

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
