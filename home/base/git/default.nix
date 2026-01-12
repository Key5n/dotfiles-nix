{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  zsh_cfg = config.programs.zsh;
in
{

  config = {

    home.packages = with pkgs; [
      delta
    ];

    programs.git = {
      enable = true;

      settings = {
        user = {
          email = "k.nogami.472@stn.nitech.ac.jp";
          name = "Key5n";
        };
        push = {
          autoSetupRemote = true;
        };
        init = {
          defaultBranch = "main";
        };
        core = {
          editor = "vim";
          pager = "delta";
        };
        interactive = {
          diffFilter = "delta --color-only";
        };
        delta = {
          navigate = true;
          side-by-side = true;
        };
        merge = {
          conflictStyle = "zdiff3";
        };
      };
    };

    xdg.configFile."git/alias.zsh".source = mkIf zsh_cfg.enable ./alias.zsh;
    programs.lazygit = {
      enable = true;
      settings = {
        git.pagers = [
          {
            pager = "delta --paging=never";
          }
        ];
      };
    };

    programs.zsh = mkIf zsh_cfg.enable {
      initContent = ''
        source ~/.config/git/alias.zsh
      '';
    };
  };
}
