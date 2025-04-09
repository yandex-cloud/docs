{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

The `name` label stores the metric name.

Labels shared by {{ baremetal-name }} metrics:

Label | Value
----|----
service | Service ID: `baremetal`
server_id | [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md) ID.
server_subnet_type | Subnet [type](../../../baremetal/concepts/network.md): `private` or `public`. 

Service metrics:

Metric name<br/>Type, unit | Description
--- | ---
`server_cpu0_temperature_celsius`<br/>`DGAUGE`, degrees Celsius | Server CPU temperature (`CPU0`).
`server_cpu1_temperature_celsius`<br/>`DGAUGE`, degrees Celsius | Server CPU temperature (`CPU1`).
`server_fan1_speed_rpm`<br/>`DGAUGE`, thousands rpm | Rotation speed of the server’s first fan.
`server_fan2_speed_rpm`<br/>`DGAUGE`, thousands rpm | Rotation speed of the server’s second fan.
`server_fan3_speed_rpm`<br/>`DGAUGE`, thousands rpm | Rotation speed of the server’s third fan.
`server_fan4_speed_rpm`<br/>`DGAUGE`, thousands rpm | Rotation speed of the server’s fourth fan.
`server_network_status`<br/>`DGAUGE` | Server network interface status: `1` if active.
`server_power_status`<br/>`DGAUGE` | Server power status: `1` if enabled.
`server_received_bits`<br/>`DGAUGE`, bits/s | Number of bits per second received on the network interface.
`server_received_drop_packets`<br/>`DGAUGE`, packets per second | Number of packets per second lost and not received on the network interface.
`server_received_error_packets`<br/>`DGAUGE`, packets per second | Number of packets per second received with errors on the network interface.
`server_received_packets`<br/>`DGAUGE`, packets per second | Number of packets per second received on the network interface.
`server_sent_bits`<br/>`DGAUGE`, bits/s | Number of bits per second sent from the network interface.
`server_sent_drop_packets`<br/>`DGAUGE`, packets per second | Number of packets per second lost when sending from the network interface.
`server_sent_error_packets`<br/>`DGAUGE`, packets per second | Number of packets per second sent with errors from the network interface.
`server_sent_packets`<br/>`DGAUGE`, packets per second | Number of packets per second sent from the network interface.