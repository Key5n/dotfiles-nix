{ pkgs, ... }:
{
  home.packages = with pkgs; [
    postman
  ];

  imports = [
    ../../alacritty
    ../../kitty/default.nix
  ];
}
