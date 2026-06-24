-- More convenient way to use terminal from neovim
vim.pack.add{ 'https://github.com/akinsho/toggleterm.nvim' }
require('toggleterm').setup {
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = '<leader>tt',
    insert_mappings = false,
    direction = 'float',
    shell = '/usr/bin/fish',
}
