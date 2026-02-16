# {{ interconnect-name }} monitoring
 
Monitoring allows you to check the status and usage of {{ interconnect-full-name }} resources.

## Monitoring the trunk status {#trunk-mon}

Using monitoring, you can check the trunk status on your own.

For example, to check the status of a physical trunk port:

* Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
* Go to monitoring from the resource folder by selecting `Folder → Monitoring`.
* Navigate to `Interconnect - Direct Trunk Connection Overview`.
* In the drop-down list of the `Resource ID` selector, choose the ID of the trunk in question.
* Make sure the `Connection State` metric value is **1**, which means the trunk port is up and running.

## Monitoring the private or public connection status {#private-mon}

Using monitoring, you can check the private or service connection status on your own.

For example, to check the BGP state for a private or service connection:

* Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
* Go to monitoring from the resource folder by selecting `Folder → Monitoring`.
* Navigate to `Interconnect → Private/Public Connection Overview`.
* In the `Resource ID` drop-down list, choose the ID of the private or service connection.
* Make sure the `BGP State` metric value is **1**, which means the BGP session for this private connection is up and running.

## Metric types {#metric-types}

Monitoring in {{ interconnect-name }} offers the following metric types:

* [Trunk metrics](#trunk-metrics)
* [Private or public connection metrics](#private-metrics)

### Trunk metrics {#trunk-metrics}

Metric name | Units | Dimension | Comment
--- | --- | --- | ---
`connection_state_up_down` | N/A | bool | Current operational status of the physical port or LAG.
`lag_health` | Percent | Uint64 | Ratio of active ports to total ports in the LAG.
`light_level_to_cloud_current_dbm` | dBm | float | Level of the incoming optical signal on the {{ yandex-cloud }} equipment port.
`light_level_to_cloud_min_dbm` | dBm | float | Minimum optical signal level needed for a physical port to work correctly on the {{ yandex-cloud }} equipment.
`light_level_to_cloud_max_dbm` | dBm | float | Maximum optical signal level needed for a physical port to work correctly on the {{ yandex-cloud }} equipment.
`light_level_from_cloud_current_dbm` | dBm | float | Level of the outgoing optical signal from the {{ yandex-cloud }} equipment port.
`light_level_from_cloud_min_dbm` | dBm | float | Minimum level of the outgoing optical signal from the {{ yandex-cloud }} equipment port.
`light_level_from_cloud_max_dbm` | dBm | float | Maximum level of the outgoing optical signal from the {{ yandex-cloud }} equipment port.
`bitrate_to_cloud_bps` | Bits per second | Uint64 | Rate of traffic transmission from a customer to {{ yandex-cloud }} (including L2 headers).
`bitrate_from_cloud_bps` | Bits per second | Uint64 | Rate of traffic transmission from {{ yandex-cloud }} to a customer (including L2 headers).
`bytes_to_cloud_num` | Bytes | Uint64 | Traffic transmitted from a customer to {{ yandex-cloud }} (including L2 headers).
`bytes_from_cloud_num` | Bytes | Uint64 | Traffic transmitted from {{ yandex-cloud }} to a customer (including L2 headers).
`packet_rate_to_cloud_pps` | Packets per second | Uint64 | Rate of packet transmission from a customer to {{ yandex-cloud }}.
`packet_rate_from_cloud_pps` | Packets per second | Uint64 | Rate of packet transmission from {{ yandex-cloud }} to a customer.
`packets_to_cloud_num` | Packets | Uint64 | Number of packets transmitted from a customer to {{ yandex-cloud }}.
`packets_from_cloud_num` | Packets | Uint64 | Number of packets transmitted from {{ yandex-cloud }} to a customer.
`dropped_packets_to_cloud_num` | Packets | Uint64 | Number of packets transmitted by a customer to {{ yandex-cloud }} and dropped due to a buffer overflow.
`dropped_packets_from_cloud_num` | Packets | Uint64 | Number of packets transmitted from {{ yandex-cloud }} to a customer and dropped due to a buffer overflow.
`error_packets_to_cloud_num` | Packets | Uint64 | Number of packets transmitted by a customer to {{ yandex-cloud }} and dropped due to an incorrect Ethernet frame checksum value.
`error_packets_from_cloud_num` | Packets | Uint64 | Number of packets transmitted from {{ yandex-cloud }} to a customer and dropped due to an incorrect Ethernet frame checksum value.

### Private or public connection metrics {#private-metrics}

Metric name | Units | Dimension | Comment
--- | --- | --- | ---
`ipv4_announces_received_by_cloud_num` | Routes | Uint32 | Current number of BGP announcements received by {{ interconnect-name }} equipment from a customer.
`ipv4_announces_advertised_from_cloud_num` | Routes | Uint32 | Current number of BGP announcements sent by {{ interconnect-name }} equipment to a customer.
`bgp_ipv4_session_lifetime_seconds` | Seconds | Uint24 | BGP session uptime.
`bgp_ipv4_session_state_up_down` | N/A | bool | Current state of a BGP session.
`bitrate_to_cloud_bps` | Bits per second | Uint64 | Rate of traffic transmission from a customer to {{ yandex-cloud }} (excluding L2 headers).
`bitrate_from_cloud_bps` | Bits per second | Uint64 | Rate of traffic transmission from {{ yandex-cloud }} to a customer (excluding L2 headers).
`bytes_to_cloud_num` | Bytes | Uint64 | Traffic transmitted from a customer to {{ yandex-cloud }} (excluding L2 headers).
`bytes_from_cloud_num` | Bytes | Uint64 | Traffic transmitted from {{ yandex-cloud }} to a customer (excluding L2 headers).
`packet_rate_to_cloud_pps` | Packets per second | Uint64 | Rate of packet transmission from a customer to {{ yandex-cloud }}.
`packet_rate_from_cloud_pps` | Packets per second | Uint64 | Rate of packet transmission from {{ yandex-cloud }} to a customer.
`packets_to_cloud_num` | Packets | Uint64 | Number of packets transmitted from a customer to {{ yandex-cloud }}.
`packets_from_cloud_num` | Packets | Uint64 | Number of packets transmitted from {{ yandex-cloud }} to a customer.

### Notes {#notes}

* If the values of the metrics that have `dropped_packets_` and `error_packets_` in their names do not increase, this means there is no packet loss on the {{ interconnect-name }} equipment, but does not guarantee that there is no packet loss along the entire path of user traffic (from the user resources to {{ yandex-cloud }} and to the user infrastructure).
* Metrics with `num` and `seconds` in their names can be reset by {{ yandex-cloud }} team (on purpose or when necessary) or if the measurement falls outside its range.
* Trunk metrics are only available for direct trunks, not partner ones.

## Metric collection point {#collect-point}

Metrics are collected directly from the {{ interconnect-name }} equipment, i.e., as close as possible to the customer connection point.

## Metric update frequency {#update-frequency}

Metric values for the {{ interconnect-name }} resources are updated every 60 seconds.
