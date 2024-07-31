{ pkgs, nixpkgs-unstable, ... }:
let pkgs-unstable = import nixpkgs-unstable {
    system = pkgs.system;
}; in {
  home.packages = with pkgs-unstable; [
    R
  ];
}
