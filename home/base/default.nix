{ pkgs, ...}: {

  home.packages = with pkgs; [
    just
    openssl
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
    ./gpg
    ./container
    ./yazi
  ];

  home.shellAliases = {
    e = "exit";
  };
}
