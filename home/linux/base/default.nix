{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify
    wireguard-tools # manage wireguard vpn manually, via wg-quick

    # ventoy # create bootable usb
    # virt-viewer # vnc connect to VM, used by kubevirt

    imv # simple image viewer
    jq
  ];

  # auto mount usb drives
  services = {
    udiskie.enable = true;
    # syncthing.enable = true;
  };
}
