{
  pkgs-unstable,
  config,
  lib,
  ...
}:
{
  home.packages =
    with pkgs-unstable;
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

  # Remove any existing Codex config, then recreate with notifier settings.
  home.activation.installCodexConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    codex_config="${config.home.homeDirectory}/.codex/config.toml"
    if [ -e "$codex_config" ]; then
      rm -f "$codex_config"
    fi
    mkdir -p "${config.home.homeDirectory}/.codex"
    cat > "$codex_config" <<'EOF'
    notify = ["python3", "${config.home.homeDirectory}/.codex/notify.py"]
    EOF
  '';

  home.file.".codex/prompts".source = ./prompts;
}
