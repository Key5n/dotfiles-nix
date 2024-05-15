{ pkgs, ...}:
{
  system = {
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