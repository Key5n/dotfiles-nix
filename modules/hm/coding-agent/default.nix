{
  pkgs-unstable,
  config,
  lib,
  ...
}:
let
  notifyScript = "${config.home.homeDirectory}/.codex/notify.py";
in
{
  home.packages =
    with pkgs-unstable;
    [
      claude-code
      gemini-cli
    ]
    ++ lib.optional stdenv.isDarwin terminal-notifier
    ++ lib.optional (!stdenv.isDarwin) libnotify;

  # Script used by Codex event notifications (installed to ~/.codex/notify.py).
  home.file.".codex/notify.py" = {
    source = ./notify.py;
    executable = true;
  };

  # Remove any existing Codex config, then recreate with hook settings.
  home.activation.installCodexConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    codex_config="${config.home.homeDirectory}/.codex/config.toml"
    if [ -e "$codex_config" ]; then
      rm -f "$codex_config"
    fi
    mkdir -p "${config.home.homeDirectory}/.codex"
    cat > "$codex_config" <<'EOF'
    [features]
    codex_hooks = true

    [[hooks.PermissionRequest]]
    [[hooks.PermissionRequest.hooks]]
    type = "command"
    command = 'python3 "${notifyScript}" PermissionRequest'

    [[hooks.Stop]]
    [[hooks.Stop.hooks]]
    type = "command"
    command = 'python3 "${notifyScript}" Stop'
    EOF
  '';

  home.file.".codex/prompts".source = ./prompts;

  imports = [
    ./skills/pdf
  ];
}
