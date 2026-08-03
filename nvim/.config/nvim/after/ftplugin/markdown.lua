-- Markdown: render-markdown.nvim controls. The plugin renders automatically on
-- BufEnter; these are for the two cases where you want to steer it.

-- Buffer-scoped rather than the global `toggle`, so dropping out of rendering to
-- copy raw markup out of one file leaves every other markdown buffer rendered.
vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown buf_toggle<cr>', { buffer = true, desc = 'Markdown: [T]oggle rendering' })

-- Opens a rendered read-only copy in a split to the right and turns rendering
-- off in this buffer, giving side-by-side source and output. Same key closes it.
vim.keymap.set('n', '<leader>mp', '<cmd>RenderMarkdown preview<cr>', { buffer = true, desc = 'Markdown: [P]review split' })

-- Buffer-local group label, so <leader>m only shows up in which-key here.
pcall(function()
  require('which-key').add { { '<leader>m', group = '[M]arkdown', buffer = 0 } }
end)
