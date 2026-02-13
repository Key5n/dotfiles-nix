## Repository Structure

- `flake.nix` is the flake entry point; `outputs.nix` holds all outputs logic.
- `hosts/` contains per-host system configs, each in `hosts/<HOST>/default.nix`.
- `homes/` contains per-host Home Manager entrypoints, each in `homes/<HOST>/default.nix`.
- `modules/` holds reusable modules:
  - `modules/nixos/`, `modules/darwin/`, `modules/base/` for system modules.
  - `modules/hm/` for Home Manager modules

## References

- https://daiderd.com/nix-darwin/manual/index.html
- https://github.com/ryan4yin/nix-darwin-kickstarter/blob/main/minimal/flake.nix
- https://github.com/KubqoA/dotfiles/tree/main
