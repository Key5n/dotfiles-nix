-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- mason is unusable on NixOS, disable it.
    -- ensure_installed nothing
    opts = function(_, opts)
      opts.ensure_installed = nil
      opts.automatic_installation = false
    end,
    -- overrides `require("mason-lspconfig").setup(...)`
    -- opts = {
    --   ensure_installed = {
    --     "lua_ls",
    --     -- add more arguments for adding more language servers
    --   },
    -- },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      opts.ensure_installed = nil
      opts.automatic_installation = false
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      opts.ensure_installed = nil
      opts.automatic_installation = false
    end,
  },
}
