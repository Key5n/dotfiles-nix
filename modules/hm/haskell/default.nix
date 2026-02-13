{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    stack
    haskellPackages.hlint
    haskellPackages.haskell-language-server
  ];
}
