{ pkgs, nixpkgs-unstable, ... }:
let
  pkgs-unstable = import nixpkgs-unstable {
    system = pkgs.system;
  };
in
{
  home.packages = with pkgs-unstable; [
    # decided to install R through nix-shell
    # R
  ];
}
