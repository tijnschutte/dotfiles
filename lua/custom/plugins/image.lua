---@module 'lazy'
---@type LazySpec
return {
  '3rd/image.nvim',
  build = false,
  opts = {
    backend = 'kitty',
    processor = 'magick_cli',
    integrations = {
      markdown = { enabled = true },
    },
    max_width = 200,
    max_height = 40,
    editor_only_render_when_focused = true,
  },
}
