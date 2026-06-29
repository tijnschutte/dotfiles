return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    {
      '<leader>gd',
      function()
        if next(require('diffview.lib').views) then
          vim.cmd 'DiffviewClose'
        else
          vim.cmd 'DiffviewOpen'
        end
      end,
      desc = '[G]it [D]iff toggle',
    },
    {
      '<leader>gh',
      function()
        if next(require('diffview.lib').views) then
          vim.cmd 'DiffviewClose'
        else
          vim.cmd 'DiffviewFileHistory %'
        end
      end,
      desc = '[G]it file [H]istory toggle',
    },
    {
      '<leader>gH',
      function()
        if next(require('diffview.lib').views) then
          vim.cmd 'DiffviewClose'
        else
          vim.cmd 'DiffviewFileHistory'
        end
      end,
      desc = '[G]it repo [H]istory toggle',
    },
  },
  opts = {
    icons = { folder_closed = '>', folder_open = 'v' },
    signs = { fold_closed = '>', fold_open = 'v' },
    use_icons = false,
  },
}
