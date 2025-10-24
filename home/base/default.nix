{ pkgs, ...}: {

  home.packages = with pkgs; [
    just
    openssl
    postman
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
    ./claude
  ];

  home.shellAliases = {
    e = "exit";
  };
}
