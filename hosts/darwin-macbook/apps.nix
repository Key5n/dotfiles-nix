{ pkgs, ... }: {
  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    # masApps = {
      # TODO Feel free to add your favorite apps here.

      # Xcode = 497799835;
      # Wechat = 836500024;
      # NeteaseCloudMusic = 944848654;
      # QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      # TecentMetting = 1484048379;
      # QQMusic = 595615424;
    # };

    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      # "wget" # download tool
      # "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      # "aria2" # download tool
      # "httpie" # http client
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "firefox"
      "google-chrome"
      "visual-studio-code"
      "discord"
      "raycast"
    ];
  };
}
