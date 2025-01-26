return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>c"] = { name = "Code" },
      ["<leader>d"] = { name = "Debug" },
      ["<leader>g"] = { name = "Git" },
      ["<leader>t"] = { name = "Tab" },
      ["<leader>w"] = { name = "Window" },
      ["<leader>f"] = { name = "Find" },
      ["<leader>J"] = { name = "Java" },
    })
  end,
}

