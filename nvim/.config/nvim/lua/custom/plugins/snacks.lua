---@module 'lazy'
---@type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    { '<leader>z', function() Snacks.zen() end, desc = 'Toggle [Z]en (reading width)' },
    { '<leader>gg', function() Snacks.lazygit() end, desc = '[G]it: lazy[g]it' },
    { '<leader>n', function() Snacks.notifier.show_history() end, desc = '[N]otification history' },
  },
  init = function()
    -- ]] / [[ jump between LSP references (Snacks.words). Set buffer-local on LspAttach,
    -- because python/markdown ftplugins map ]] [[ per buffer and would win over a global map.
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local map = function(lhs, dir, desc) vim.keymap.set('n', lhs, function() Snacks.words.jump(dir * vim.v.count1) end, { buffer = ev.buf, desc = desc }) end
        map(']]', 1, 'Next reference')
        map('[[', -1, 'Previous reference')
      end,
    })
  end,
  ---@type snacks.Config
  opts = {
    lazygit = { enabled = true },
    -- vim.notify as corner pop-ups instead of command-line messages
    notifier = { enabled = true },
    -- LSP-aware highlight of the symbol under the cursor (replaces mini.cursorword)
    words = { enabled = true },

    -- Soft wrap alone still breaks at the window edge, which on a full-width pane is
    -- ~210 columns — around three times the length the eye tracks reliably on the
    -- return sweep. Zen centres the buffer at a readable measure instead.
    zen = {
      -- `dim` spotlights the current scope, which fights reading a document whole.
      toggles = { dim = false },
      win = { width = 90 },
    },

    -- Inline images, LaTeX math and mermaid diagrams via the Kitty graphics
    -- protocol. Needs Ghostty/kitty/wezterm, and `mmdc` on PATH for mermaid.
    image = {
      enabled = true,
      -- Left at the default formats: `svg` is absent on purpose. Conversion
      -- goes through ImageMagick, whose Homebrew build has no librsvg
      -- delegate, and its internal renderer dies on the @font-face fonts D2
      -- embeds. Reference the PNG from markdown instead.
      formats = { 'png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp', 'pdf' },
      doc = {
        inline = true,
        max_width = 80,
        max_height = 40,
      },
      convert = {
        notify = true,
      },
    },
  },
}
