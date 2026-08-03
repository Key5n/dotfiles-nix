{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    openssl
    wget
  ];

  imports = [
    ../../../base/colorscheme
    ../../c
    ../../coding-agent
    ../../container
    ../../git
    ../../haskell
    ../../julia
    ../../latex
    ../../neovim
    ../../node
    ../../python
    ../../starship
    ../../yazi
    ../../zellij
    ../../zsh
    ../../zoxide
  ];
}
