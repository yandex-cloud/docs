#!/usr/bin/env python3
"""
Replace the HTTPS base URL prefix in sitemap.xml <loc> entries.

Default old base matches the placeholder used when generating sitemap.xml.

Usage:
  python3 scripts/change-sitemap-base-url.py https://docs.example.com/
  python3 scripts/change-sitemap-base-url.py --from https://old.example/ https://new.example/
  python3 scripts/change-sitemap-base-url.py --dry-run https://docs.example.com/
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


def _prefix(url: str) -> str:
    u = url.strip()
    if not u:
        raise ValueError("empty URL")
    return u.rstrip("/") + "/"


def main() -> int:
    root = Path(__file__).resolve().parent.parent
    parser = argparse.ArgumentParser(
        description="Replace base URL in sitemap.xml (and optionally llms.txt placeholder text)."
    )
    parser.add_argument(
        "new_base",
        help="New origin + optional path prefix, e.g. https://cdn.example.com/docs/",
    )
    parser.add_argument(
        "--from",
        dest="old_base",
        default="https://CHANGE_ME.example/",
        help="Old base prefix to replace (default: placeholder from generated sitemap)",
    )
    parser.add_argument(
        "--sitemap",
        type=Path,
        default=root / "sitemap.xml",
        help="Path to sitemap.xml",
    )
    parser.add_argument(
        "--llms",
        action="store_true",
        help="Also replace the same old prefix inside llms.txt (documentation line)",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print counts only; do not write files",
    )
    args = parser.parse_args()

    old_p = _prefix(args.old_base)
    new_p = _prefix(args.new_base)

    if old_p == new_p:
        print("error: old and new base normalize to the same prefix", file=sys.stderr)
        return 2

    sitemap_path: Path = args.sitemap
    if not sitemap_path.is_file():
        print(f"error: missing sitemap: {sitemap_path}", file=sys.stderr)
        return 1

    text = sitemap_path.read_text(encoding="utf-8")
    count = text.count(old_p)
    if count == 0:
        print(f"error: old prefix not found in sitemap: {old_p!r}", file=sys.stderr)
        return 1

    new_text = text.replace(old_p, new_p)

    if args.dry_run:
        print(f"Would replace {count} occurrences in {sitemap_path}")
        if args.llms:
            llms_path = root / "llms.txt"
            if llms_path.is_file():
                lt = llms_path.read_text(encoding="utf-8")
                c2 = lt.count(old_p)
                print(f"Would replace {c2} occurrences in {llms_path}")
            else:
                print(f"warning: {llms_path} not found (--llms ignored)", file=sys.stderr)
        return 0

    sitemap_path.write_text(new_text, encoding="utf-8")
    print(f"Updated {sitemap_path}: {count} <loc> prefixes ({old_p!r} -> {new_p!r})")

    if args.llms:
        llms_path = root / "llms.txt"
        if not llms_path.is_file():
            print(f"warning: {llms_path} not found", file=sys.stderr)
            return 0
        lt = llms_path.read_text(encoding="utf-8")
        c2 = lt.count(old_p)
        if c2:
            llms_path.write_text(lt.replace(old_p, new_p), encoding="utf-8")
            print(f"Updated {llms_path}: {c2} occurrences")
        else:
            print(f"note: old prefix not found in {llms_path}; skipped")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
