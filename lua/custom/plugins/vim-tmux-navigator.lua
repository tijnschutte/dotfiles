return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  keys = {
    { '<C-h>', '<cmd>TmuxNavigateLeft<CR>', desc = 'Navigate left (vim/tmux)' },
    { '<C-j>', '<cmd>TmuxNavigateDown<CR>', desc = 'Navigate down (vim/tmux)' },
    { '<C-k>', '<cmd>TmuxNavigateUp<CR>', desc = 'Navigate up (vim/tmux)' },
    { '<C-l>', '<cmd>TmuxNavigateRight<CR>', desc = 'Navigate right (vim/tmux)' },
  },
}
