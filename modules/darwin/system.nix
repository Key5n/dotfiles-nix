{ pkgs, ...}:
{
  system = {

    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      dock = {
        autohide = true;
        show-recents = false;  # disable recent apps

        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/Firefox.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Discord.app"
          "/nix/store/ir312b2bm44rj5zz98hhkhi6b6aiqwp9-alacritty-0.12.3/Applications/Alacritty.app"
        ];
      };

      finder = {
        _FXShowPosixPathInTitle = true;  # show full path in finder title
        AppleShowAllExtensions = true;  # show all file extensions
        ShowStatusBar = true;  # show status bar
        ShowPathbar = true; # Show path breadcrumbs in finder windows
      };

      trackpad = {
        Clicking = true;  # enable tap to click
        TrackpadRightClick = true;  # enable two finger right click
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.microsoft.VSCode" = {
          ApplePressAndHoldEnabled = false;
        };
      };
    };

    # disable since I cannot remap capslock key to command key
    # keyboard = {
    #   enableKeyMapping = true;
    #   remapCapsLockToControl = true;  # remap caps lock to control
    # };
  };

  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];
}