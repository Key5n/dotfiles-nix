-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  ---- Frontend & NodeJS
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.python" },
  -- there are duplicate mappings warnings in :checkhealth which-key due to the plugin
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  { import = "astrocommunity.docker.lazydocker" },
  { import = "astrocommunity.programming-language-support.csv-vim" },
  { import = "astrocommunity.completion.copilot-lua" },
}
