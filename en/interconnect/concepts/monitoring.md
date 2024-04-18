# {{ interconnect-name }} monitoring

Monitoring allows you to check the status of {{ interconnect-full-name }} resources and see how their are used.

## Monitoring the trunk status {#trunk-mon}

Using monitoring, you can check the trunk status on your own.

For example, to check the status of a physical trunk port:

* Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
* Go to monitoring from the resource folder by selecting `Folder → Monitoring`.
* Select the `Interconnect - Direct Trunk Overview` section.
* In the drop-down list of the `Resource ID` selector, choose the ID of the trunk in question.
* Make sure the `Connection State` metric value is **1**, which means the trunk port is up and running.

## Monitoring the private or public connection status {#private-mon}

Using monitoring, you can check the private or service connection status on your own.

For example, to check the BGP connectivity status for a private or service connection:

* Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
* Go to monitoring from the resource folder by selecting `Folder → Monitoring`.
* Select the `Interconnect → Private/Public Connection Overview` section.
* In the `Resource ID` drop-down list, choose the ID of the private or service connection.
* Make sure the `BGP State` metric value is **1**, which means the BGP connectivity for this private connection is up and running.

## Metric types {#metric-types}

The monitoring service collects the following types of metrics for {{ interconnect-name }}:

* [Trunk metrics](#trunk-metrics)
* [Private or public connection metrics](#private-metrics)

### Trunk metrics {#trunk-metrics}

| Metric name | Units | Data type | Comment |
--- | --- | --- | ---
| `connection_state_up_down` | N/A | bool | Current operational status of the physical port or LAG. |
| `lag_health` | Percent | Uint64 | Ratio of active ports in the LAG to the total number of ports in the LAG. |
| `light_level_to_cloud_current_dbm` | dBm | float | Level of the incoming optical signal on the {{ yandex-cloud }} equipment port. |
| `light_level_to_cloud_min_dbm` | dBm | float | Minimum level of the incoming optical signal on the {{ yandex-cloud }} equipment required for the correct operation of a physical port. |
| `light_level_to_cloud_max_dbm` | dBm | float | Maximum level of the incoming optical signal on the {{ yandex-cloud }} equipment required for the correct operation of a physical port. |
| `light_level_from_cloud_current_dbm` | dBm | float | Level of the outgoing optical signal from the {{ yandex-cloud }} equipment port. |
| `light_level_from_cloud_min_dbm` | dBm | float | Minimum level of the outgoing optical signal from the {{ yandex-cloud }} equipment port. |
| `light_level_from_cloud_max_dbm` | dBm | float | Maximum level of the outgoing optical signal from the {{ yandex-cloud }} equipment port. |
| `bitrate_to_cloud_bps` | Bits per second | Uint64 | Rate of traffic transmission from a client to {{ yandex-cloud }} (including L2 headers). |
| `bitrate_from_cloud_bps` | Bits per second | Uint64 | Rate of traffic transmission from {{ yandex-cloud }} to a client (including L2 headers). |
| `bytes_to_cloud_num` | Bytes | Uint64 | Traffic transmitted from a client to {{ yandex-cloud }} (including L2 headers). |
| `bytes_from_cloud_num` | Bytes | Uint64 | Traffic transmitted from {{ yandex-cloud }} to a client (including L2 headers). |
| `packet_rate_to_cloud_pps` | Packets per second | Uint64 | Rate of packet transmission from a client to {{ yandex-cloud }}. |
| `packet_rate_from_cloud_pps` | Packets per second | Uint64 | Rate of packet transmission from {{ yandex-cloud }} to a client. |
| `packets_to_cloud_num` | Packets | Uint64 | Number of packets transmitted from a client to {{ yandex-cloud }}. |
| `packets_from_cloud_num` | Packets | Uint64 | Number of packets transmitted from {{ yandex-cloud }} to a client. |
| `dropped_packets_to_cloud_num` | Packets | Uint64 | Number of packets transmitted by a client to {{ yandex-cloud }} and discarded due to a buffer overflow. |
| `dropped_packets_from_cloud_num` | Packets | Uint64 | Number of packets transmitted from {{ yandex-cloud }} to a client and discarded due to a buffer overflow. |
| `error_packets_to_cloud_num` | Packets | Uint64 | Number of packets transmitted by a client to {{ yandex-cloud }} and discarded due to an incorrect Ethernet frame checksum value. |
| `error_packets_from_cloud_num` | Packets | Uint64 | Number of packets transmitted from {{ yandex-cloud }} to a client and discarded due to an incorrect Ethernet frame checksum value. |

### Private or public connection metrics {#private-metrics}

| Metric name | Units | Data type | Comment |
--- | --- | --- | ---
| `ipv4_announces_received_by_cloud_num` | Routes | Uint32 | Current number of BGP announcements received by {{ interconnect-name }} equipment from a client. |
| `ipv4_announces_advertised_from_cloud_num` | Routes | Uint32 | Current number of BGP announcements sent by {{ interconnect-name }} equipment to a client. |
| `bgp_ipv4_session_lifetime_seconds` | Seconds | Uint24 | Lifetime of a BGP session within an established connection. |
| `bgp_ipv4_session_state_up_down` | N/A | bool | Current state of a BGP session. |
| `bitrate_to_cloud_bps` | Bits per second | Uint64 | Rate of traffic transmission from a client to {{ yandex-cloud }} (excluding L2 headers). |
| `bitrate_from_cloud_bps` | Bits per second | Uint64 | Rate of traffic transmission from {{ yandex-cloud }} to a client (excluding L2 headers). |
| `bytes_to_cloud_num` | Bytes | Uint64 | Traffic transmitted from a client to {{ yandex-cloud }} (excluding L2 headers). |
| `bytes_from_cloud_num` | Bytes | Uint64 | Traffic transmitted from {{ yandex-cloud }} to a client (excluding L2 headers). |
| `packet_rate_to_cloud_pps` | Packets per second | Uint64 | Rate of packet transmission from a client to {{ yandex-cloud }}. |
| `packet_rate_from_cloud_pps` | Packets per second | Uint64 | Rate of packet transmission from {{ yandex-cloud }} to a client. |
| `packets_to_cloud_num` | Packets | Uint64 | Number of packets transmitted from a client to {{ yandex-cloud }}. |
| `packets_from_cloud_num` | Packets | Uint64 | Number of packets transmitted from {{ yandex-cloud }} to a client. |

### Notes {#notes}

* If the values of the metrics that have `dropped_packets_` and `error_packets_` in their names do not increase, this means there is no packet loss on the {{ interconnect-name }} equipment, but does not guarantee that there is no packet loss along the entire path of user traffic (from the user resources to {{ yandex-cloud }} and to the user infrastructure).
* The values of the metrics with `num` and `seconds` in their names can be reset as a result of intentional or forced actions made by the {{ yandex-cloud }} team or due to exceeding the metric measurement range.
* Trunk metrics are available to the user in case of a direct trunk and unavailable in case of a partner trunk.

## Metric collection point {#collect-point}

Metrics are collected directly from the {{ interconnect-name }} equipment, meaning as close as possible to the client connection point.

## Metric update frequency {#update-frequency}

Metric values for the {{ interconnect-name }} resources are updated every 60 seconds.
