---
title: '{{ GP }} cluster and host status monitoring'
description: Follow this guide to get detailed information about a {{ GP }} cluster's state.
---

# {{ GP }} cluster and host status monitoring

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Charts are updated every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Cluster state monitoring {#monitoring-cluster}

To view detailed information on the state of a {{ GP }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder page]({{ link-console-main }}) and select **Yandex MPP Analytics for PostgreSQL**.
    1. Click the name of your cluster and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** tab.
      
        The page that opens will display performance charts for the {{ GP }} cluster.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:

    * **Connections**: Number of DB connections in each state:

        * **Active**
        * **Waiting**
        * **Idle**
        * **Idle in transaction**
        * **Aborted**
    
    * **Segment health**: Number of segments with various performance levels:

        * **total**: All segments.
        * **not sync**: Unsynced segments.
        * **down**: Unavailable segments.
        * **not prefer role**: Non-preferred segments.
    
    * **Xid wraparound**: Utilization of a [sequence of transaction IDs]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-intro-about_mvcc.html#transaction-id-wraparound) (as a percentage).
    * **Master replication lag** (in bytes).
    * **Master replication state**.
    * **Spill files size**: Total size of temporary files (in bytes).
    * **Spill files count**: Number of temporary files.
    * **Group resource memory**: Bytes of RAM used by process group:

        * **admin_group**: In the administrative group.
        * **default_group**: In the default group.

    * **Group resource cpu**: Processor core workload by process group:

        * **admin_group**: In the administrative group.
        * **default_group**: In the default group.
    
    * **Master**: Definition of the primary master host.
    * **Alive hosts**: Availability of the cluster host.
    * **Alive segments**: Availability of the primary and backup master as well as of the primary and mirror segment.
    * **Connection pooler**:
        
        * **Client connections**: Number of available and busy client connections in the pool.
        * **Server connections**: Number of available and busy server connections in the pool.
        * **TCP connections**: Number of TCP connections in the pool.

    * **Background activities**:
    
        * Table maintenance:

          * **Tables vacuum age**: Number of custom tables that were [vacuumed](../concepts/maintenance.md#custom-table-vacuum) N days ago.
          * **Tables analyze age**: Number of custom tables for which [statistics were collected](../concepts/maintenance.md#get-statistics) N days ago.
          * **Expansion progress**: [Data redistribution](../concepts/expand.md#redistribution) progress when expanding a cluster:

            * **Tables**: Percentage of processed tables.
            * **Bytes**: Percentage of redistributed data bytes.

            {% note info %}

            This chart will show the current progress, even if the data redistribution was started not as a [background process](../concepts/expand.md#setting-delay-redistribution).

            {% endnote %}
        
        * System catalog bloat statistics:

          * **Total catalog size**: Catalog size for all segments.
          * **Number of dead tuples for segments**: `dead_tuple` count in the `pg_attribute` table for all segments.
          * **Interval from the last vacuum time for segments**: Time elapsed since the last vacuuming of the `pg_attribute` table for all segments.

          The chart does not display all the [bloat metrics](../metrics.md#managed-greenplum-bloat-metrics). You can build the charts for the rest of the metrics yourself.
          
          > For example, to get the `live_tuple` count in a catalog on the master, [run this request](../../monitoring/operations/metric/metric-explorer.md#add-graph):
          >
          > `alias(series_max("gp_vacuum.pg_attribute_live_tuples_master"{folderId = "b1g4unjqq856********", service = "managed-greenplum", resource_id = "c9q35r4odgeb********"}), "not_var{{ database }}")`
          
          See [{#T}](../metrics.md#managed-greenplum-bloat-metrics) for the list of available metrics.

    * **Test Queries Execution Time**:
        
        * **Read from cluster**: Data read rate.
        * **Write to cluster**: Data write rate.
        * **Read from each segment**: Read rate for each cluster segment.
    
    * **Hybrid Storage**:
        
        * **Objects count**: Number of objects in the database.
        * **Total objects size, bytes**: Total size of object in the database, in bytes.

{% endlist %}

## Host state monitoring {#monitoring-hosts}

To view detailed information on the state of individual {{ GP }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder page]({{ link-console-main }}) and select **Yandex MPP Analytics for PostgreSQL**.
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
    * **Memory usage**: Amount of RAM used, in bytes. At high workloads, the `Free` value goes down, while the other values go up.
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

To view detailed information about the network state of each host in a {{ GP }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder page]({{ link-console-main }}) and select **Yandex MPP Analytics for PostgreSQL**.
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
        * **Host Ping Average Response**: Average ping response time (in milliseconds).
        * **Host SSH Response Time**: Response time when connecting over SSH (in milliseconds).
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

    1. Navigate to the [folder page]({{ link-console-main }}) and select **Yandex MPP Analytics for PostgreSQL**.
    1. Click the cluster name and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.greenplum.cluster.pxf.value_pxf }}** tab.

        The page that opens will display PXF state charts.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:

    * **Liveness**: PXF state on hosts.
    * **JVM memory**: JVM PXF memory usage (in GB).
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

To view a dashboard for a {{ GP }} cluster, do the following:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder page]({{ link-console-main }}) and select **Yandex MPP Analytics for PostgreSQL**.
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

To view information on {{ GP }} resource groups:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ mgp-short-name }}**.
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


You can also view information on resource groups for each {{ GP }} cluster host:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ mgp-short-name }}**.
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

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster for which you want to set up alerts.
  1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:
      * **{{ mgp-name }} — Cluster Overview** to set up cluster alerts.
      * **{{ mgp-name }} — Host Overview** to set up host alerts.
  1. In the indicator chart, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart shows multiple indicators, select a data query to create a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. For more information about the query language, see [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for notifications.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see [this {{ monitoring-name }} article](../../monitoring/metrics-ref/managed-greenplum-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster’s state and status:

1. Navigate to the [folder page]({{ link-console-main }}) and select **Yandex MPP Analytics for PostgreSQL**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
