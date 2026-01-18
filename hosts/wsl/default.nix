{
  nixos-wsl,
  pkgs,
  user-name,
  ...
}:
{
  imports = [
    nixos-wsl.nixosModules.default
    # ../../modules/base/secrets.nix
  ];

  wsl = {
    enable = true;
    defaultUser = user-name;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Need to install fira-code and configure terminal in Windows
  fonts.packages = with pkgs; [
    fira-code
  ];

  programs.zsh.enable = true;
  users.users.${user-name}.shell = pkgs.zsh;

  system.stateVersion = "25.05";
}
