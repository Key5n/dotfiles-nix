{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  # https://yazi-rs.github.io/docs/installation
  home.packages = with pkgs; [
    file # for file type detection
    imagemagick # for SVG, Font, HEIC, and JPEG XL preview
    ffmpegthumbnailer # for video thumbnails
    poppler # for PDF preview
    fzf # for quick file subtree navigation
    fd # for file searching
    jq # for JSON preview
    ripgrep # for file content searching
    zoxide # for histrical directories navigation
  ];
}
