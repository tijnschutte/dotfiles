return {
  'MagicDuck/grug-far.nvim',
  keys = {
    { '<leader>fr', '<cmd>GrugFar<cr>', desc = '[F]ind and [R]eplace' },
    {
      '<leader>S',
      function()
        require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
      end,
      desc = '[S]earch & replace word (project-wide)',
    },
    {
      '<leader>S',
      function()
        require('grug-far').with_visual_selection()
      end,
      mode = 'v',
      desc = '[S]earch & replace selection (project-wide)',
    },
  },
  opts = {},
}
