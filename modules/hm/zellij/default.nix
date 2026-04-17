{ lib, ... }:
let
  shellAliases = {
    "zj" = "zellij";
  };
in
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    layouts = {
      codex = builtins.readFile ./codex.kdl;
      edit = builtins.readFile ./edit.kdl;
    };

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
