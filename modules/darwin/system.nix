{ pkgs, userName, ...}:
{
  system = {

    # activationScripts.postUserActivation.text = ''
    #   # activateSettings -u will reload the settings from the database and apply them to the current session,
    #   # so we do not need to logout and login again to make the changes take effect.
    #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    # '';

    primaryUser = userName;

    defaults = {
      dock = {
        autohide = true;
        show-recents = false;  # disable recent apps

        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/Firefox.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Discord.app"
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
        "com.aple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
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
