return {
  'debugloop/telescope-undo.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    { '<leader>su', '<cmd>Telescope undo<cr>', desc = '[S]earch [U]ndo history' },
  },
  config = function()
    require('telescope').load_extension 'undo'
  end,
}
