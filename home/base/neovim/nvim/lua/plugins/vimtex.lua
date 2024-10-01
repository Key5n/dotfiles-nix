---@type LazySpec
return {
  "lervag/vimtex",
  init = function()
    if vim.loop.os_uname().sysname == "Darwin" then
      vim.g.vimtex_view_method = "skim" -- Use Skim for macOS
    else
      vim.g.vimtex_view_method = "zathura" -- Use Zathura for other systems
    end
    vim.g.vimtex_compiler_latexmk_engines = {
      ["_"] = "-lualatex",
    }
  end,
}
