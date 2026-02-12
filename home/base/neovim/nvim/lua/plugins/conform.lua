-- Use Conform for Ruff-only formatting (Python)

---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      lsp_fallback = true,
    },
    formatters_by_ft = {
      python = {
        "ruff_fix",
        "ruff_format",
        "ruff_organize_imports",
      },
    },
  },
}
