---@type LazySpec
return {
  "lervag/vimtex",
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_latexmk_engines = {
      ["_"] = "-lualatex",
    }
  end,
}
