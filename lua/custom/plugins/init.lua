-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Undotree for saving file editing history
  'mbbill/undotree',

  -- TS Autotag for html auto tag close
  'windwp/nvim-ts-autotag',

  -- Better jinja2 support
  'HiPhish/jinja.vim',

  -- Navigation integration for tmux
  'christoomey/vim-tmux-navigator',

  -- More convenient way to use terminal from neovim
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = '<leader>tt',
        direction = 'float',
        shell = '/usr/bin/fish',
      }
    end,
  },

  -- Harpoon for fast navigation within a project
  {
    'theprimeagen/harpoon',
    config = function()
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'

      vim.keymap.set('n', '<C-a>', mark.add_file)
      vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

      vim.keymap.set('n', '<C-t>', function()
        ui.nav_file(1)
      end)
      vim.keymap.set('n', '<C-n>', function()
        ui.nav_file(2)
      end)
      vim.keymap.set('n', '<C-s>', function()
        ui.nav_file(3)
      end)
    end,
  },

  -- Oil.nvim for directory manipulation
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  {
    'nvim-neorg/neorg',
    lazy = false,
    version = '*',
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/notes',
              },
              default_workspace = 'notes',
            },
          },
          ['core.summary'] = {},
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },

  -- INFO: Previously used, now disabled plugins

  -- Github copilot
  -- 'github/copilot.vim',
}
