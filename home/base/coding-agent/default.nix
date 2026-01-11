{ pkgs, config, ... }:
{
  home.packages =
    with pkgs;
    [
      claude-code
      codex
      gemini-cli
    ]
    ++ lib.optional stdenv.isDarwin terminal-notifier;

  # Script used by Codex event notifications (installed to ~/.config/codex/notify.py).
  home.file."${config.xdg.configHome}/codex/notify.py" = {
    source = ./notify.py;
    executable = true;
  };

  # Configure Codex to invoke the notifier script.
  home.file."${config.xdg.configHome}/codex/config.toml".text = ''
    notify = ["python3", "${config.xdg.configHome}/codex/notify.py"]
  '';
}
