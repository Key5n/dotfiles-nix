{ pkgs, ... }:
let
  shellAliases = {
    lad = "lazydocker";
  };
in
{
  home.packages = with pkgs; [
    dive
    lazydocker
  ];

  # only works in bash/zsh, not nushell
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;
}
