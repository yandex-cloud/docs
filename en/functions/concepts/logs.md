# Function logs

A function writes logs to {{ cloud-logging-full-name }}, to the [default log group](../../logging/concepts/log-group.md) for the folder where the function is located.

There are two types of logs:
* Automatic: Logs of requests to functions.
* Custom: Logs that custom code writes to the standard output (`stdout`) and standard error output (`stderr`).

Learn more about working with logs in the [{{ cloud-logging-full-name }} documentation](../../logging/).

## Structured logs {#structured-logs}

Apart from text, structured logs in the following JSON format can be written to the `stdout` and `stderr` standard output streams:

* `message/msg`: Entry text.
* `level`: Logging level. Possible logging levels: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`.

All the fields, except `message/msg` and `level`, are automatically logged to `json-payload`.

A log must be single-line. Any entry that contains the `message/msg` field and is up to 64 KB is considered to be a structured log. If the entry size is larger, it's split into multiple records and treated as text.

You can disable structured logs by setting the environment variable `STRUCTURED_LOGGING = false`. In this case, any JSON log is considered to be plain text.

## See also

* [Writing information to the execution log. Function examples.](../operations/function/logs-write.md)
