-- KEYBINDINGS
-- Plugin specific keybindings are in the plugin's config files.

-- Remap space as leader key.
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap for dealing with word wrap.
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })


-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, { noremap = true, silent = true })
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "++", "<plug>NERDCommenterToggle", { silent = true })
map("v", "++", "<plug>NERDCommenterToggle", { silent = true })
-- Floatterm bindings
map("n", "<F7>", ":FloatermNew<CR>", { silent = true })
map("n", "<F8>", ":FloatermPrev<CR>", { silent = true })
map("n", "<F9>", ":FloatermNext<CR>", { silent = true })
map("n", "<F12>", ":FloatermToggle<CR>", { silent = true })
map("t", "<F7>", "<C-\\><C-n>:FloatermNew<CR>", { silent = true })
map("t", "<F8>", "<C-\\><C-n>:FloatermPrev<CR>", { silent = true })
map("t", "<F9>", "<C-\\><C-n>:FloatermNext<CR>", { silent = true })
map("t", "<F12>", "<C-\\><C-n>:FloatermToggle<CR>", { silent = true })

-- Autoformat
map("n", "<F3>", ":Autoformat<CR>", { silent = true })

-- Diffview bindings
map("n", "<leader>df", ":DiffviewOpen<CR>", { silent = true })

-- Lazygit bindings
map("n", "<leader>gg", ":LazyGit<CR>", { silent = true })

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
map('n', '<A-.>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true })
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true })
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true })
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true })
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true })
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true })
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true })
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true })
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true })
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true })
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true })
map('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true })
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', { noremap = true, silent = true })
-- Close buffer
--map('n', '<leader>bc', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
map('n', '<leader>bc', '<Cmd>BufferCloseAllButCurrent<CR>', { noremap = true, silent = true })
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', { noremap = true, silent = true })
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { noremap = true, silent = true })
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', { noremap = true, silent = true })
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', { noremap = true, silent = true })
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { noremap = true, silent = true })

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- Formatter
map("n", "<leader>f", ":Format<CR>", { silent = true })
map("n", "<leader>F", ":FormatWrite<CR>", { silent = true })
