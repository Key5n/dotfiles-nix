{ ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
