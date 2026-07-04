-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- del keymaps
-- vim.keymap.del("n", "<leader>bb")

-- remove tabs
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>o")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")

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

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal: ESC to normal" })

local root = require("lazyvim.util").root

local function create_term(target_cwd)
  if target_cwd then
    vim.cmd("lcd " .. target_cwd)
  end
  vim.cmd("terminal")
  vim.cmd("startinsert")
end

local function find_term(dir)
  local normalized_dir = vim.fs.normalize(dir)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      local name = vim.api.nvim_buf_get_name(buf)
      -- name is "term://{cwd}//{pid}:{cmd}"
      local cwd_part = name:match("^term://(.-)//%d+:.+")
      if cwd_part and vim.fs.normalize(cwd_part) == normalized_dir then
        return buf, name
      end
    end
  end
  return nil, nil
end

local function find_or_create_term(dir)
  local buf, _ = find_term(dir)
  if buf then
    vim.api.nvim_win_set_buf(0, buf)
    vim.cmd("startinsert")
  else
    create_term(dir)
  end
end

vim.keymap.set("n", "<leader>ft", function()
  local proj_root = root()
  vim.cmd("split")
  find_or_create_term(proj_root)
end, { desc = "Terminal (root)" })

vim.keymap.set("n", "<leader>fT", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("split")
  find_or_create_term(cwd)
end, { desc = "Terminal (root)" })

vim.keymap.set("n", "<leader>bt", function()
  local proj_root = root()
  find_or_create_term(proj_root)
end, { desc = "Terminal (root)" })

vim.keymap.set("n", "<leader>bT", function()
  local cwd = vim.fn.getcwd()
  find_or_create_term(cwd)
end, { desc = "Terminal (root)" })

-- allow wqa to quit by deleting all terminals
vim.api.nvim_create_user_command("WQA", function()
  vim.cmd("wall")

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
      -- Delete buffer, forcing the job to end
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  vim.cmd("qa")
end, { desc = "Write all, close terminals, quit all" })

vim.cmd([[
  cabbrev wqa WQA
]])
