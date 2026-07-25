-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local is_ssh_session = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil

vim.opt.autoread = true

local autoread_group = vim.api.nvim_create_augroup("UserAutoread", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = autoread_group,
  command = "checktime",
})

local uv = vim.uv or vim.loop
local autoread_watchers = {}

local function stop_autoread_watcher(bufnr)
  local watcher = autoread_watchers[bufnr]
  if watcher then
    watcher:stop()
    watcher:close()
    autoread_watchers[bufnr] = nil
  end
end

local function start_autoread_watcher(bufnr)
  stop_autoread_watcher(bufnr)

  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then return end

  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == "" or vim.fn.filereadable(filename) ~= 1 then return end

  local watcher = uv.new_fs_event()
  if not watcher then return end

  local ok = watcher:start(filename, {}, function()
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then vim.cmd("checktime " .. bufnr) end
    end)
  end)

  if ok then
    autoread_watchers[bufnr] = watcher
  else
    watcher:close()
  end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufFilePost" }, {
  group = autoread_group,
  callback = function(args) start_autoread_watcher(args.buf) end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = autoread_group,
  callback = function(args) stop_autoread_watcher(args.buf) end,
})

if is_ssh_session then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")

  if ok then
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = osc52.copy "+",
        ["*"] = osc52.copy "*",
      },
      paste = {
        ["+"] = function() return { vim.fn.split(vim.fn.getreg "", "\n"), vim.fn.getregtype "" } end,
        ["*"] = function() return { vim.fn.split(vim.fn.getreg "", "\n"), vim.fn.getregtype "" } end,
      },
    }

    vim.opt.clipboard:append "unnamedplus"
  end
end
