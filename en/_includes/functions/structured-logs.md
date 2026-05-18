## Structured logs {#structured-logs}

Apart from text, you can write structured logs in the following JSON format to the standard output (`stdout`) and standard error output (`stderr`):

* `message/msg`: Entry text.
* `level`: Logging level. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`.
* `stream_name`: Log stream name. It must be from 1 to 63 characters long.

All other JSON fields are automatically written to `json-payload`.

A log must be single-line. Any entry that contains the `message/msg` field and is up to 64 KB is considered a structured log. If a log entry is too large, it is split into multiple entries and treated as text.

You can disable structured logs by setting `STRUCTURED_LOGGING = false`. In this case, any JSON log will be considered plain text.
