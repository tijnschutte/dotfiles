---@module 'lazy'
---@type LazySpec
return {
  -- Syntax highlighting, `d2 fmt` on save, and ASCII preview for D2
  -- (https://d2lang.com). Buffer-local keymaps live in `after/ftplugin/d2.lua`.
  -- Note: ```d2 fenced blocks in markdown stay unhighlighted -- treesitter owns
  -- markdown highlighting and nvim-treesitter ships no d2 parser.
  'terrastruct/d2-vim',
  ft = 'd2',
  init = function()
    -- Run `d2 validate` on write (off by default) so syntax errors land in the
    -- quickfix list instead of surfacing only when a render fails.
    vim.g.d2_validate_autosave = 1
  end,
  config = function()
    -- d2-vim installs global <Leader>d2 / <Leader>rd2 / <Leader>yd2 mappings,
    -- which shadow <leader>d (black hole delete) and <leader>y (yank to
    -- clipboard) behind a timeout. Drop them -- the :D2* commands still work.
    for _, map in ipairs { { 'v', '<Leader>d2' }, { 'v', '<Leader>rd2' }, { 'n', '<Leader>yd2' } } do
      pcall(vim.keymap.del, map[1], map[2])
    end
  end,
}
