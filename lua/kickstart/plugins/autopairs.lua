-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'
    npairs.setup {}
    local Rule = require 'nvim-autopairs.rule'
    local cond = require 'nvim-autopairs.conds'

    -- INFO: Add 'ins' inside 'a1' and 'a2' for specified language(s)

    local function rule2(a1, ins, a2, lang)
      npairs.add_rule(Rule(ins, ins, lang)
        :with_pair(function(opts)
          return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          return a1 .. ins .. ins .. a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
        end))
    end

    rule2('{', '%', '}', 'html')
    rule2('{%', ' ', '%}', 'html')
    rule2('{', ':', '}', 'norg')
    rule2('(', ' ', ')')
    rule2('[', ' ', ']')
    rule2('{', ' ', '}')

    -- INFO: Add autopairs <> mainly for rust types and generics
    npairs.add_rule(Rule('<', '>', {
      -- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
      -- so that it doesn't conflict with nvim-ts-autotag
      '-html',
      '-javascriptreact',
      '-typescriptreact',
    }):with_pair(
      -- regex will make it so that it will auto-pair on
      -- `a<` but not `a <`
      -- The `:?:?` part makes it also
      -- work on Rust generics like `some_func::<T>()`
      cond.before_regex('%a+:?:?$', 3)
    ):with_move(function(opts)
      return opts.char == '>'
    end))
  end,
}
