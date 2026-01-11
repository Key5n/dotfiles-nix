#!/usr/bin/env python3
import json, subprocess, sys


def main() -> int:
    notification = json.loads(sys.argv[1])
    if notification.get("type") != "agent-turn-complete":
        return 0
    title = f"Codex: {notification.get('last-assistant-message', 'Turn Complete!')}"
    message = " ".join(notification.get("input-messages", []))
    subprocess.check_output(
        [
            "terminal-notifier",
            "-title",
            title,
            "-message",
            message,
            "-group",
            "codex-" + notification.get("thread-id", ""),
            "-activate",
            "com.googlecode.iterm2",
        ]
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
