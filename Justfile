hostname := "Key5n-MacBook-Pro"

darwin:
  nix build .#darwinConfigurations.{{hostname}}.system --extra-experimental-features 'nix-command flakes'
  ./result/sw/bin/darwin-rebuild switch --flake .#{{hostname}}

update:
  nix flake update

