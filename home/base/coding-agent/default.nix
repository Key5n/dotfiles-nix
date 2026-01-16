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
  home.file.".codex/notify.py" = {
    source = ./notify.py;
    executable = true;
  };

  # Configure Codex to invoke the notifier script.
  home.file.".codex/config.toml" = {
    text = ''
      model = "gpt-5.2-codex"
      notify = ["python3", "${config.home.homeDirectory}/.codex/notify.py"]
      model_reasoning_effort = "high"

      [features]
      web_search_request = true
    '';
    force = true;
  };

  home.file.".codex/prompts".source = ./prompts;
}
