When viewing the log, you can set a specific time interval using the `--since` and `--until` parameters. If you do not specify a time interval, the log will show info for the last hour.

Using parameters:

- `--since`: Time N and later.

- `--until`: Time N and earlier.

If you only specify a single parameter, you will see info for one hour before or after time N, depending on the parameter.

You can use one of these time formats:

- `HH:MM:SS`, e.g., `15:04:05`.

- [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), e.g., `2006-01-02T15:04:05Z`, `2h`, or `3h30m ago`.