#!/usr/bin/env python3
# Wofi-based window switcher: pick an open window, focus it.
import json
import subprocess


def collect_windows(node, windows):
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        # The scratchpad (under __i3) is not supported
        if child.get("name") == "__i3":
            continue
        if (
            child.get("type") in ("con", "floating_con")
            and not child.get("nodes")
            and child.get("name")
        ):
            windows.append(child)
        collect_windows(child, windows)


def main():
    tree = json.loads(
        subprocess.run(
            ["swaymsg", "-t", "get_tree"], capture_output=True, check=True
        ).stdout
    )

    windows = []
    collect_windows(tree, windows)
    if not windows:
        return

    # Number the entries so duplicate titles stay distinguishable.
    lines = "\n".join(f"{i + 1}: {w['name']}" for i, w in enumerate(windows))
    selected = (
        subprocess.run(
            ["wofi", "-d", "-i", "-p", "Windows: ", "--hide-scroll"],
            input=lines.encode(),
            capture_output=True,
        )
        .stdout.decode()
        .strip()
    )
    if not selected:
        return

    index = int(selected.split(":", 1)[0]) - 1
    subprocess.run(["swaymsg", f"[con_id={windows[index]['id']}] focus"])


if __name__ == "__main__":
    main()
