{ pkgs, user-name, ... }:
{
  programs.zsh.enable = true;

  environment.shells = [
    pkgs.zsh
  ];

  users.users.${user-name}.shell = pkgs.zsh;
}
