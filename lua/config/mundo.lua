-- Enable persistent undo so that undo history persists across vim sessions
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.g.mundo_prefer_python3 = 1

vim.keymap.set('n', '<S-u>', ':MundoToggle<cr>', {})
