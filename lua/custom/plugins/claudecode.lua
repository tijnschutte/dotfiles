return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  event = 'VeryLazy',
  keys = {
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = '[A]I [S]end to Claude' },
  },
  opts = {
    terminal = { provider = 'none' },
  },
}
