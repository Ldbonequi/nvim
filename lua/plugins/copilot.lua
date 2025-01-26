return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_enabled = false
		-- Set key mapping for toggling Copilot
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>cp",
			':if !exists("g:copilot_enabled") | let g:copilot_enabled = 0 | endif | if g:copilot_enabled | execute "Copilot disable" | let g:copilot_enabled = 0 | else | execute "Copilot enable" | let g:copilot_enabled = 1 | endif<CR>',
			{ noremap = true, silent = true, desc = "Toggle GitHub [C]o[p]ilot" }
		)
	end,
}
