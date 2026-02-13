# NixOS Desktop Setup

Installation

```sh
sudo nixos-rebuild switch --flake github:Key5n/dotfiles-nix#nixos-desktop
```

## Dual Boot with Windows

- You need to copy the Windows boot loader to the Linux ESP. Then `systemd-boot` auto detection works.

## VPN Setup

1. First, change the university password in `/modules/nixos/network.nix`.
2. If you don’t have the certificate, download it.

```
# Connect
sudo swanctl --initiate --child net

# Disconnect
sudo swanctl --terminate --child net

# Check connection status (only shown when connected)
sudo swanctl --list-sas
```
