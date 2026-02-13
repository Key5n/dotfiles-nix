# Repository Guidelines

## Project Structure & Module Organization

- `flake.nix` defines the Nix flake entry points; `flake.lock` pins dependencies.
- `hosts/` contains per-machine configs (e.g., `hosts/nixos-desktop/default.nix`, `hosts/Key5n-MacBook-Pro/default.nix`).
- `modules/` holds reusable NixOS/nix-darwin/Home Manager modules (`modules/nixos/`, `modules/darwin/`, `modules/base/`, `modules/hm/`).
- `homes/` contains Home Manager entrypoints per host (e.g., `homes/nixos-desktop/default.nix`, `homes/Key5n-MacBook-Pro/default.nix`).
- Linux-specific Home Manager configs (including UI assets) live under `modules/hm/` and `modules/hm/linux-utils/` (e.g., `modules/hm/i3/`, `modules/hm/hyprland/`, `modules/hm/linux-utils/`).

## Build, Test, and Development Commands

Use the `Justfile` shortcuts (recommended):

- `just darwin`: build + switch the macOS config for `Key5n-MacBook-Pro`.
- `just nixos`: switch the NixOS desktop config.
- `just wsl`: switch the NixOS WSL config.
- `just test`: run `nixos-rebuild test` for the desktop config.
- `just update`: `nix flake update` to refresh inputs.
- `just format`: format all supported file types.

Direct examples:

- `sudo nixos-rebuild switch --flake ~/dotfiles-nix#nixos-desktop`
- `nix build .#darwinConfigurations.Key5n-MacBook-Pro.system`

## Coding Style & Naming Conventions

- Follow existing Nix style; keep indentation consistent (most files use two spaces).
- Prefer lowercase file names with dashes when needed (e.g., `nixos-desktop`).
- Run `just format` before committing changes to formatted file types.

## Testing Guidelines

- There is no unit-test framework in this repo.
- Validate changes with `just test` (NixOS) or `just darwin` (macOS) depending on the target host.
- For Home Manager-only changes, run the relevant host switch command to ensure activation succeeds.

## Commit & Pull Request Guidelines

- Recent history mixes Conventional Commit-style subjects (e.g., `fix(codex): ...`) with short imperative summaries for docs.
- Follow that pattern: concise subject line, no trailing period, scope when helpful.
- PRs should describe the target host(s), summarize the module(s) touched, and include any manual steps required post-apply.

## Security & Configuration Tips

- Avoid committing real secrets; keep secrets out of version control and use NixOS secret mechanisms where possible (see `modules/base/secrets.nix`).
- When adding machine-specific settings, prefer `hosts/` overrides instead of hard-coding in shared modules.
