set shell := ["zsh", "-uc"]

hostname := "Key5n-MacBook-Pro"

[macos]
switch:
  just darwin

[linux]
switch:
  if [[ -r /proc/sys/kernel/osrelease ]] && grep -qi microsoft /proc/sys/kernel/osrelease; then
    just wsl
  else
    just nixos
  fi

darwin:
  nix build .#darwinConfigurations.{{hostname}}.system --extra-experimental-features 'nix-command flakes' --show-trace
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#{{hostname}}

nixos:
  sudo nixos-rebuild switch --flake ~/dotfiles-nix#nixos-desktop

wsl:
  sudo nixos-rebuild switch --flake ~/dotfiles-nix#nixos-wsl

test:
  sudo nixos-rebuild test --flake ~/dotfiles-nix#nixos-desktop

list-generations:
  nixos-rebuild list-generations

update:
  nix flake update

format:
  nix fmt
