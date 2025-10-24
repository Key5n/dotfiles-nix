{ hostName, userName, ... }: {
  networking.hostName = hostName;
  networking.computerName = hostName;

  users.users."${userName}"= {
    home = "/Users/${userName}";
    description = userName;
  };

  nix.settings.trusted-users = [ userName ];
  nix.enable = false;
}