if vim.fn.has('nvim-0.8') == 0 then
    error('Need Neovim 0.8+ in order to use this config')
end

-- Import Lua modules --
local modules = {'core', 'plugins'}

for _, mod in ipairs(modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(('Error loading %s...\n\n%s'):format(mod, err))
    end
end
