{ pkgs, ... }: {
  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    masApps = {
      # Office apps should be installed manually
      LINE = 539883307;
    };

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
    ];

    # `brew install --cask`
    casks = [
      "firefox"
      "google-chrome"
      "visual-studio-code"
      "discord"
      "raycast"
      "slack"
      "figma"
      "microsoft-edge"
      "affinity-designer"
    ];
  };
}
