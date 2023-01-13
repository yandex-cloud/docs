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

   * **Xid wraparound**: Utilization of [sequence of transaction IDs](https://docs.greenplum.org/6-16/admin_guide/managing/maintain.html) (as a percentage).

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

{% if audience != "internal" %}

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

{% endif %}

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Solomon metrics {#solomon}

Here are the descriptions of the {{ mgp-name }} metrics that are automatically collected in Solomon.

The name of the metric is written in the `name` label.

{% cut "Labels shared by all metrics of the service" %} 

| Label | Value |
----|----
| service | Service ID: `managed-greenplum` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster name |
| cid | Cluster ID |
| host | Host FQDN |
| FQDN | Host FQDN |

{% endcut %}

{% cut "CPU metrics" %}

The load on processor cores.

{% include [CPU](../../_includes/mdb/internal/metrics-cpu.md) %}

{% endcut %}

{% cut "Disk metrics" %}

Additional labels: `device`: Disk ID in the system.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk-free`<br/>`DGAUGE`, bytes | Free space. |
| `disk-inodes_free`<br/>`DGAUGE`, pcs | Number of free inodes. |
| `disk-inodes_total`<br/>`DGAUGE`, pcs | Available inodes. |
| `disk-inodes_used`<br/>`DGAUGE`, pcs | Used inodes. |
| `disk-total`<br/>`DGAUGE`, bytes | Available space. |
| `disk-used`<br/>`DGAUGE`, bytes | Used space. |
| `disk-used_percent`<br/>`DGAUGE`, % | Percentage of used space. |

{% endcut %}

{% cut "Disk operation metrics" %}

Additional labels: device: `dev`: Disk ID in the system.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `diskio.io_time`<br/>`DGAUGE`, ms | Disk operation duration. |
| `diskio.iops_in_progress`<br/>`DGAUGE`, pcs | Disk operations in progress. |
| `diskio.merged_reads`<br/>`DGAUGE`, pcs | Number of merged disk reads. |
| `diskio.merged_writes`<br/>`DGAUGE`, pcs | Number of merged disk writes. |
| `diskio.read_bytes`<br/>`DGAUGE`, bytes | Bytes read from disk. |
| `diskio.read_time`<br/>`DGAUGE`, ms | Disk read time. |
| `diskio.reads`<br/>`DGAUGE`, pcs | The number of disk reads. |
| `diskio.weighted_io_time`<br/>`DGAUGE`, ms | Waiting time for I/O operations. |
| `diskio.write_bytes`<br/>`DGAUGE`, bytes | Bytes written to disk. |
| `diskio.write_time`<br/>`DGAUGE`, ms | Disk write time. |
| `diskio.writes`<br/>`DGAUGE`, pcs | The number of disk writes. |

{% endcut %}

{% cut "RAM metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `/System/memory/active`<br/>`DGAUGE`, bytes | RAM usage, `active` usage type. |
| `/System/memory/available`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type. |
| `/System/memory/available_percent`<br/>`DGAUGE`, % | Available RAM, %. |
| `/System/memory/buffered`<br/>`DGAUGE`, bytes | RAM usage, `buffered` usage type. |
| `/System/memory/cached`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type. |
| `/System/memory/commit_limit`<br/>`DGAUGE`, bytes | RAM usage, `commit_limit` usage type. |
| `/System/memory/committed_as`<br/>`DGAUGE`, bytes | RAM usage, `committed_as` usage type. |
| `/System/memory/dirty`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type. |
| `/System/memory/free`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type. |
| `/System/memory/high_free`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type. |
| `/System/memory/high_total`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type. |
| `/System/memory/huge_page_size`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type. |
| `/System/memory/huge_pages_free`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type. |
| `/System/memory/huge_pages_total`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type. |
| `/System/memory/inactive`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type. |
| `/System/memory/low_free`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type. |
| `/System/memory/low_total`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type. |
| `/System/memory/mapped`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type. |
| `/System/memory/page_tables`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type. |
| `/System/memory/shared`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type. |
| `/System/memory/slab`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type. |
| `/System/memory/sreclaimable`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type. |
| `/System/memory/sunreclaim`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type. |
| `/System/memory/swap_cached`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type. |
| `/System/memory/swap_free`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type. |
| `/System/memory/swap_total`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type. |
| `/System/memory/total`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type. |
| `/System/memory/used`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type. |
| `/System/memory/used_percent`<br/>`DGAUGE`, % | Used RAM, %. |
| `/System/memory/vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type. |
| `/System/memory/vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type. |
| `/System/memory/vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type. |
| `/System/memory/write_back`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type. |
| `/System/memory/write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type. |

{% endcut %}

{% cut "Network metrics" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "Service metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `gp.conn_aborted`<br/>`DGAUGE`, pcs | Number of aborted DB connections. |
| `gp.conn_active`<br/>`DGAUGE`, pcs | Number of active DB connections. |
| `gp.conn_count`<br/>`DGAUGE`, pcs | Number of DB connections. |
| `gp.conn_idle`<br/>`DGAUGE`, pcs | Number of idle DB connections. |
| `gp.conn_idle_in_transaction`<br/>`DGAUGE`, pcs | Number of idle DB connections for an incomplete transaction. |
| `gp.conn_waiting`<br/>`DGAUGE`, pcs | Number of pending DB connections. |
| `gp.connect_percent`<br/>`DGAUGE`, % | Percentage of connections. |
| `gp.is_alive`<br/>`DGAUGE` | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `gp.is_alive_segment`<br/>`DGAUGE` | Segment host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `gp.is_dead`<br/>`DGAUGE` | Host health indicator.<br/>`0` if a DB host is alive, `1` if not. |
| `gp.is_master`<br/>`DGAUGE` | Host type indicator.<br/>`1` if it's a DB master host, `0` if not. |
| `gp.master_replication_state`<br/>`DGAUGE` | Master replication status. |
| `gp.percent_xid_wraparound`<br/>`DGAUGE`, % | Transaction ID sequence usage.<br/>Additional labels: `db_name` |
| `gp.ping`<br/>`DGAUGE` | <br/>Additional labels: `can_read`, `is_master`, and `can_write` |
| `gp.pxf_is_alive`<br/>`DGAUGE` | Shows if the PXF extension is available. |
| `gp.rg_cpu_used`<br/>`DGAUGE` | CPU allocation across resource groups.<br/>Additional labels: `resgroup` |
| `gp.rg_mem_available`<br/>`DGAUGE` | Allocation of available RAM across resource groups.<br/>Additional labels: `resgroup` |
| `gp.rg_mem_used`<br/>`DGAUGE` | Allocation of RAM used across resource groups.<br/>Additional labels: `resgroup` |
| `gp.seg_count`<br/>`DGAUGE`, pcs | Number of segments in the cluster. |
| `gp.seg_down`<br/>`DGAUGE` | Segments that are down. |
| `gp.seg_not_synch`<br/>`DGAUGE` | Unsynced segments. |
| `gp.spill_files_num_per_seghost`<br/>`DGAUGE`, pcs | Number of temporary files per host. |
| `gp.spill_files_size_per_seghost`<br/>`DGAUGE`, bytes | Size of temporary files per host. |

{% endcut %}

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
