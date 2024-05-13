{
  pkgs,
  ...
}: {
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
        lightdm.enable = false;
        gdm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
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
    };

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };
}
