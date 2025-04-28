The `name` label contains the metric name.

All {{ iot-short-name }} metrics share the `service=iot-core` label.

## Registry metrics {#registry-metrics}

Labels shared by all registry metrics:

Label | Value
----|----
registry | [Registry](../../../iot-core/concepts/index.md#registry) ID

Name<br>Type, units | Description
----|----
`iot.registry.billing_messages_per_second`<br/>`DGAUGE`, units per second | Number of billable messages per second
`iot.registry.connections`<br/>`DGAUGE`, count | Number of active device connections
`iot.registry.sent_bytes_per_second`<br/>`DGAUGE`, bytes per second | Data transmit rate
`iot.registry.received_bytes_per_second`<br/>`DGAUGE`, bytes per second | Data receive rate

## Broker metrics {#broker-metrics}

Labels shared by all broker metrics:

Label | Value
----|----
broker | [Broker](../../../iot-core/concepts/index.md#broker) ID

Name<br>Type, units | Description
----|----
`iot.broker.billing_messages_per_second`<br/>`DGAUGE`, units per second | Number of billable messages per second
`iot.broker.connections`<br/>`DGAUGE`, count | Number of active device connections
`iot.broker.sent_bytes_per_second`<br/>`DGAUGE`, bytes per second | Data transmit rate
`iot.broker.received_bytes_per_second`<br/>`DGAUGE`, bytes per second | Data receive rate