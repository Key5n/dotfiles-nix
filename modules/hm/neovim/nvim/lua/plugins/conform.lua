-- Use Conform for Ruff-only formatting (Python)

---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      lsp_fallback = true,
    },
  },
}
