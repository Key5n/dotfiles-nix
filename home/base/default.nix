{ pkgs, ...}: {

  home.packages = with pkgs; [
    just
  ];

  imports = [
    ./git
    ./alacritty
    ./zsh
    ./powerlevel10k
    ./node
    ./neovim
    ./haskell
    ./python
    ./latex
    ./c
    ./tmux
    # ./starship
    ./zellij
    ./julia
    ./kitty
    ./r
  ];

  home.shellAliases = {
    e = "exit";
  };
}
