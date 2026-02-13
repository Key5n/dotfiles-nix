{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;

      shellAliases = {
        e = "exit";
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
