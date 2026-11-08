-- Floating cmdline popup (`:`, `/`, `?`), centered near the bottom of the screen.
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    -- Only the cmdline: snacks.notifier keeps notifications, LSP UI stays untouched.
    messages = { enabled = false },
    notify = { enabled = false },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
      message = { enabled = false },
    },
    views = {
      cmdline_popup = {
        position = { row = '85%', col = '50%' },
        size = { width = 60, height = 'auto' },
      },
    },
  },
}
