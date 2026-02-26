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
        src = pkgs.zsh-autocomplete;
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
