return {
  'rmagatti/goto-preview',
  event = 'LspAttach',
  keys = {
    { 'gpd', function() require('goto-preview').goto_preview_definition() end, desc = '[G]oto [P]review [D]efinition' },
    { 'gpi', function() require('goto-preview').goto_preview_implementation() end, desc = '[G]oto [P]review [I]mplementation' },
    { 'gP', function() require('goto-preview').close_all_win() end, desc = '[G]oto [P]review close' },
  },
  opts = {
    default_mappings = false,
  },
}
