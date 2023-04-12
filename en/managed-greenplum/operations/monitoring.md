# Monitoring the state of {{ GP }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

New data for charts is received every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mgp-name }} cluster status:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select the ![monitoring.svg](../../_assets/monitoring.svg) **Monitoring** tab.
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

   * **Master**: Definition of primary master host.

   * **Master replication lag**: Master replication delay (in bytes).

   * **Master replication state**: Master replication condition.

   * **Segment health**: Number of segments with various levels of performance:

      * **total**: Everything.
      * **not sync**: Unsynced.
      * **down**: Unavailable.
      * **not prefer role**: Non-preferred.

   * **Spill files count**: Number of temporary files.

   * **Spill files size**: Total size of temporary files (in bytes).

   * **Xid wraparound**: Using a [sequence of transaction IDs]({{ gp.docs.org }}/6-16/admin_guide/managing/maintain.html) (as a percentage).

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mgp-name }} hosts:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{mgp-name }}**.
   1. Click the name of the desired cluster and select ![hosts.svg](../../_assets/mdb/hosts.svg) **Hosts** → **Monitoring**.
   1. Select the host from the drop-down list.

   This page displays graphs showing the workload of an individual cluster host (master or segment):

   * **CPU**: The load on processor cores. As the load goes up, the `Idle` value goes down.
   * **Disk IOPS in progress**: number of pending disk operations.
   * **Disk io time**: duration of disk operations.
   * **Disk read and write**: amount of data (in bytes) in disk operations.
   * **Disk read and write time**: duration of disk reads and writes.
   * **Disk usage**: disk space usage (two graphs are displayed: bytes and percent).
   * **Memory usage**: The use of RAM in bytes. At high loads, the value of `Free` goes down while the other values go up.
   * **Network**: amount of network traffic (in bytes).

{% endlist %}


## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) and [host](#monitoring-hosts) status metric alerts:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select.
      * **{{ mes-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mes-name }} — Host Overview** to configure host alerts.
   1. In the desired chart with metrics, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `Alarm` and `Warning` notification threshold values.
   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-greenplum).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
