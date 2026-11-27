---
alternate:
  - href: en/monium/logs/concepts/ttl.md
    type: text/markdown
    title: Markdown version
---
# Log retention period (TTL)

The log retention period (TTL) in {{ monium-name }} is 31 days.

The retention period is calculated starting from the `time_unix_nano` event; after the `TTL` expires, the log lines are permanently deleted.
