-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  debug = true,
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    local formatting = null_ls.builtins.formatting

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      formatting.stylua,
      formatting.prettierd,
      require "none-ls.formatting.eslint",

      require "none-ls.diagnostics.eslint",
      require "none-ls.code_actions.eslint",
    }
    return config -- return final config table
  end,
}
