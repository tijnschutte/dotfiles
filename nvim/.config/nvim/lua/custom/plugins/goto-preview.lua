return {
  'rmagatti/goto-preview',
  event = 'LspAttach',
  keys = {
    -- On <leader>p rather than gp*: gp is mini.operators' replace prefix, so gpd would
    -- wait on timeoutlen before replacing.
    { '<leader>pd', function() require('goto-preview').goto_preview_definition() end, desc = '[P]review [D]efinition' },
    { '<leader>pi', function() require('goto-preview').goto_preview_implementation() end, desc = '[P]review [I]mplementation' },
    { '<leader>pc', function() require('goto-preview').close_all_win() end, desc = '[P]review [C]lose all' },
  },
  opts = {
    default_mappings = false,
  },
}
