{ ... }: {
  wayland.windowManager.hyprland.settings.env = [
    # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
    "LIBVA_DRIVER_NAME,nvidia"
    "XDG_SESSION_TYPE,wayland"
    "GBM_BACKEND,nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    # fix https://github.com/hyprwm/Hyprland/issues/1520
    "WLR_NO_HARDWARE_CURSORS,1"
  ];
}
