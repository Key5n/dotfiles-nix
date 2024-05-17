{
  pkgs,
  config,
  ...
}: {
  home.file.".config/i3/config".source = ./config;
}
