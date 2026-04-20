-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local is_ssh_session = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil

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
