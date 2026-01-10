{ ... }:
{
  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = false;
        };
      };
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";
    };

    displayManager = {
      # Enable automatic login for the user.
      autoLogin = {
        enable = true;
        user = "key5n";
      };
    };
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
