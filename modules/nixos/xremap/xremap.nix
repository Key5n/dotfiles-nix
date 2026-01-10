{
  pkgs,
  xremap-flake,
  ...
}:
{
  imports = [
    xremap-flake.nixosModules.default
  ];

  services.xremap.config = {
    modmap = [
      {
        remap = {
          "CapsLock" = "Control_L";
        };
      }
    ];
  };
}
