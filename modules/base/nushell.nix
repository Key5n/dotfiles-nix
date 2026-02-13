{ pkgs, user-name, ... }:
{
  programs.nushell.enable = true;

  environment.shells = [
    pkgs.nushell
  ];

  users.users.${user-name}.shell = pkgs.nushell;
}
