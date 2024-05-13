{
  pkgs,
  lib,
  ...
}: {

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

  home.file."alias.zsh".source = ./alias.zsh;

  programs.zsh = {
    initExtra = ''
      source ~/alias.zsh
    '';
  };
}
