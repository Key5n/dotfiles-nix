{
  pkgs,
  ...
}: {
  services.polybar = {
    enable = true;
    script = builtins.readFile ./config/scripts/launch.sh;
  };

  xdg.configFile."polybar" = {
    source = ./config;
    recursive = true;
    executable = true;
  };
}
