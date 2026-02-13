{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs.nixfmt.enable = true;
  programs.prettier.enable = true;

  settings.global.excludes = [
    "flake.lock"
    "modules/hm/hyprland/conf/wallpaper/**"
    "**/*.png"
    "**/*.jpg"
    "**/*.jpeg"
    "**/*.mp4"
    "**/*.ini"
    "**/*.conf"
    "**/*.rasi"
    "**/config"
  ];
}
