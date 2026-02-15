{ lib, ... }:
let
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
      theme = lib.mkDefault "default";
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
