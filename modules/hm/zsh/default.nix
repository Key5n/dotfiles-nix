{ ... }:
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
  };

  # only works in bash/zsh, not nushell
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;
}
