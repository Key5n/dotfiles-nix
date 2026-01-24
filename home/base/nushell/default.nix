{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
