{
  config,
  pkgs,
  agenix,
  my-secrets,
  user-name,
  ...
}:
{
  imports = [
    agenix.nixosModules.default
  ];

  # if you changed this key, you need to regenerate all encrypt files from the decrypt contents!
  age.identityPaths = [
    # using the host key for decryption
    # the host key is generated on every host locally by openssh, and will never leave the host.
    # if your system doesn't have the ssh keys, you can generate through `sudo ssh-keygen -A`
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  age.secrets."coding-agent-api-keys" = {
    file = "${my-secrets}/coding-agent-api-keys.age"; # refer to ./xxx.age located in `mysecrets` repo
    owner = user-name;
  };

  environment.etc."profile.d/coding-agent.sh".text = ''
    set -a
    [ -f ${config.age.secrets.coding-agent-api-keys.path} ] && source ${config.age.secrets.coding-agent-api-keys.path}
    set +a
  '';
}
