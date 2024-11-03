{ pkgs, ... }: {
  networking.hostName = "nixos-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  # a bluetooth manager
  services.blueman.enable = true;

  # network manager with strongswan doesn't work properly
  networking.networkmanager.enableStrongSwan = true;

  environment.systemPackages = [
    pkgs.strongswan
  ];

  services = {
    strongswan-swanctl = {
      enable = true;
      # works without this config but add it just in case
      strongswan.extraConfig = ''
        charon {
          install_routes = yes
          install_virtual_ip = yes
        }
      '';

      swanctl = {
        connections = {
          university-vpn = {
            version = 2;
            remote_addrs = [
              "gw.mains.nitech.ac.jp"
            ];
            encap = true;
            vips = [ "0.0.0.0" "::" ];

            local."1" = {
              auth = "eap-mschapv2";
              eap_id = "cmt14098";
            };

            remote."2" = {
              auth = "pubkey";
              id = "%any";
              cacerts = [ "/etc/ssl/certs/SCRoot2caPem.pem" ];
            };

            children = {
              net = {
                remote_ts = [ "0.0.0.0/0" "::/0" ];
              };
            };
          };
        };
        secrets.eap."3" = {
          secret = "you-university-password";
        };
      };
    };
  };

  # strongswan vpn only works with systemd-resolved
  services.resolved.enable = true;

  # strongswan doens't work properly with resolvconf
  # networking.resolvconf.enable = true;
}
