-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- del keymaps
vim.keymap.del("n", "<leader>bb")

-- add keymaps
-- buffer all - Space <
vim.keymap.set("n", "<leader><", function()
  require("snacks").picker.buffers({ hidden = true, nofile = true })
end, { desc = "Buffers (All)" })

-- Kill Buffer - Space b k
vim.keymap.set("n", "<leader>bk", function()
  require("snacks").bufdelete()
end, { desc = "Kill Buffer" })

-- Buffer Last - Space b l
vim.keymap.set("n", "<leader>bl", "<cmd>e #<cr>", { desc = "Buffer Last" })
