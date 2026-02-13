{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = lib.mkDefault (builtins.fromTOML (builtins.readFile ./starship.toml));
  };
}
