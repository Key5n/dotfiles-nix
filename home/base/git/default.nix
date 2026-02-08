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
      gh
    ];

    programs.git = {
      enable = true;

      settings = {
        user = {
          email = "key_ngmn@outlook.jp";
          name = "Key5n";
          signingkey = "~/.ssh/id_ed25519.pub";
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
        gpg = {
          format = "ssh";
        };
        commit = {
          gpgsign = true;
        };
      };
    };

    xdg.configFile."git/alias.zsh".source = mkIf zsh_cfg.enable ./alias.zsh;
    programs.lazygit = {
      enable = true;
      settings = {
        refresher = {
          refreshInterval = 1;
        };
        git.pagers = [
          {
            pager = "delta --paging=never";
          }
        ];
        promptToReturnFromSubprocess = false;
      };
    };

    programs.zsh = mkIf zsh_cfg.enable {
      initContent = ''
        source ~/.config/git/alias.zsh
      '';
    };
  };
}
