# Monitoring the state of {{ GP }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

New data for charts is received every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster state {#monitoring-cluster}

To view detailed information about the {{ mgp-name }} cluster state:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and select the ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** tab.
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

   * **Xid wraparound**: Using a [sequence of transaction IDs]({{ gp.docs.pivotal }}/6-16/admin_guide/managing/maintain.html) (as a percentage).

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the state of individual {{ mgp-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and select the ![hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** tab.
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


## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) and [host](#monitoring-hosts) status metric alerts:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you want to configure alerts for.
   1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:
      * **{{ mgp-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mgp-name }} — Host Overview** to configure host alerts.
   1. In the chart with metrics, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.monitoring.button_create-alert }}**.
   1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for notifications.
   1. Click **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/managed-greenplum-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column in the required cluster row.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
