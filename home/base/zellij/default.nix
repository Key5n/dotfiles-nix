let theme = (import ../../../modules/base/colorscheme).theme;
in {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    settings = {
      theme = "custom";
      themes.custom.fg = theme.scheme.colors.fg;
      themes.custom.bg = theme.scheme.colors.bg;
      themes.custom.black = theme.scheme.colors.bg;
      themes.custom.red = theme.scheme.colors.red;
      themes.custom.green = theme.scheme.colors.black;
      themes.custom.yellow = theme.scheme.colors.yellow;
      themes.custom.blue = theme.scheme.colors.blue;
      themes.custom.magenta = theme.scheme.colors.magenta;
      themes.custom.cyan = theme.scheme.colors.cyan;
      themes.custom.white = theme.scheme.colors.white;
      themes.custom.orange = theme.scheme.colors.green;
    };
  };

  home.shellAliases = {
    "zj" = "zellij";
  };
}
