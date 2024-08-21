The metric name is written to the `name` label.

All {{ iot-short-name }} metrics share the `service=iot-core` label.

## Registry metrics {#registry-metrics}

Common labels for all registry metrics:

| Label | Value |
----|----
| registry | [Registry](../../../iot-core/concepts/index.md#registry) ID |

| Name<br>Type, units | Description |
----|----
| `iot.registry.billing_messages_per_second`<br/>`DGAUGE`, number/s | Number of billed messages per second. |
| `iot.registry.connections`<br/>`DGAUGE`, number | Number of active connections with devices. |
| `iot.registry.sent_bytes_per_second`<br/>`DGAUGE`, bytes/s | Data sending speed. |
| `iot.registry.received_bytes_per_second`<br/>`DGAUGE`, bytes/s | Data receiving speed. |

## Broker metrics {#broker-metrics}

Common labels for all broker metrics:

| Label | Value |
----|----
| broker | [Broker](../../../iot-core/concepts/index.md#broker) ID |

| Name<br>Type, units | Description |
----|----
| `iot.broker.billing_messages_per_second`<br/>`DGAUGE`, number/s | Number of billed messages per second. |
| `iot.broker.connections`<br/>`DGAUGE`, number | Number of active connections with devices. |
| `iot.broker.sent_bytes_per_second`<br/>`DGAUGE`, bytes/s | Data sending speed. |
| `iot.broker.received_bytes_per_second`<br/>`DGAUGE`, bytes/s | Data receiving speed. |