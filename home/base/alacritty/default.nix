{
  pkgs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font = {
        normal.family = "FiraCode Nerd Font";
      };
    };
  };

}
