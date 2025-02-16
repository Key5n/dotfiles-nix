{ pkgs, ...}:  let
  package = pkgs.hyprland;
in {
  imports = [
    ./nvidia.nix
    ./conf/anyrun
  ];

  wayland.windowManager.hyprland = {
    inherit package;
    enable = true;

    extraConfig = builtins.readFile ./hyprland.conf;
    plugins = [
      pkgs.hyprlandPlugins.hyprwinwrap
    ];
  };

  home.file.".wayland-session" = {
    source = "${package}/bin/Hyprland";
    executable = true;
  };

  home.packages = with pkgs; [
    mpv
    mpvpaper
    swayidle
    swaylock
    wlogout
    # wlroots
    wl-clipboard
    cliphist # wayland clipboard manager
    waybar
    wofi
    mako
    grim
    slurp
    swappy
    wf-recorder
    yad
    gnome.nautilus
    # geany
    mpd
    mpc-cli
    ncmpcpp
    # viewnior
    # imagemagick
    # polkit_gnome
    # xorg-xwayland

    alsa-utils
    cava

    hyprpicker
    networkmanagerapplet
  ];

  # hyprland configs, based on https://github.com/notwidow/hyprland
  xdg.configFile = {
    "hypr/mako" = {
      source = ./conf/mako;
      recursive = true;
    };
    "hypr/scripts" = {
      source = ./conf/scripts;
      recursive = true;
      executable = true;
    };
    "waybar" = {
      source = ./conf/waybar;
      recursive = true;
    };
    "anyrun" = {
      source = ./conf/anyrun;
      recursive = true;
    };
    "hypr/wlogout" = {
      source = ./conf/wlogout;
      recursive = true;
    };
    "wallpaper" = {
      source = ./conf/wallpaper;
      recursive = true;
    };
    # music player - mpd
    # "mpd" = {
    #   source = ../conf/mpd;
    #   recursive = true;
    # };
  };


  programs.google-chrome = {
    enable = true;
    # https://wiki.archlinux.org/title/Chromium#Native_Wayland_support
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
      # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
      # (only supported by chromium/chrome at this time, not electron)
      "--gtk-version=4"
      # make it use text-input-v1, which works for kwin 5.27 and weston
      "--enable-wayland-ime"

      # enable hardware acceleration - vulkan api
      # "--enable-features=Vulkan"
    ];
  };
}
