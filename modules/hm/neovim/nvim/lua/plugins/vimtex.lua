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
      -- pLaTeX -> DVI -> PDF via dvipdfmx
      ["platex"] = "-pdfdvi -latex='platex %O %S' -e '$dvipdf=q/dvipdfmx %O -o %D %S/'",

      ["uplatex"] = "-pdfdvi -latex='uplatex %O %S' -e '$dvipdf=q/dvipdfmx %O -o %D %S/'",
    }
  end,
}
