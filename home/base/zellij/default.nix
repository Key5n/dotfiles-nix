{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  home.shellAliases = {
    "zj" = "zellij";
  };
}
