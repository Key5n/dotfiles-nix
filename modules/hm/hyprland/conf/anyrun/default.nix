{ anyrun, pkgs, ... }:
let
  theme = (import ../../../../base/colorscheme).theme;
in
{
  imports = [
    anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;

    config = {
      x.fraction = 0.5;
      y.fraction = 0.3;
      width.fraction = 0.3;

      hidePluginInfo = true;
      closeOnClick = true;

      plugins = with anyrun.packages.${pkgs.system}; [
        applications
        stdin # for clipboard manager
        # randr
        # rink
        # shell
        # translate
      ];
    };

    extraCss = ''
      @define-color fg ${theme.scheme.colors.fg};
      /*
        TODO: create a function transforms hex values to rgba
        The value is bg of iceberg with opacity 0.8
      */
      @define-color bg rgba(22, 24, 33, 0.8);
      @define-color border ${theme.scheme.modifier.selected};
      @define-color selected ${theme.scheme.modifier.selected};

      * {
        font-family: "FiraCode Nerd Font";
        font-size: 1.25rem;
        color: @fg;
      }

      #window {
        background-color: transparent;
      }

      #entry {
        background-color: @bg;
      }

      #main {
        background-color: @bg;
        padding: 0.75rem;
        border-radius: 0.25rem;
      }

      #plugin {
        background-color: @bg;
      }

      #match {
        padding: 0.25rem;
        border-radius: 0.25rem;
      }

      #match:selected {
        background-color: @selected;
      }
    '';
  };
}
