{
  pkgs,
  ...
}: {
  services.polybar = {
    enable = true;
    script = builtins.readFile ./config/scripts/launch.sh;
    package = pkgs.polybar.override {
      i3Support = true;
    };
  };

  xdg.configFile."polybar" = {
    source = ./config;
    recursive = true;
    executable = true;
  };
}
