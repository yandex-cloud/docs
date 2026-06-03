---
title: '{{ mgp-name }} cluster and host state monitoring'
description: Follow this guide to get detailed information about a {{ mgp-name }} cluster's state and run diagnostics.
---

# {{ mgp-name }} cluster and host state monitoring

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Charts are updated every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring principles

To streamline troubleshooting, the management console provides dashboards for visual diagnostics, built upon the following principles:

* **Hierarchy**: Diagnostics follow a top-down approach. You start with aggregate cluster health signals and, if issues are observed, you can drill down into individual components (e.g., a cluster, pooler, or hybrid storage) or consumed resources.
* **Efficiency**: Instead of dozens of charts, you are only exposed to key indicators with a focus on **signals**, i.e., metrics with clear thresholds that help instantly spot an issue.
* **Autonomy**: Documents and dashboards are designed to help you independently identify the root-cause of degradation without requesting assistance from support.
* **Continuous iteration**: Diagnostic tools are developed step-by-step based on actual user experience. We continuously analyze requests for improvements to deliver more accurate and streamlined diagnostics.

## Signaling system

The top of the dashboard displays composite signals that aggregate the state of multiple metrics. They use a traffic-light color-coding system:

| Stage | Value | Description |
| :--- | :--- | :--- |
| 🟢&nbsp;**OK** | `2` | All critical indicators are healthy. The cluster and its components are operating normally. |
| 🟠&nbsp;**Warn** | `1` | Minor deviations are detected. The cluster is functional but requires attention to prevent performance degradation (e.g., connection queue growth or increased latency). |
| 🔴&nbsp;**Crit** | `0` | Critical degradation. The cluster is unstable, components are unavailable, or resources are exhausted. Immediate remediation is required. |
| ⚪&nbsp;**Unknown** | `-1` | Data is missing or the status is undefined. |

## Cluster dashboard {#monitoring-cluster}

