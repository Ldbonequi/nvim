-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
if os.getenv("NIX_NEOVIM") == "1" then
  vim.g.nix_neovim = true -- Tell other plugins if on NixOS
end
