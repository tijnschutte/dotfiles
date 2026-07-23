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
