{ ... }: let
  theme = (import ../../../modules/base/colorscheme).theme;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      window.option_as_alt = "Both";
      font = {
        normal.family = "FiraCode Nerd Font";
      };
      colors.normal = {
        white = theme.scheme.colors.white;
        black = theme.scheme.colors.black;
        red = theme.scheme.colors.red;
        yellow = theme.scheme.colors.yellow;
        green = theme.scheme.colors.green;
        cyan = theme.scheme.colors.cyan;
        blue = theme.scheme.colors.blue;
        magenta = theme.scheme.colors.magenta;
      };
    };
  };

}
