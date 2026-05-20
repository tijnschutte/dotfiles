return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup()
    vim.keymap.set('n', '<leader>fr', '<cmd>GrugFar<cr>', { desc = '[F]ind and [R]eplace' })
  end,
}
