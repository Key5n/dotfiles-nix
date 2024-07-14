set shell := ["zsh", "-uc"]

hostname := "Key5n-MacBook-Pro"

darwin:
  nix build .#darwinConfigurations.{{hostname}}.system --extra-experimental-features 'nix-command flakes'
  ./result/sw/bin/darwin-rebuild switch --flake .#{{hostname}}

nixos:
  sudo nixos-rebuild switch --flake ~/dotfiles-nix#nixos-desktop

test:
  sudo nixos-rebuild test --flake ~/dotfiles-nix#nixos-desktop

list-generations:
  nixos-rebuild list-generations

update:
  nix flake update
