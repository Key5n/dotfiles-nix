{ host-name, user-name, ... }:
{
  networking.hostName = host-name;
  networking.computerName = host-name;

  users.users."${user-name}" = {
    home = "/Users/${user-name}";
    description = user-name;
  };

  nix.settings.trusted-users = [ user-name ];
  nix.enable = false;
}
