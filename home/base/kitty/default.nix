{ ... }: {
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";

    settings = {
      background_opacity = "0.9";
      macos_option_as_alt = true;
    };
  };
}
