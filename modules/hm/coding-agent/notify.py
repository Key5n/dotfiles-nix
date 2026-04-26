#!/usr/bin/env python3
import base64
import json
import platform
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path


CODEX_ICON = Path(__file__).with_name("codex.svg")

NOTIFICATIONS = {
    "PermissionRequest": {
        "title": "Codex needs approval",
        "message": "Review the permission request in your terminal.",
        "group": "permission-request",
    },
    "Stop": {
        "title": "Codex turn complete",
        "message": "The current Codex response has finished.",
        "group": "stop",
    },
}


def is_wsl() -> bool:
    return "microsoft" in platform.uname().release.lower()


def is_darwin() -> bool:
    return sys.platform == "darwin"


def icon_path() -> str | None:
    if CODEX_ICON.is_file():
        return str(CODEX_ICON)
    return None


def notify_terminal_notifier(title: str, message: str, group: str) -> None:
    command = [
        "terminal-notifier",
        "-title",
        title,
        "-message",
        message,
        "-group",
        "codex-" + group,
        "-activate",
        "com.googlecode.iterm2",
    ]
    icon = icon_path()
    if icon:
        command.extend(["-appIcon", icon])

    subprocess.run(
        command,
        check=False,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
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

    subprocess.run(
        ["powershell.exe", "-NoProfile", "-Command", script],
        check=False,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def notify_linux(title: str, message: str, group: str) -> None:
    command = [
        "notify-send",
        "-a",
        "Codex",
        "-h",
        f"string:x-canonical-private-synchronous:codex-{group}",
    ]
    icon = icon_path()
    if icon:
        command.extend(["-i", icon])
    command.extend([title, message])

    subprocess.run(
        command,
        check=False,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def record_request(event: str, notification: dict | None, raw_payload: str) -> None:
    log_path = Path.home() / ".codex" / "notify.log"
    try:
        log_path.parent.mkdir(parents=True, exist_ok=True)
        entry = {
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "event": event,
            "notification": notification,
            "raw": raw_payload,
        }
        with log_path.open("a", encoding="utf-8") as handle:
            handle.write(json.dumps(entry, ensure_ascii=True))
            handle.write("\n")
    except Exception:
        pass


def read_payload() -> str:
    if sys.stdin.isatty():
        return ""
    return sys.stdin.read()


def parse_event(raw_payload: str) -> tuple[str, dict | None]:
    notification = None
    event = sys.argv[1] if len(sys.argv) > 1 else ""

    if event == "PermissionRequst":
        event = "PermissionRequest"

    if raw_payload:
        try:
            notification = json.loads(raw_payload)
        except json.JSONDecodeError:
            notification = None

    if event.startswith("{"):
        try:
            notification = json.loads(event)
        except json.JSONDecodeError:
            notification = None
        event = ""

    if not event and notification and notification.get("type") == "agent-turn-complete":
        event = "Stop"

    return event, notification


def message_with_cwd(message: str, notification: dict | None) -> str:
    if not isinstance(notification, dict):
        return message

    cwd = notification.get("cwd")
    if not isinstance(cwd, str) or not cwd:
        return message

    return f"{message}\nCWD: {cwd}"


def main() -> int:
    raw_payload = read_payload()
    if not raw_payload and len(sys.argv) > 1 and sys.argv[1].startswith("{"):
        raw_payload = sys.argv[1]
    event, notification = parse_event(raw_payload)
    record_request(event, notification, raw_payload)

    config = NOTIFICATIONS.get(event)
    if not config:
        return 0

    title = config["title"]
    message = message_with_cwd(config["message"], notification)
    group = config["group"]

    if is_darwin():
        notify_terminal_notifier(title, message, group)
        return 0

    if is_wsl():
        notify_wsl_powershell(title, message)
        return 0

    notify_linux(title, message, group)
    return 0


if __name__ == "__main__":
    sys.exit(main())
