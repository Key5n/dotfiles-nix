{ lib, ... }:
let
  shellAliases = {
    "zj" = "zellij";
  };
in
{
  xdg.configFile = {
    "zellij/layouts/nitechbb-web.kdl".source = ./nitechbb-web.kdl;
    "zellij/layouts/lazygit.kdl".source = ./lazygit.kdl;
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    settings = {
      theme = lib.mkDefault "default";
      show_startup_tips = false;
      keybinds = {
        unbind = [ "Alt l" ];
      };
    };
  };

  # only works in bash/zsh, not nushell
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;
}
