When viewing the log, you can set a specific interval using the `--since` and `--until` flags. If no interval is specified when invoking a function, information for the last hour is displayed.

The following flags are used:

- `--since`: Time N and later.

- `--until`: Time N and earlier.

If you only specify one flag, information is displayed for the hour before or after N depending on the flag.

Allowed time formats:

- `HH:MM:SS`. Example: `15:04:05`.

- [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt). Example: `2006-01-02T15:04:05Z`, `2h`, `3h30m ago`.

