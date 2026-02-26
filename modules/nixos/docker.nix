{ user-name, ... }:
{
  virtualisation.docker = {
    enable = true;
  };

  users.users.${user-name}.extraGroups = [ "docker" ];
}
