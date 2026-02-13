{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    openssl
    postman
  ];

  imports = [
    ./git
    ./alacritty
    ./zsh
    ./nushell
    ./powerlevel10k
    ./node
    ./neovim
    ./haskell
    ./python
    ./latex
    ./c
    ./tmux
    ./starship
    ./zellij
    ./julia
    ./kitty
    ./r
    ./container
    ./yazi
    ./coding-agent
  ];
}
