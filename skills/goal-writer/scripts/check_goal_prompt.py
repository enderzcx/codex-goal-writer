#!/usr/bin/env python3
"""Validate a saved /goal prompt for the six required elements."""

from __future__ import annotations

import re
import sys
from pathlib import Path


REQUIRED = {
    "outcome": re.compile(r"/goal\s+\S+", re.I),
    "verification": re.compile(r"^Verification:", re.I | re.M),
    "constraints": re.compile(r"^Constraints:", re.I | re.M),
    "boundaries": re.compile(r"^Boundaries:", re.I | re.M),
    "allowed writes": re.compile(r"Allowed writes:", re.I),
    "do not edit": re.compile(r"Do not edit:", re.I),
    "iteration policy": re.compile(r"^Iteration policy:", re.I | re.M),
    "stop": re.compile(r"^Stop when:", re.I | re.M),
    "pause": re.compile(r"^Pause if:", re.I | re.M),
}

PLACEHOLDERS = re.compile(r"<[^>\n]+>|\bTBD\b|\bTODO\b", re.I)


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print("usage: check_goal_prompt.py path/to/goal.md")
        return 2

    path = Path(argv[1]).expanduser()
    if not path.exists():
        print(f"ERROR: file does not exist: {path}")
        return 1

    text = path.read_text(encoding="utf-8")
    missing = [name for name, pattern in REQUIRED.items() if not pattern.search(text)]
    if missing:
        print("ERROR: missing goal elements: " + ", ".join(missing))
        return 1

    if PLACEHOLDERS.search(text):
        print("ERROR: placeholder text remains")
        return 1

    print(f"OK: {path} contains required goal elements")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
