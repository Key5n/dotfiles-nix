{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  # install alacritty v0.13.2 or later, toml configuration not yaml
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.5;
    };
    package = pkgs-unstable.alacritty;
  };
}
