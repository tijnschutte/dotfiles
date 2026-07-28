return {
  'debugloop/telescope-undo.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    { '<leader>su', '<cmd>Telescope undo<cr>', desc = '[S]earch [U]ndo history' },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        undo = {
          layout_strategy = 'vertical',
          layout_config = {
            preview_height = 0.6,
          },
        },
      },
    }
    require('telescope').load_extension 'undo'
  end,
}
