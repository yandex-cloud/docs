# Container logs

A container writes logs to {{ cloud-logging-full-name }}, to the [default log group](../../logging/concepts/log-group.md) for the folder where the container is located.

There are two types of logs:
* Automatic: Logs of requests to containers.
* Custom: Logs that custom code writes to the standard output (`stdout`) and standard error output (`stderr`). The minimum logging level of custom logs is `UNSPECIFIED`.

Learn more about working with logs in the [{{ cloud-logging-full-name }} documentation](../../logging/).

{% include [structured-logs](../../_includes/functions/structured-logs.md) %}

## See also

* [Writing information to the execution log. Application and Dockerfile examples.](../operations/logs-write.md)
