The name of the metric is written in the `name` label.

Common labels for all {{ lockbox-name }} metrics:

| Label | Value |
| --- | --- |
| service | Service ID: `lockbox` |
| secret | [Secret](../../../lockbox/concepts/secret.md) ID |

Service metrics:

| Metric name<br>Type, units of measurement | Description |
| --- | --- |
| `key.active_versions_count`<br>`DGAUGE`, number | Number of active secret versions |
| `key.payload_operations_rate`<br>`DGAUGE`, operations per second | Rate of operations with the secret contents. Special `operation` label: Secret operation type. It may take the `get_payload` value. |