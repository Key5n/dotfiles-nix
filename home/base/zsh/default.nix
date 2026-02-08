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
          rev = "23.07.13";
          sha256 = "0NW0TI//qFpUA2Hdx6NaYdQIIUpRSd0Y4NhwBbdssCs=";
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
