{
  pkgs,
  lib,
  ...
}:
let
  shellAliases = {
    ll = "ls -l";
    la = "ls -la";
    c = "code -r";
    e = "exit";
  };
in
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;

    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "25.03.19";
          sha256 = "sha256-eb5a5WMQi8arZRZDt4aX1IV+ik6Iee3OxNMCiMnjIx4=";
        };
      }
    ];

    initContent = lib.mkIf pkgs.stdenv.isLinux ''
      bindkey "''${key[Up]}" up-line-or-search
    '';
  };

  # only works in bash/zsh, not nushell
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;
}
