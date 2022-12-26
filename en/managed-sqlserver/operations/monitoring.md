# Monitoring the state of clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

New data for charts is received every {{ graph-update }}.

{% include [note-info-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mms-name }} cluster status:

1. Go to the folder page and select **{{ mms-name }}**.

1. Click on the name of the cluster and open the **Monitoring** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

The following charts open on the page:

* **Active transactions**: The number of active transactions per host.

* **Batch requests/sec**: The number of batch operations performed on each host per second. For more information about batch operations, see the [{{ MS }} documentation]({{ ms.docs }}/sql/odbc/reference/develop-app/batches-of-sql-statements).

* **CPU usage**: The load on processor cores. As the load goes up, the `percent_idle_time` value goes down.

* **Disk space usage on primary**: Disk space usage on the [primary replica](../concepts/replication.md) (in bytes).

* **Is alive, [boolean]**: Shows cluster availability as the sum of its hosts' states. Each **Alive** host increases the overall availability by 1.

* **Is primary, [boolean]**: Shows which host is the primary replica and for how long.

* **Lazy writes/sec on primary**: The physical write speed on the primary replica. {{ MS }} splits data writes to more efficiently work with storage:

   * _Logical writes_: Updating data in RAM.
   * _Physical writes_: Writing modified pages from RAM to storage.

   For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/writing-pages).

* **Memory grants pending on primary**: The number of queries waiting for a memory grant. For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/memory-management-architecture-guide).

* **Page life expectancy**: Shows how long (in seconds) pages stay in memory before they're written to storage. The larger its value, the more efficiently the buffer is used and the less often the cluster has to access storage to fetch the necessary data.

* **Transactions/sec on primary**: The average number of transactions executed on the primary replica per second.

* **User connections**: The number of cluster connections. Some connections will always be active. They are used by the cluster itself and the {{ yandex-cloud }} monitoring services.


## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mms-name }} hosts:

1. Go to the folder page and select **{{ mms-name }}**.
1. Click the name of the desired cluster and select **Hosts** → **Monitoring**.
1. Select the host from the drop-down list.

This page displays the following charts:

* **Active transactions**: The number of active transactions per database.

* **Bytes sent/received**: The speed of data exchange over the network (bytes per second).

* **CPU usage**: CPU usage.

* **Disk latency**: Waiting time for disk operations:

   * **avg.\_disk_sec/transfer**: The average time it takes to perform disk operations.
   * **avg.\_disk_sec/write**: The average data write time.
   * **avg.\_disk_sec/read**: The average data read time.

* **Disk read/write bytes/sec**: The speed of disk operations (bytes per second).

* **Disk read/write time**: Disk usage (%).

* **Memory grants pending**: The number of queries waiting for a memory grant.

* **Packets sent/received**: The number of processed network packets:

   * **packets_received_discarded**: The number of discarded packets.

      Packets may be discarded for the following reasons:

      * Transfer errors.
      * Formatting errors.
      * Insufficient storage space.

      Although some packets are always discarded, an increase in this metric value may indicate cluster operation issues.

   * **packets_outbound_errors**: The number of errors when sending packets.
   * **packets_received_errors**: The number of errors when receiving packets.
   * **packets_received_persec**: Shows how many packets are received from the network per second.
   * **packets_sent_persec**: Shows how many packets are sent to the network per second.

* **Page life expectancy**: Shows how long (in seconds) pages stay in memory before they're flushed to storage. The larger its value, the more efficiently the buffer is used and the less often the cluster has to access storage to read and write the necessary data.

* **SQL errors**: The number of SQL query handling errors:

   * **User_Errors**: User errors.
   * **Kill_Connection_Errors**: Fatal errors that killed the connection.
   * **Info_Errors**: The number of information events related to errors.
   * **DB_Offline_Errors**: Errors due to DB unavailability.
   * **Total**: The total number of errors on the host.

* **Disk space usage**: Shows how much disk space is used and available (in bytes).

   * **avg._disk_sec/transfer**: The average time it takes to perform I/O operations.
   * **avg.\_disk_sec/write**: The average data write time.
   * **avg.\_disk_sec/read**: The average data read time.

* **User connections**: The number of host connections. Some connections will always be active. They are used by the cluster itself and the {{ yandex-cloud }} monitoring services.

{% if audience != "internal" %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

* Management console

   1. In the Management console, select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select:
      * **{{ mms-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mms-name }} — Host Overview** to configure host alerts.
   1. In the desired chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. {% if audience == "external" %}For more on the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md). {% endif %}
   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values:

| Metric                                       | Parameter                                       | `Alarm`                     | `Warning`                  |
|---------------------------------------------:|:------------------------------------------------:|:--------------------------:|:--------------------------:|
| Storage space used | `mdb_volume_space.available_space_bytes`          | `10% of storage size` | `20% of storage size` |
| CPU usage                                | `win_cpu.percent_idle_time`                       | `10`,,,,,,,,,,,,,,,,,,,,,,, | `20`,,,,,,,,,,,,,,,,,,,,,,, |
| The number of queries waiting for a memory grant | `mdb_performance_counters.memory_grants_pending` | `2`,,,,,,,,,,,,,,,,,,,,,,,, | `1`,,,,,,,,,,,,,,,,,,,,,,,, |

You can view the current storage size in [detailed information about the cluster](cluster-list.md#get-cluster).

{% endif %}

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the folder page and select **{{ mms-name }}**.
1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
