{pkgs, ...}: {
  imports = [
    ./games.nix
    ./calibre.nix
  ];

  home.packages = with pkgs; [
    libnotify
    wireguard-tools # manage wireguard vpn manually, via wg-quick

    # ventoy # create bootable usb
    # virt-viewer # vnc connect to VM, used by kubevirt

    imv # simple image viewer
    zathura # A highly customizable and functional PDF viewer
    jq
    gnumake
    # A lossless data compressor based on the LZMA algorithm
    # This package is used for casualsnek/waydroid_script
    lzip
  ];

  # auto mount usb drives
  services = {
    udiskie.enable = true;
    # syncthing.enable = true;
  };
}
