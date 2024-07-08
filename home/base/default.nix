{ pkgs, ...}: {

  home.packages = with pkgs; [
    just
  ];

  imports = [
    ./git
    ./alacritty
    ./zsh
    # ./powerlevel10k
    ./node
    ./neovim
    ./haskell
    ./poetry
    ./latex
    ./c
    ./tmux
    ./starship
    ./zellij
    ./julia
  ];

  home.shellAliases = {
    e = "exit";
  };
}
