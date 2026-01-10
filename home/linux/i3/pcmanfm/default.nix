{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    pcmanfm
  ];

  xdg.mimeApps = {
    defaultApplications = {
      "inode/directory" = [ "pcmanfm.desktop" ];
    };
  };
}
