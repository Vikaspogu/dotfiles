-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require'nvim-tree'.setup {
	view = {
		side = 'right',
		adaptive_size = true,
	},
	filters = {
		dotfiles = true,
	  },
}

vim.api.nvim_set_keymap('n', '<C-n>', [[<cmd>NvimTreeToggle<CR>]], { noremap = true, silent = true })
