{
  pkgs,
  lib,
  ...
}: {

  xsession.windowManager.i3 = {
    enable = true;

    # ignores all home-manager's default i3 config
    config = lib.mkForce null;
    extraConfig = builtins.readFile ./config;
  };

  home.file = {
    ".screenlayout/monitor.sh".source = ./triple-monitor.sh;
  };

  imports = [
    ./rofi
    ./picom
    ./polybar
    ./greenclip
    ./pcmanfm
  ];

  home.packages = with pkgs; [
    rofi
    dunst
    i3lock
    xautolock
    feh
    acpi
    arandr
    xbindkeys
    xorg.xbacklight
    xorg.xdpyinfo
    sysstat
  ];
}
