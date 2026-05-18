# Function logs

A function writes logs to {{ cloud-logging-full-name }}, to the [default log group](../../logging/concepts/log-group.md) for the folder where the function is located.

There are two types of logs:
* Automatic: Logs of requests to functions.
* Custom: Logs that custom code writes to the standard output (`stdout`) and standard error output (`stderr`). The minimum logging level of custom logs is `UNSPECIFIED`.

Learn more about working with logs in the [{{ cloud-logging-full-name }} documentation](../../logging/).

{% include [structured-logs](../../_includes/functions/structured-logs.md) %}

Structured logging can be used for [concurrent function instance calls](function.md#concurrency) to log the IDs of all calls processed by the function, not just the most recent one. To do this, specify a unique call ID in the `request_id` field. You can get it from the function call context; the way to do this is [runtime](runtime/index.md)-specific. 

## See also {#see-also}

* [Writing data to the execution log. Function examples.](../operations/function/logs-write.md)
* [Builder. Logging.](./builder.md)
