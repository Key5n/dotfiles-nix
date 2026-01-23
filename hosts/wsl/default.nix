{
  nixos-wsl,
  pkgs,
  user-name,
  ...
}:
{
  imports = [
    nixos-wsl.nixosModules.default
    ../../modules/base/secrets.nix
  ];

  wsl = {
    enable = true;
    defaultUser = user-name;
    docker-desktop.enable = true;
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

  environment.shells = [
    pkgs.nushell
  ];
  programs.bash.interactiveShellInit = ''
    if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
      exec nu
    fi
  '';

  system.stateVersion = "25.05";
}
