vim.g.mapleader = ' '
vim.keymap.set('n', '<c-a>', 'ggVG')
vim.keymap.set('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
vim.keymap.set('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })
