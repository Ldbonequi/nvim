return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc = "[F]ind [F]ile"})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "[F]ind [G]rep"})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {desc = "Recent Files"})

      require("telescope").load_extension("ui-select")
    end,
  },
}
