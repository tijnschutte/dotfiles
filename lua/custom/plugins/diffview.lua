local opts = {
  icons = { folder_closed = '>', folder_open = 'v' },
  signs = { fold_closed = '>', fold_open = 'v' },
  use_icons = false,
}

-- `:DiffviewClose` only closes a view living in the *current* tabpage, so the
-- toggle has to look at the current tabpage too. Checking `lib.views` (which is
-- global) would make the key a no-op whenever you wander off the diffview tab.
local function toggle(open)
  return function()
    local lib = require 'diffview.lib'

    if lib.get_current_view() then
      vim.cmd 'DiffviewClose'
      return
    end

    local view = lib.views[1]
    if view and vim.api.nvim_tabpage_is_valid(view.tabpage) then
      vim.api.nvim_set_current_tabpage(view.tabpage)
      return
    end

    open()
  end
end

return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    {
      '<leader>gd',
      toggle(function()
        local layout = vim.o.columns < 120 and 'diff2_vertical' or 'diff2_horizontal'
        require('diffview').setup(vim.tbl_deep_extend('force', opts, {
          view = { default = { layout = layout } },
        }))
        vim.cmd 'DiffviewOpen'
      end),
      desc = '[G]it [D]iff toggle',
    },
    {
      '<leader>gh',
      toggle(function() vim.cmd 'DiffviewFileHistory %' end),
      desc = '[G]it file [H]istory toggle',
    },
    {
      '<leader>gH',
      toggle(function() vim.cmd 'DiffviewFileHistory' end),
      desc = '[G]it repo [H]istory toggle',
    },
  },
  opts = opts,
}
