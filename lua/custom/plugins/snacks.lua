---@module 'lazy'
---@type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Inline images, LaTeX math and mermaid diagrams via the Kitty graphics
    -- protocol. Needs Ghostty/kitty/wezterm, and `mmdc` on PATH for mermaid.
    image = {
      enabled = true,
      -- `svg` is not in the default list; added so exported D2 diagrams
      -- referenced from markdown render inline (converted via ImageMagick).
      formats = { 'svg', 'png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp', 'pdf' },
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
