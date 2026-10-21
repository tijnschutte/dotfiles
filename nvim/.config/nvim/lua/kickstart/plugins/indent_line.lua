-- Add indentation guides even on blank lines

---@module 'lazy'
---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  -- Without tab_char, ibl copies listchars' tab, which is blank, so tab-indented files lose their guides.
  ---@module 'ibl'
  ---@type ibl.config
  opts = { indent = { tab_char = '▎' } },
}