The primary diagnostic tool is the **Cluster** dashboard, which serves as a single pane of glass for cluster state management.

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of your cluster and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** tab.
      
        This opens a page displaying a dashboard with your {{ mgp-name }} cluster charts and signals.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The dashboard consists of the following sections:

    * **Composite signals (top level)**:
        * **Cluster**: General cluster status.
        * **Pooler**: Connection pooler status.
        * **Connections**: Connection status.
        * **Resources**: Status of host resources.
        * **Queries**: Read/write test query status.

    * **Cluster**:
        * **Read availability**: Cluster read availability over the last five minutes.
        * **Write availability**: Cluster write availability over the last five minutes.
        * **Master switch history**: Master failover history (current master FQDN).
        * **XID utilization**: [Transaction counter]({{ gp.docs.broadcom }}/6/greenplum-database/admin_guide-intro-about_mvcc.html#transaction-id-wraparound) utilization percentage.
        * **Segments down**: Number of segments currently in the `down` state.
        * **Segments not in preferred role**: Number of segments that are not in their preferred role.
        * **Segments not synchronised**: Number of unsynchronized segments.
        * **Log events**: Number of `WARNING`, `ERROR`, and `FATAL` events in logs.

    * **Pooler**:
        * **Availability**: Pooler availability over the last five minutes.
        * **CPU usage**: CPU utilization by the pooler process.
        * **Memory usage**: Memory utilization by the pooler process.
        * **Network usage**: Amount of sent and received data.
        * **Server connections**: Active and available server connections.
        * **Client connections**: Active client connections.
        * **Query timings**: Distribution of query durations by percentiles.

    * **Connections**:
        * **Total master connections utilization**: Total utilization of master connections.
        * **Idle in transaction master connections utilization**: Utilization of connections that are idle in transaction.
        * **Master connections**: Detailed master node connection breakdown by state: `active`, `idle`, `idle in transaction`, `waiting`, `aborted`, `total` (total number for all states), and `max` (limit).
        * **Total segments connections utilization**: Connection utilization by segments.

    * **Resources**:
        * This section is split into the **Master hosts** and **Segment hosts** subgroups.
        * **Load Average**: Average load over 15 minutes.
        * **CPU utilization**: CPU utilization.
        * **Virtual memory consumption**: Total virtual memory used.
        * **Physical memory consumption**: Total physical memory used.
        * **Network packets**: Network packets sent and received per second.
        * **Network packets in queues**: Number of packets in network interface queues.
        * **Network traffic**: Amount of outgoing and incoming traffic.
        * **Disk space utilization**: Percentage of used disk space.
        * **Disk IO**: Disk read and write throughput in bytes per second.
        * **Interconnect retransmits ratio** (segments only): Ratio of resent Interconnect packets to total sent packets.

    * **Queries**:
        * **Read test query duration**: Test read query duration.
        * **Write test query duration**: Test write query duration.
        * **Read duration from each segment**: Test read query duration by segments.
        * **Queries sent to the cluster**: Number of new and failed queries.
        * **Queries execution time distribution**: Histogram of historical query durations.
        * **Running queries execution time distribution**: Distribution histogram of active query durations.
        * **Spill files count**: Total and per-host count of temporary files.
        * **Spill files size**: Total and per-host size of temporary files.

    * **Resource groups**:
        * Charts in this section display information by process groups:
            * **admin_group**: Administrative group.
            * **default_group**: Default group.
        * **Connections utilization by resource group**: Connection utilization.
        * **CPU usage by resource group**: CPU utilization.
        * **Memory utilization by resource group**: Memory utilization percentage.
        * **Memory usage by resource group**: Absolute value of used and available memory.
        * **Running transactions by resource group**: Number of running transactions.
        * **Executed transactions by resource group**: Transaction frequency.
        * **Queueing transactions by resource group**: Number of transactions in the queue.

    * **Background activities**:
        * **Vacuum: catalog**:
            * **Catalog size**: System catalog size per database.
            * **Catalog percent of dead tuples**: Percentage of dead tuples within the catalog per database.
        * **Vacuum: pg_attribute**:
            * **pg_attribute size**: Size of the `pg_attribute` table per database.
            * **pg_attribute percent of dead tuples**: Percentage of dead tuples in the `pg_attribute` table per database.
        * **Vacuum/analyze: user tables**:
            * **Tables vacuum age**: Distribution of tables by number of days since the last [vacuuming](../concepts/maintenance.md#custom-table-vacuum) (`VACUUM`).
            * **Tables analyze age**: Distribution of tables by number of days since the last [statistics collection](../concepts/maintenance.md#get-statistics) (`ANALYZE`).
    * **Hybrid storage**:
        * **CPU usage per host**: CPU utilization by `yproxy` per cluster host.
        * **Memory usage per host**: Memory utilization by `yproxy` per cluster host.
        * **Storage requests**: Number of storage requests (total, successful, and failed).
        * **Storage objects count**: Total number of objects in storage.
        * **Storage objects size**: Total size of objects in storage.

{% endlist %}

## Host state monitoring {#monitoring-hosts}

To view detailed information on the state of individual {{ mgp-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
    1. Select the host you need.

        The page that opens will display state charts for the cluster host.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:
    
    * **Disk usage**: Amount of occupied disk space, in bytes.
    * **Load Average**: Average load on CPU cores over one minute, five minutes, and 15 minutes.
    * **CPU**: Processor core workload. As the workload goes up, the `Idle` value goes down.
    * **Virtual memory usage**: Amount of VRAM used, in bytes.
    * **Disk Await**: Average time per disk operation.
    * **Memory usage**: Use of RAM, in bytes. At high workloads, the `Free` value goes down, while the other values go up.
    * **Disk IOPS**: Number of disk operations per second.
    * **Network Bytes**: Network data exchange rate.
    * **Disk IOPS in progress**: Number of pending disk operations.
    * **Network Packets**: Network packet rate.
    * **Disk Metrics Details**:
      * **Disk used quota**: Disk operation quota usage.
      * **Disk write throttler latency (percentiles)**: Write delay introduced by exceeding disk quota, in percentiles.
      * **Disk read throttler latency (percentiles)**: Read delay introduced by exceeding disk quota, in percentiles.
      * **Disk read latency (percentiles)**: Disk read time, in percentiles.
      * **Disk write latency (percentiles)**: Disk write time, in percentiles.
      * **Disk read operations**: Average and maximum number of read operations per second.
      * **Disk write operations**: Average and maximum number of write operations per second.
      * **Disk read bytes**: Average and maximum disk read rate.
      * **Disk write bytes**: Average and maximum disk write rate.

{% endlist %}

## Network state monitoring {#monitoring-network}

To view detailed information about the network state of each host in a {{ mgp-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.mdb.cluster.switch_network }}** tab.

        The page that opens will display network state charts for each cluster host.

        {% note info %}
        
        You can select a host to see the network state charts for that host alone.

        {% endnote %}

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:

    * **Interfaces**:
        * **Client Interface Packets**: Number of received and sent packets on the client network interface.
        * **Service Interface Packets**: Number of received and sent packets on the service network interface.
        * **Client Interface Packets**: Total amount of received and sent data on the client network interface, in bytes.
        * **Service Interface Packets**: Total amount of received and sent data on the service network interface, in bytes.
        * **Client Interface Drops and Errors**: Number of errors and drops on the client network interface when sending or transmitting packets.
        * **Service Interface Drops and Errors**: Number of errors and drops on the service network interface when sending or transmitting packets.

    * **CPU**:
        * **CPU Usage**: Usage of processor cores (percentage).

    * **Ping and SSH response time**:
        * **Host Ping Average Response**: Average ping response time, in milliseconds.
        * **Host SSH Response Time**: Response time when connecting over SSH, in milliseconds.
        * **Host Ping Packet Loss**: Lost ping packets (percentage).
        
    * **TCP counters**:
        * **TcpActiveConnection**: Number of active TCP connections in the `ESTABLISHED` or `CLOSE-WAIT` state.
        * **TcpEstabPresets**: Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `ESTABLISHED` or `CLOSE-WAIT` state.
        * **TCP Errors**: Number of errors when transmitting TCP packets.
        * **TCP Retransmission**: Number of retransmitted TCP packets.

    * **ICMP Counters**:
        * **IcmpErrors**: Number of ICMP error messages.
        * **IcmpDestUnreached**: Number of ICMP and ICMPv6 Destination Unreachable messages.
        * **Icmp6PacketsTooBig**: Number of ICMPv6 Packet Too Big messages.

    * **UDP counters**:
        * **UdpSndbufErrors**: Number of buffer errors when sending UDP packets.
        * **UdpRcvbufErrors**: Number of buffer errors when receiving UDP packets.
        * **UDP Datagrams**: Number of UDP packets.
        * **UDP NoPorts**: Number of UDP packets received without a listener on the destination port.

    * **IP**:
        * **IpMulticastPackets**: Number of received and sent multicast packets.
        * **IpBroadcastPackets**: Number of received and sent broadcast packets.
        * **Ip6 Neighbor Discovery**: Number of sent requests and router advertisements.
        * **Ip6NoRoutes**: Number of IPv6 packets discarded because no route could be found.

{% endlist %}

## PXF monitoring {#monitoring-pxf}

To view detailed information about the [PXF](external-tables.md) state:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.greenplum.cluster.pxf.value_pxf }}** tab.

        The page that opens will display PXF state charts.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:

    * **Liveness**: PXF state on hosts.
    * **JVM memory**: JVM PXF memory usage, in GB.
    * **JVM threads**: Number of JVM PXF threads.
    * **Connections**: Number of connections.
    * **PXF threads**: Number of PXF threads.
    * **PXF Busy threads**: Number of busy PXF threads.
    * **Log messages**: Number of messages of the `warn`, `trace`, `info`, `fatal`, `error`, and `debug` types.
    * **Sent data**: Amount of sent data.
    * **Received data**: Amount of received data.
    * **File handles**: Number of files opened during the PXF process.
    * **Sent records**: Number of records sent by PXF.
    * **Received records**: Number of records received by PXF.

{% endlist %}


## Monitoring dashboard {#monitoring-dashboard}

To view a dashboard for a {{ mgp-name }} cluster, do the following:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **Dashboard** tab.

        The page that opens will display the cluster dashboard charts.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:

    * **Running queries**:
        * **Test write query**: Execution time of a test write query with the `DISTRIBUTED REPLICATED` policy.
        * **Test read query**: Execution time of a test read query from a random segment.
        * **Overall cluster's query execution time**: Cluster query execution time histogram.

    * **Cluster liveliness**:
        * **Cluster sessions**: Number of sessions in these states:
            * **active**: Processing a query.
            * **waiting**: Awaiting a command.
            * **idle in transaction**: Transaction started but no query is being executed (e.g., pending `COMMIT`).
        * **Number of live segments**: Number of running segment instances, including mirrors.
        * **Queries sent to the cluster**: Number of accepted and interrupted (canceled) queries.

    * **Segments health**:
        * **Idle CPU**: Unused CPU capacity by segment host; the lower the value, the higher the host load.
        * **Reserved memory**: RAM usage (in bytes) by segment host. To avoid errors, remember to keep the value within the limit.
        * **IOPS**: Total size of disk operations (in bytes) across all segment hosts.
        * **Number of network packets**: Number of received and sent packets on network interfaces by segment host. Values close to the limit may cause delays in processing queries.
        * **Number of network packets in queues**: Number of packets in queues on network interfaces by segment host. Values close to the limit may cause delays in processing queries.
        * **Network traffic**: Bandwidth utilization for incoming network traffic by segment host. Values close to the limit may cause delays in processing queries.
        * **Ping time**: Ping time from the master host to the cluster's segment hosts.
        * **Query execution time per segment**: Total time spent on query slices on each of the cluster's segment hosts.

    * **Database internal metrics**:
        * **Free memory for resource groups**: Available RAM by [resource group](../concepts/resource-groups.md).
        * **Summary CPU usage for resource groups**: Total CPU usage by the cluster's resource groups. This value is collected from all cluster hosts and may exceed 100%.
        * **CPU throttle time for cgroups**: Time during which resource group processes get no CPU time due to its full utilization (by host). An exponential increase in this value (from milliseconds to minutes) may cause delays in processing queries.
        * **Summary spill size**: Total size of temporary (spill) files created as a result of RAM shortage.
        * **Interconnect quality**: Packet retransmissions between segments ([{{ GP }} Interconnect]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-intro-arch_overview.html#arch_interconnect) traffic) as a percentage of the total volume of packets sent from each segment host. The higher the value, the less stable the network.
        * **Background activity - the number of sessions**: Number of system sessions on each segment in the following states:
            * **active**: Processing a query.
            * **idle**: Awaiting a command.
            * **aborted**: Terminated with an error.
        * **Background activity - the longest query**: Execution time of the longest system query on each segment.

{% endlist %}

## Monitoring resource groups {#monitoring-resgroup}

To view information on {{ mgp-name }} resource groups:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **Resource groups**.
      
        The page that opens will display performance charts for resource groups.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:
 
    * **CPU Usage**: Total CPU usage across all hosts in a resource group.
    * **Memory Usage**: Total memory usage across all hosts in a resource group.
    * **Running queries**: Current number of active transactions in a resource group.
    * **Queueing queries**: Current number of queueing transactions for this resource group.
    * **Executed queries**: Total number of transactions executed in a resource group since the most recent cluster startup (excluding **Running queries**).
    * **Queued queries**: Total number of transactions enqueued for this resource group since the most recent cluster startup (excluding **Queueing queries**).

{% endlist %}


You can also view information on resource groups for each {{ mgp-name }} cluster host:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **Resource groups per host**.
      
        The page that opens will display performance charts for resource groups by host.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:
 
    * **CPU Usage**: Total CPU usage in a resource group within a host.
    * **Memory Usage**: Total memory usage in a resource group within a host.

{% endlist %}

## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To configure state indicator alerts for a [cluster](#monitoring-cluster) and [hosts](#monitoring-hosts):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster where you want to set up alerts.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}** service.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:
      * **{{ mgp-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mgp-name }} — Host Overview** to configure host alerts.
  1. In the indicator chart, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart shows multiple indicators, select a data query to create a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. For more information about the query language, see [this {{ monitoring-full-name }} guide](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for notifications.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. For composite signals, we recommend configuring alerts for when the status switches to `Crit` (`0`) or `Warn` (`1`).

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-greenplum-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view the health state and status of a cluster:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

### Cluster health states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
