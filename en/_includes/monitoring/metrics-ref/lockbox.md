The `name` label contains the metric name.

Labels shared by all {{ lockbox-name }} metrics:

| Label | Value |
| --- | --- |
service | Service ID: `lockbox`
secret | [Secret](../../../lockbox/concepts/secret.md) ID |

Service metrics:

| Metric name<br>Type, units | Description |
| --- | --- |
| `key.active_versions_count`<br>`DGAUGE`, count | Number of active secret versions |
| `key.payload_operations_rate`<br>`RATE`, operations per second | Rate of operations with the secret contents. This metric features the `operation` special label containing the secret operation type. It may take the `get_payload` value. |
| `key_payload_operations_rate_created`<br>`DGAUGE`, operations | Number of operations with the secret contents. This metric features the `operation` special label containing the secret operation type. It may take the `get_payload` value. |