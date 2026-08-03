---@module 'lazy'
---@type LazySpec
return {
  -- In-buffer markdown rendering: headings, bullets, tables and code blocks are
  -- drawn as decorations over the source. Nothing is rewritten on disk, and the
  -- line under the cursor un-conceals back to raw markup so editing still works
  -- (`anti_conceal`, on by default).
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- Completion for callouts, checkboxes and link references.
    completions = { blink = { enabled = true } },

    -- snacks.image already renders math via the Kitty graphics protocol. This
    -- path is text-only (it shells out to `latex2text` from pylatexenc) and
    -- would decorate the same nodes twice.
    latex = { enabled = false },

    -- Heading signs would share the sign column with gitsigns, which pushes the
    -- git marks around whenever a heading scrolls into view.
    sign = { enabled = false },

    heading = {
      -- `block` sizes the background to the heading text rather than bleeding to
      -- the window edge, which on a full-width pane is a very long colour bar.
      width = 'block',
      min_width = 40,
      icons = vim.g.have_nerd_font and { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' } or {},
    },

    code = {
      width = 'block',
      min_width = 40,
      -- Insets the code away from the background edge so the tint reads as a
      -- container instead of highlighted text.
      left_pad = 2,
      right_pad = 2,
      language_pad = 2,
    },

    -- Plain Unicode rather than the Nerd Font defaults, so these render whether
    -- or not `have_nerd_font` is set.
    bullet = { icons = { '●', '○', '◆', '◇' } },
    checkbox = {
      unchecked = { icon = '☐ ', highlight = 'RenderMarkdownUnchecked' },
      checked = { icon = '☑ ', highlight = 'RenderMarkdownChecked' },
    },
  },
}
