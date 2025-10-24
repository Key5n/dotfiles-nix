-- ~/.config/nvim/lua/user/plugins/dap_python.lua
return {
  "mfussenegger/nvim-dap-python",
  opts = {
    -- disable LuaRocks support completely
    rocks = {
      enabled = false,
    },
  },
}
