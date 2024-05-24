The metric name is written in the `name` label.

All {{ unified-agent-short-name }} metrics share the `service=custom` label.

## Native {{ unified-agent-short-name }} metrics {#ua-metrics}

| Metric name<br>Type, unit | Description |
| --- | --- |
| `ua.backlog`<br>`DGAUGE`, number | Number of incoming messages for which no outgoing messages have been sent yet. It includes messages from the storage and all incoming but unsent messages. You can safely delete {{ unified-agent-short-name }}, along with directories on the disk, if this metric equals zero and is not increasing. |
| `ua.bytes_lost`<br>`RATE`, bytes | Amount of data lost in transit. |
| `ua.errors`<br>`RATE`, number | Number of {{ unified-agent-short-name }} events with `ERROR` level. For example, data loss due to a corrupted file on disk or exceeded limits, plugin errors while creating a session, or unavailable external services. |
| `ua.messages_lost`<br>`RATE`, number | Number of messages lost in transit. |
| `ua.metrics_lost`<br>`RATE`, number | Number of metrics lost in transit. |