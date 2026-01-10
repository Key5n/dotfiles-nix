{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  users.users.nixos.shell = pkgs.zsh;

  system.stateVersion = "25.05";
}
