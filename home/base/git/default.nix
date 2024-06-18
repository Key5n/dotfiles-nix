{
  pkgs,
  lib,
  config,
  ...
}: 
with lib;
let zsh_cfg = config.programs.zsh;
in {

  config = {

    programs.git = {
      enable = true;
      userName  = "Key5n";
      userEmail = "k.nogami.472@stn.nitech.ac.jp";
      extraConfig = {
        push = {
          autoSetupRemote = true;
        };
        init = {
          defaultBranch = "main";
        };
        core = {
          editor = "vim";
        };
      };
    };

    xdg.configFile."git/alias.zsh".source = mkIf zsh_cfg.enable ./alias.zsh;

    programs.zsh = mkIf zsh_cfg.enable {
      initExtra = ''
        source ~/.config/git/alias.zsh
      '';
    };
  };
}
