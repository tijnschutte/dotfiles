-- Open JSON with everything but the top-level keys folded away.
--
-- Deferred because the treesitter FileType autocmd (see the nvim-treesitter
-- spec in init.lua) is registered after the built-in ftplugin one, so it runs
-- last and would reset foldlevel to 99 right after this file is sourced.
local win = vim.api.nvim_get_current_win()
vim.schedule(function()
  if vim.api.nvim_win_is_valid(win) then
    vim.wo[win].foldlevel = 1
  end
end)
