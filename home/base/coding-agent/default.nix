{ pkgs, ... }:
{
  # nixpkgs/24.11 doesn't have
  home.packages = with pkgs; [
    claude-code
    codex
    gemini-cli
  ];
}
