#!/usr/bin/env python3
import base64
import json
import platform
import subprocess
import sys


def is_wsl() -> bool:
    return "microsoft" in platform.uname().release.lower()


def is_darwin() -> bool:
    return sys.platform == "darwin"


def notify_terminal_notifier(title: str, message: str, thread_id: str) -> None:
    subprocess.check_output(
        [
            "terminal-notifier",
            "-title",
            title,
            "-message",
            message,
            "-group",
            "codex-" + thread_id,
            "-activate",
            "com.googlecode.iterm2",
        ]
    )


def notify_wsl_powershell(title: str, message: str) -> None:
    title_b64 = base64.b64encode(title.encode("utf-8")).decode("ascii")
    message_b64 = base64.b64encode(message.encode("utf-8")).decode("ascii")
    script = rf"""
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    $title = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('{title_b64}'))
    $message = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('{message_b64}'))
    $n = New-Object System.Windows.Forms.NotifyIcon
    $n.Icon = [System.Drawing.SystemIcons]::Information
    $n.Visible = $true
    $n.ShowBalloonTip(3000, $title, $message, [System.Windows.Forms.ToolTipIcon]::None)
    Start-Sleep -Seconds 4
    $n.Dispose()
    """

    subprocess.check_output(["powershell.exe", "-NoProfile", "-Command", script])


def main() -> int:
    notification = json.loads(sys.argv[1])
    if notification.get("type") != "agent-turn-complete":
        return 0
    title = f"Codex: {notification.get('last-assistant-message', 'Turn Complete!')}"
    message = " ".join(notification.get("input-messages", []))
    thread_id = notification.get("thread-id", "")

    if is_darwin():
        notify_terminal_notifier(title, message, thread_id)
        return 0

    if is_wsl():
        notify_wsl_powershell(title, message)
        return 0

    return 0


if __name__ == "__main__":
    sys.exit(main())
