{
  pkgs,
  ...
}: {
  xdg.configFile."i3/config".source = ./config;

  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    rofi
    dunst
    i3blocks
    i3lock
    xautolock
    i3status
    i3-gaps
    picom
    feh
    acpi
    arandr
    dex
    xbindkeys
    xorg.xbacklight
    xorg.xdpyinfo
    sysstat
  ];
}
