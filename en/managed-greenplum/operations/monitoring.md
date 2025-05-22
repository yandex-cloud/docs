---
title: Monitoring the state of a {{ GP }} cluster and hosts
description: Follow this guide to get detailed information about a {{ mgp-name }} cluster state.
---

# Monitoring the state of a {{ GP }} cluster and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

New data for charts is received every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster state {#monitoring-cluster}

To view detailed information about the {{ mgp-name }} cluster state:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** tab.
    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    The page displays the following charts:

    * **Alive hosts**: Cluster host functionality.

    * **Alive segments**: Primary and backup master as well as primary and mirror segment functionality.

    * **Connections**: Number of DB connections in each state:

        * **Active**: Active.
        * **Waiting**: Waiting.
        * **Idle**: Idle.
        * **Idle in transaction**: Idle in a transaction.
        * **Aborted**: Terminated.

    * **Group resource cpu**: Processor core workload by process group:

        * **admin_group**: In the administrative group.
        * **default_group**: In the default group.

    * **Group resource memory**: Bytes of RAM used by process group:

        * **admin_group**: In the administrative group.
        * **default_group**: In the default group.

    * **Master**: Definition of the primary master host.

    * **Master replication lag**: Master replication delay (in bytes).

    * **Master replication state**: Master replication condition.

    * **Segment health**: Number of segments with various levels of performance:

        * **total**: Everything.
        * **not sync**: Unsynced.
        * **down**: Unavailable.
        * **not prefer role**: Non-preferred.

    * **Spill files count**: Number of temporary files.

    * **Spill files size**: Total size of temporary files (in bytes).

    * **Xid wraparound**: Utilization of [sequence of transaction IDs]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-intro-about_mvcc.html#transaction-id-wraparound) (as a percentage).

    * **Background activities**: Group of charts presenting information about background processes:

        * **Tables vacuum age**: Number of custom tables that were [vacuumed](../concepts/maintenance.md#custom-table-vacuum) N days ago.
        * **Tables analyze age**: Number of custom tables for which [statistics were collected](../concepts/maintenance.md#get-statistics) N days ago.
        * **Expansion progress**: Progress of [data redistribution](../concepts/expand.md#redistribution) when expanding a cluster:

            * **Tables**: Percentage of processed tables.
            * **Bytes**: Percentage of redistributed data bytes.

            {% note info %}

            This chart will show the current progress, even if the data redistribution was started not as a [background process](../concepts/expand.md#setting-delay-redistribution).

            {% endnote %}

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the state of individual {{ mgp-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** tab.
    1. Select the host from the drop-down list.

    This page displays charts showing the workload of an individual cluster host (master or segment):

    * **CPU**: Load on processor cores. As the load goes up, the `Idle` value goes down.
    * **Disk IOPS in progress**: Number of pending disk operations.
    * **Disk io time**: Duration of disk operations.
    * **Disk read and write**: Amount of data in disk operations (in bytes).
    * **Disk read and write time**: Duration of disk reads and writes.
    * **Disk usage**: Disk space usage (two charts are displayed, in bytes and %).
    * **Memory usage**: Use of RAM, in bytes. At high loads, the `Free` value goes down, while the other values go up.
    * **Network**: Amount of network traffic (in bytes).

{% endlist %}

## Monitoring network state {#monitoring-network}

To view detailed information about the {{ mgp-name }} cluster network state:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.mdb.cluster.switch_network }}** tab.

    This page displays the following charts:

    * **Interfaces**:
        * **Client Interface Packets**: Number of received and sent packets on the client network interface.
        * **Client Interface Packets**: Total size of received and sent data on the client network interface (in bytes).
        * **Client Interface Drops and Errors**: Number of errors and drops on the client network interface when sending or transmitting packets.
        * **Service Interface Packets**: Number of received and sent packets on the service network interface.
        * **Service Interface Packets**: Total size of received and sent data on the service network interface (in bytes).
        * **Service Interface Drops and Errors**: Number of errors and drops on the service network interface when sending or transmitting packets.

    * **CPU**:
        * **CPU Usage**: Usage of processor cores (percentage).

    * **Ping and SSH response time**:
        * **Host Ping Average Response**: Average ping response time (in milliseconds).
        * **Host Ping Packet Loss**: Lost ping packets (percentage).
        * **Host SSH Response Time**: Response time when connecting via SSH (in milliseconds).

    * **TCP counters**:
        * **TcpActiveConnection**: Number of active TCP connections in the `ESTABLISHED` or `CLOSE-WAIT` state.
        * **TCP Errors**: Number of errors when transmitting TCP packets.
        * **TcpEstabPresets**: Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `ESTABLISHED` or `CLOSE-WAIT` state.
        * **TCP Retransmission**: Number of retransmitted TCP packets.

    * **ICMP Counters**:
        * **IcmpErrors**: Number of ICMP error messages.
        * **Icmp6PacketsTooBig**: Number of ICMPv6 Packet Too Big messages.
        * **IcmpDestUnreached**: Number of ICMP and ICMPv6 Destination Unreachable messages.

    * **UDP counters**:
        * **UdpSndbufErrors**: Number of buffer errors when sending UDP packets.
        * **UDP Datagrams**: Number of UDP packets.
        * **UdpRcvbufErrors**: Number of buffer errors when receiving UDP packets.
        * **UDP NoPorts**: Number of UDP packets received without a listener on the destination port.

    * **IP**:
        * **IpMulticastPackets**: Number of received and sent multicast packets.
        * **Ip6 Neighbor Discovery**: Number of sent requests and router advertisements.
        * **IpBroadcastPackets**: Number of received and sent broadcast packets.
        * **Ip6NoRoutes**: Number of IPv6 packets discarded because no route could be found.

{% endlist %}

## PXF monitoring {#monitoring-pxf}

To view detailed information about the [PXF](external-tables.md) state:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.greenplum.cluster.pxf.value_pxf }}** tab.

    This page displays the following charts:

    * **Liveness**: PXF state on hosts.

    * **Connections**: Number of connections.

    * **Log messages**: Number of messages of the `warn`, `trace`, `info`, `fatal`, `error`, and `debug` types.

    * **File handles**: Number of files opened during the PXF process.

    * **JVM memory**: JVM PXF memory usage (in GB).

    * **PXF threads**: Number of PXF threads.

    * **Sent data**: Amount of sent data.

    * **Sent records**: Number of records send by PXF.

    * **JVM threads**: Number of JVM PXF threads.

    * **PXF Busy threads**: Number of busy PXF threads.

    * **Received data**: Amount of received data.

    * **Received records**: Number of records received by PXF.

{% endlist %}


## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) and [host](#monitoring-hosts) state indicator alerts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you want to configure alerts for.
  1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:
      * **{{ mgp-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mgp-name }} — Host Overview** to configure host alerts.
  1. In the indicator chart, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart shows multiple indicators, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**.  For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for notifications.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/managed-greenplum-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column in the required cluster row.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
