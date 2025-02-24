{ ... }: {
  services = {
    xserver =  {
      enable = false;
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          # Wayland Desktop Manager is installed only for user ryan via home-manager!
          user = "key5n";
          # .wayland-session is a script generated by home-manager, which links to the current wayland compositor(sway/hyprland or others).
          # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config here.
          command = "$HOME/.wayland-session"; # start a wayland session directly without a login manager
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd $HOME/.wayland-session";  # start wayland session with a TUI login manager
        };
      };
    };
  };
  # fix https://github.com/ryan4yin/nix-config/issues/10
  security.pam.services.swaylock = {};
}
