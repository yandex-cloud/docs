## Structured logs {#structured-logs}

Apart from text, structured logs in the following JSON format can be written to the `stdout` and `stderr` standard output streams:

* `message/msg`: Entry text.
* `level`: Logging level. Possible logging levels: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`.
* `stream_name`: Log stream name. Length: 1 to 63 characters.

All other JSON fields are automatically written to `json-payload`.

A log must be single-line. Any entry that contains the `message/msg` field and is up to 64 KB is considered to be a structured log. If the entry size is larger, it is split into multiple records and treated as text.

You can disable structured logs by setting the `STRUCTURED_LOGGING = false` environment variable. In this case, any JSON log will be considered plain text.