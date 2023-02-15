# {{ interconnect-name }} monitoring

The monitoring service allows you to check the status and usage of {{ interconnect-full-name }} resources.

## Monitoring the trunk status {#trunk-mon}

Customers can check the status of a trunk themselves using the monitoring service.

For example, to check the status of a trunk physical port:

* Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
* Go to the monitoring service from the resource folder by selecting `Folder → Monitoring`.
* Select the `Interconnect - Direct Trunk Connection Overview` section.
* In the drop-down list of the `Resource ID` selector, choose the ID of the trunk in question.
* Make sure the `Connection State` metric value is **1**, which means the trunk port is up and running.

## Monitoring the status of a private or public connection {#private-mon}

Customers can check the status of a private or public connection themselves using the monitoring service.

For example, to check the status of BGP connectivity for a private or public connection:

* Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
* Go to the monitoring service from the resource folder by selecting `Folder → Monitoring`.
* Select the `Interconnect → Private/Public Connection Overview` section.
* In the drop-down list of the `Resource ID` selector, choose the ID of the private or public connection in question.
* Make sure the `BGP State` metric value is **1**, which means the BGP connectivity for this private connection is up and running.

## Metric types {#metric-types}

The monitoring service collects the following types of metrics for {{ interconnect-name }}:

* [Trunk connection metrics](#trunk-metrics).
* [Private or public connection metrics](#private-metrics).

### Trunk connection metrics {#trunk-metrics}

| Metric name | Units | Data type | Explanations |
--- | --- | --- | ---
| `connection_state` | N/A | bool | Current operational status of the physical port or LAG. |
| `lag_health` | Percent | Uint64 | Ratio of active ports in the LAG to the total number of ports in the LAG. |
| `light_level_to_cloud_current_dbm` | dBm | float | Strength of the incoming optical signal on the {{ yandex-cloud }} equipment port. |
| `light_level_to_cloud_min_dbm` | dBm | float | Minimum strength of the incoming optical signal on the {{ yandex-cloud }} equipment required for the correct operation of a physical port. |
| `light_level_to_cloud_max_dbm` | dBm | float | Maximum strength of the incoming optical signal on the {{ yandex-cloud }} equipment required for the correct operation of a physical port. |
| `light_level_from_cloud_current_dbm` | dBm | float | Strength of the outgoing optical signal from the {{ yandex-cloud }} equipment port. |
| `light_level_from_cloud_min_dbm` | dBm | float | Minimum strength of the outgoing optical signal from the {{ yandex-cloud }} equipment port. |
| `light_level_from_cloud_max_dbm` | dBm | float | Maximum strength of the outgoing optical signal from the {{ yandex-cloud }} equipment port. |
| `bitrate_to_cloud_bps` | Bits per second | Uint64 | The rate of traffic transmission from a client to {{ yandex-cloud }} (including L2 headers). |
| `bitrate_from_cloud_bps` | Bits per second | Uint64 | The rate of traffic transmission from {{ yandex-cloud }} to a client (including L2 headers). |
| `bytes_to_cloud_num` | Bytes | Uint64 | Traffic transmitted from a client to {{ yandex-cloud }} (including L2 headers). |
| `bytes_from_cloud_num` | Bytes | Uint64 | Traffic transmitted from {{ yandex-cloud }} to a client (including L2 headers). |
| `packet_rate_to_cloud_pps` | Packets per second | Uint64 | The rate of packet transmission from a client to {{ yandex-cloud }}. |
| `packet_rate_from_cloud_pps` | Packets per second | Uint64 | The rate of packet transmission from {{ yandex-cloud }} to a client. |
| `packets_to_cloud_num` | Packets | Uint64 | The number of packets transmitted from a client to {{ yandex-cloud }}. |
| `packets_from_cloud_num` | Packets | Uint64 | The number of packets transmitted from {{ yandex-cloud }} to a client. |
| `dropped_packets_to_cloud_num` | Packets | Uint64 | The number of packets transmitted by a client to {{ yandex-cloud }}, but discarded due to a buffer overflow. |
| `dropped_packets_from_cloud_num` | Packets | Uint64 | The number of packets transmitted from {{ yandex-cloud }} to a client, but discarded due to a buffer overflow. |
| `error_packets_to_cloud_num` | Packets | Uint64 | The number of packets transmitted by a client to {{ yandex-cloud }}, but discarded due to an incorrect Ethernet frame checksum value. |
| `error_packets_from_cloud_num` | Packets | Uint64 | The number of packets transmitted from {{ yandex-cloud }} to a client, but discarded due to an incorrect Ethernet frame checksum value. |

### Private or public connection metrics {#private-metrics}

| Metric name | Units | Data type | Explanations |
--- | --- | --- | ---
| `ipv4_announces_received_by_cloud_num` | Routes | Uint32 | The current number of BGP announcements received by {{ interconnect-name }} equipment from a client. |
| `ipv4_announces_advertised_from_cloud_num` | Routes | Uint32 | The current number of BGP announcements sent by {{ interconnect-name }} equipment to a client. |
| `bgp_ipv4_session_lifetime_seconds` | Seconds | Uint24 | The lifetime of a BGP session within an established connection. |
| `bgp_ipv4_session_state_up_down` | N/A | bool | The current state of a BGP session. |
| `bitrate_to_cloud_bps` | Bits per second | Uint64 | The rate of traffic transmission from a client to {{ yandex-cloud }} (excluding L2 headers). |
| `bitrate_from_cloud_bps` | Bits per second | Uint64 | The rate of traffic transmission from {{ yandex-cloud }} to a client (excluding L2 headers). |
| `bytes_to_cloud_num` | Bytes | Uint64 | Traffic transmitted from a client to {{ yandex-cloud }} (excluding L2 headers). |
| `bytes_from_cloud_num` | Bytes | Uint64 | Traffic transmitted from {{ yandex-cloud }} to a client (excluding L2 headers). |
| `packet_rate_to_cloud_pps` | Packets per second | Uint64 | The rate of packet transmission from a client to {{ yandex-cloud }}. |
| `packet_rate_from_cloud_pps` | Packets per second | Uint64 | The rate of packet transmission from {{ yandex-cloud }} to a client. |
| `packets_to_cloud_num` | Packets | Uint64 | The number of packets transmitted from a client to {{ yandex-cloud }}. |
| `packets_from_cloud_num` | Packets | Uint64 | The number of packets transmitted from {{ yandex-cloud }} to a client. |

### Notes {#notes}

* If the values of the metrics that have `dropped_packets_` and `error_packets_` in their names do not increase, this indicates that there is no packet loss on the {{ interconnect-name }} equipment, but does not guarantee that there is no packet loss along the entire path of user traffic (from the user's resources to {{ yandex-cloud }} and to the user infrastructure).
* The values of the metrics with `num` and `seconds` in their names can be reset as a result of intentional or forced actions made by the {{ yandex-cloud }} team or due to exceeding the metric measurement range.
* Trunk connection metrics are available to the user in the case of a direct trunk connection and unavailable in the case of a partner trunk connection.

## Metric collection point {#collect-point}

Metrics are collected directly from the {{ interconnect-name }} equipment, meaning as close as possible to the client connection point.

## Metric update frequency {#update-frequency}

Metric values for the {{ interconnect-name }} service resources are updated every 60 seconds.
