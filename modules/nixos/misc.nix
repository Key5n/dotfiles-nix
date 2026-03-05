{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  git-local = pkgs.writeShellScriptBin "git-local" ''
    set -euo pipefail

    target_path="''${1:-./flake.nix}"

    git add --intent-to-add "$target_path"
    git update-index --skip-worktree --assume-unchanged "$target_path"
  '';
in
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Install firefox.
  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    git-local
  ];
}
