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

    home.packages = with pkgs; [
      lazygit
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
        };
      };
    };

    xdg.configFile."git/alias.zsh".source = mkIf zsh_cfg.enable ./alias.zsh;

    programs.zsh = mkIf zsh_cfg.enable {
      initContent = ''
        source ~/.config/git/alias.zsh
      '';
    };
  };
}
