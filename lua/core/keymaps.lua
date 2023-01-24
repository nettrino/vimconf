vim.g.mapleader = ','

-- Save with ctrl + s
vim.keymap.set('n', '<C-s>', ':w<CR>', {})


-- Split windows horizontally and vertically
vim.keymap.set('n', '_', ':split<CR>', {})
vim.keymap.set('n', '|', ':vsplit<CR>', {})

-- Resize splits
vim.keymap.set('n', '<C-k>', '2<C-w>-', {})
vim.keymap.set('n', '<C-j>', '2<C-w>+', {})
vim.keymap.set('n', '<C-h>', '2<C-w><', {})
vim.keymap.set('n', '<C-l>', '2<C-w>>', {})

-- Reload configuration without restart nvim
vim.keymap.set('n', '<leader>r', ':so %<CR>', {})

-- hex mode
vim.keymap.set('n', '<leader>hon', ':set binary <bar> %!xxd', {})
vim.keymap.set('n', '<leader>hof', ':set binary <bar> %!xxd -r', {})

-- NvimTree
vim.keymap.set('n', '<C-g>', ':NvimTreeToggle<CR>', {}) -- open/close

-- sort
vim.keymap.set('n', '<leader>s', ':sort<CR>yy', {})

-- select all
vim.keymap.set('n', '<C-a>', '<esc>ggVG<CR>', {})
