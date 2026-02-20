return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      if vim.g.nix_neovim then
        -- NixOS: Disable ALL Mason LSP auto-installs (use Nix packages)
        opts.ensure_installed = {}
        opts.automatic_installation = false
        opts.automatic_enable = false
      end
      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if vim.g.nix_neovim then
        opts.servers = opts.servers or {}
        opts.servers.nil_ls = vim.tbl_deep_extend("force", opts.servers.nil_ls or {}, { mason = false })
        opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, { mason = false })
      end
      return opts
    end,
  },
}
