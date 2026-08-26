{ pkgs, ... }: {
  home.packages = [ pkgs.git ];

  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-stack ];
  };

  programs.git.settings.rerere.enabled = true;

  home.file.".codex/skills/gh-stack".source = ../gh-stack;
}
