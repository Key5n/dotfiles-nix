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
      };

      finder = {
        _FXShowPosixPathInTitle = true;  # show full path in finder title
        AppleShowAllExtensions = true;  # show all file extensions
        ShowPathbar = true;  # show path bar
        ShowStatusBar = true;  # show status bar
      };

      trackpad = {
        Clicking = true;  # enable tap to click
        TrackpadRightClick = true;  # enable two finger right click
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;  # remap caps lock to control
    };
  };

  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];
}