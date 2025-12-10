#### How do I find out what is causing performance degradation at peak loads? {#degradation-at-peak}

Review the slow query log:
1. In the [{{ MY }} cluster settings](../../managed-mysql/operations/update.md#change-mysql-config), set **Long query time** to a value greater than zero.
1. In the [management console]({{ link-console-main }}), select the **{{ ui-key.yacloud.mysql.cluster.switch_logs }}** tab on the cluster page.
1. In the top-left corner, select `MYSQL_SLOW_QUERY` from the drop-down list.

#### How do I find out what is causing overall performance degradation? {#general-degradation}

Check host monitoring charts:
1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Go to the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** page:
   * We recommend upgrading your host class:
      * If the `Steal` value in the **CPU usage** chart remains consistently high.
      * If the `Free` value in the **Memory usage** chart remains consistently low.
   * High `iowait` values in the **CPU usage** chart may signal that the disk storage is hitting its IOPS limits. We recommend increasing the value to at least the next [allocation unit](../../compute/concepts/limits.md#compute-limits-disks) threshold or using higher-speed disks. For more information about disk limits and performance, see [this {{ compute-full-name }} article](../../compute/concepts/disk.md).

{% include [qa-replica-lagging](../../_includes/mdb/mmy/qa-replica-lagging.md) %}

#### How do I find out why resources take long to load? {#long-load}

Check host monitoring charts:
1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Go to the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** page.
1. Find the resource in question: its chart will be approaching or crossing the limit.
1. Select the other hosts from the drop-down list and check them as well.

If the charts do not show overloading of the cluster resources, follow the recommendations under [Causes of locks](#locks) and [Query optimization](#query-optimization).

#### How do I find out what is causing high CPU usage? {#high-cpu}

To get data on CPU usage, use system views. To access these views, you need the `PROCESS` [administrative privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) for the cluster.

1. Grant the `PROCESS` privilege to the user by running this [CLI](../../cli/) command:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster_ID>
   ```

1. Use the following query to get the list of longest-running database queries:

   ```sql
   SELECT * FROM sys.statement_analysis LIMIT 10;
   ```

Pay attention to queries with high values for `rows_examined` and `rows_sorted`, or those with the `full_scan` flag, as they are likely to use the most CPU. For more information, see [this {{ MY }} article](https://dev.mysql.com/doc/mysql-em-plugin/en/myoem-metric-sysschema-statementanalysis-category.html).

#### How do I find out what is causing high I/O usage? {#high-io}

To get approximate I/O usage by {{ MY }} threads, use system views. To access these views, you need the `PROCESS` [administrative privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) for the cluster.

1. Grant the `PROCESS` privilege to the user by running this [CLI](../../cli/) command:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster_ID>
   ```

1. Get the list of threads using the following query:

   ```sql
   SELECT   t.name             AS thread_name,
            t.processlist_user AS user,
            t.processlist_info AS query,
            t.processlist_time AS time,
            io.bytes           AS bytes
   FROM     performance_schema.threads t
   JOIN
            (
                     SELECT   thread_id,
                              sum(number_of_bytes) AS bytes
                     FROM     performance_schema.events_waits_history_long
                     WHERE    object_type='FILE'
                     GROUP BY thread_id) io
   ON       t.thread_id = io.thread_id
   ORDER BY io.bytes DESC;
   ```

Typically, the threads at the top of the table are those handling the buffer pool and replication, which is normal.

#### How do I find out what is causing high network usage? {#high-network}

High network load may result from a `SELECT` returning a large number of rows, an `INSERT` of large amounts of data, or an `UPDATE` affecting many rows. Writes will replicate changes to replica hosts, generating extra traffic.

To get approximate network usage by {{ MY }} threads, use system views. To access these views, you need the `PROCESS` [administrative privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) for the cluster.

1. Grant the `PROCESS` privilege to the user by running this [CLI](../../cli/) command:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster_ID>
   ```

1. Get the list of threads using the following query:

   ```sql
   SELECT   t.name                       AS thread_name,
            t.processlist_user           AS user,
            t.processlist_info           AS query,
            t.processlist_time           AS time,
            net.bytes/t.processlist_time AS avg_bytes,
            net.bytes                    AS total_bytes
   FROM     performance_schema.threads t
   JOIN
            (
                     SELECT   thread_id,
                              Sum(variable_value) bytes
                     FROM     performance_schema.status_by_thread
                     WHERE    variable_name IN ('Bytes_sent',
                                                'Bytes_received')
                     GROUP BY thread_id ) net
   ON       t.thread_id = net.thread_id
   WHERE    t.processlist_time IS NOT NULL
   ORDER BY net.bytes DESC;
   ```

   This query returns statistics since the threads were started, so long-lived connections, such as those used for replication, will be closer to the top.

#### How do I find out the causes of locks? {#locks}

If the cluster resources are not overloaded yet queries run slowly, use system views to retrieve information on lock waits. To access these views, you need the `PROCESS` [administrative privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) for the cluster.

1. Grant the `PROCESS` privilege to the user by running this [CLI](../../cli/) command:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster_ID>
   ```

1. To view table-level locks, run the following query:

   ```sql
   SELECT * FROM sys.schema_table_lock_waits
   ```

1. To view row-level locks, run the following query:

   ```sql
   SELECT * FROM sys.innodb_lock_waits
   ```

For more information, see [this {{ MY }} article](https://dev.mysql.com/doc/refman/8.0/en/sys-schema-table-lock-waits.html).

#### How do I optimize queries with performance issues? {#query-optimization}

See the official {{ MY }} documentation:

* [Optimizing queries with `EXPLAIN`](https://dev.mysql.com/doc/refman/5.7/en/using-explain.html).
* [Optimizing SQL statements](https://dev.mysql.com/doc/refman/5.7/en/statement-optimization.html).
* [Optimizing tables](https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb.html).
