-- D2 diagrams: live browser preview and one-off SVG export.
-- Requires the `d2` CLI (brew install d2).

local function watching()
  return vim.b.d2_watch_job and vim.fn.jobwait({ vim.b.d2_watch_job }, 0)[1] == -1
end

-- `d2 --watch` serves the diagram and reloads the browser on every save.
-- `--scale 1` turns off D2's fit-to-screen default, which emits an SVG with no
-- width/height: it resizes to the viewport, so browser zoom refits it instead
-- of magnifying it. With a real size the page scrolls and zoom works.
local function toggle_watch()
  if watching() then
    vim.fn.jobstop(vim.b.d2_watch_job)
    vim.b.d2_watch_job = nil
    return vim.notify('d2: stopped watching', vim.log.levels.INFO)
  end

  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    return vim.notify('d2: save the buffer first', vim.log.levels.WARN)
  end

  vim.b.d2_watch_job = vim.fn.jobstart({ 'd2', '--watch', '--scale', '1', file }, {
    on_exit = function()
      vim.b.d2_watch_job = nil
    end,
  })
  vim.notify('d2: watching ' .. vim.fn.fnamemodify(file, ':t'), vim.log.levels.INFO)
end

local function export()
  local file = vim.api.nvim_buf_get_name(0)
  local out = vim.fn.fnamemodify(file, ':r') .. '.svg'
  vim.system({ 'd2', '--scale', '1', file, out }, { text = true }, function(res)
    vim.schedule(function()
      if res.code == 0 then
        vim.notify('d2: wrote ' .. vim.fn.fnamemodify(out, ':t'), vim.log.levels.INFO)
      else
        vim.notify('d2: ' .. (res.stderr ~= '' and res.stderr or 'export failed'), vim.log.levels.ERROR)
      end
    end)
  end)
end

-- Same reason as the global ones in the plugin spec: this shadows <leader>d.
pcall(vim.keymap.del, 'n', '<Leader>d2', { buffer = true })

vim.keymap.set('n', '<leader>w', toggle_watch, { buffer = true, desc = 'D2: Toggle [W]atch preview' })
vim.keymap.set('n', '<leader>e', export, { buffer = true, desc = 'D2: [E]xport to SVG' })
-- Toggle rather than `:D2Preview`, which only renders once. The split
-- re-renders on every write (d2-vim's `g:d2_ascii_autorender`, on by default).
vim.keymap.set('n', '<leader>v', '<cmd>D2PreviewToggle<cr>', { buffer = true, desc = 'D2: Toggle ASCII [V]iew' })
