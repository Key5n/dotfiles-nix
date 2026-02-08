{ pkgs, ... }:
let
  theme = (import ../../../modules/base/colorscheme).theme;
  shellAliases = {
    "zj" = "zellij";
  };
in
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    layouts = {
      codex-3-horizontal = {
        layout = {
          _children = [
            {
              tab = {
                _props = {
                  name = "codex";
                  split_direction = "horizontal";
                };
                _children = [
                  {
                    pane = {
                      command = "codex";
                    };
                  }
                  {
                    pane = {
                      command = "codex";
                    };
                  }
                  {
                    pane = {
                      command = "codex";
                    };
                  }
                ];
              };
            }
          ];
        };
      };
    };

    settings = {
      theme = "custom";
      themes.custom.fg = theme.scheme.colors.fg;
      themes.custom.bg = theme.scheme.colors.bg;
      themes.custom.black = theme.scheme.colors.black;
      themes.custom.red = theme.scheme.colors.red;
      themes.custom.green = theme.scheme.colors.green;
      themes.custom.yellow = theme.scheme.colors.yellow;
      themes.custom.blue = theme.scheme.colors.blue;
      themes.custom.magenta = theme.scheme.colors.magenta;
      themes.custom.cyan = theme.scheme.colors.cyan;
      themes.custom.white = theme.scheme.colors.white;
      themes.custom.orange = theme.scheme.colors.green;
      show_startup_tips = false;
      keybinds = {
        unbind = [ "Alt l" ];
      };
    };
  };

  # only works in bash/zsh, not nushell
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;
}
