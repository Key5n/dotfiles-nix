{ pkgs-2025-06-16, ... }: {
  # nixpkgs/24.11 doesn't have
  home.packages = with pkgs-2025-06-16; [
     claude-code
  ];
}
