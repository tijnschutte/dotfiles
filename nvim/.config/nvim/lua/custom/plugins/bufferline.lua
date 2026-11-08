-- Open buffers as tabs along the top; cycle them with `[b` / `]b` (mini.bracketed).
return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin' },
  event = 'VeryLazy',
  keys = {
    { '<leader>bd', function() Snacks.bufdelete() end, desc = '[B]uffer [D]elete' },
    { '<leader>bo', function() Snacks.bufdelete.other() end, desc = '[B]uffers: close [O]thers' },
    { '<leader>bD', function() Snacks.bufdelete.all() end, desc = '[B]uffers: close all' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = '[B]uffer [P]in' },
    { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = '[B]uffers: close un[P]inned' },
  },
  opts = {
    options = {
      separator_style = 'slant',
      -- Snacks.bufdelete keeps the window (and the split layout) when closing a buffer.
      close_command = function(n) Snacks.bufdelete(n) end,
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
      diagnostics = 'nvim_lsp',
      -- Hide the empty startup buffer; an unnamed buffer you typed into stays visible.
      custom_filter = function(buf) return vim.api.nvim_buf_get_name(buf) ~= '' or vim.bo[buf].modified end,
      offsets = { { filetype = 'snacks_layout_box', text = 'Files', highlight = 'Directory', separator = true } },
    },
    -- Catppuccin's theme goes fully transparent with transparent_background, which makes the
    -- bar invisible. Repaint it as a header: crust strip, active tab in base like the editor.
    -- shortcut: uses the catppuccin palette whatever the active theme, swap if you change theme.
    highlights = function()
      local C = require('catppuccin.palettes').get_palette()
      local hl = require('catppuccin.special.bufferline').get_theme()()
      for name, g in pairs(hl) do
        g.bg = name:find 'selected' and C.base or C.crust
        -- slant separators are drawn in fg, so it must match the strip to form the slope
        if name:find 'separator' then g.fg = C.crust end
      end
      return hl
    end,
  },
}
