#### How do I figure out the cause of performance degradation at peak loads? {#degradation-at-peak}

Review the slow query log:
1. In the [{{ MY }} cluster settings](../../managed-mysql/operations/update.md#change-mysql-config), set **Long query time** to a value greater than zero.
1. In the [management console]({{ link-console-main }}), select the **{{ ui-key.yacloud.mysql.cluster.switch_logs }}** tab on the cluster page.
1. In the top-left corner, select `MYSQL_SLOW_QUERY` from the drop-down list.

#### How do I figure out the cause of general performance degradation? {#general-degradation}

Check host monitoring charts:
1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Go to the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** page:
   * We recommend upgrading the host class:
      * If the `Steal` value in the **CPU usage** chart is stable high.
      * If the `Free` value in the **Memory usage** chart is stable low.
   * If `iowait` on the **CPU usage** chart is high, the disk storage IOPS limits may be exceeded. We recommend increasing the value to the next [allocation unit](../../compute/concepts/limits.md#compute-limits-disks) threshold, at least, or using faster disks. For more information about disk limits and performance, see the [{{ compute-full-name }} documentation](../../compute/concepts/disk.md).

{% include [qa-replica-lagging](../../_includes/mdb/mmy/qa-replica-lagging.md) %}

#### How do I figure out why resources take long to load? {#long-load}

Check host monitoring charts:
1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Go to the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** page.
1. Find the problem resource: its chart will be approaching or will have crossed the boundary.
1. Select the other hosts from the drop-down list and check them as well.

If the charts do not show overload in the cluster's resources, refer to the recommendations under [Locking mechanisms](#locks) and [Query optimization](#query-optimization).

#### How do I figure out why the CPU resource is utilized? {#high-cpu}

You can retrieve information on the use of the CPU resource with the help of system views. To access them, you need the `PROCESS` cluster-level [administrative privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

1. Grant a user the `PROCESS` privilege by running the [CLI](../../cli/) command below:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster_ID>
   ```

1. Retrieve a list of longest-running database queries by executing the following query:

   ```sql
   SELECT * FROM sys.statement_analysis LIMIT 10;
   ```

Note the queries with high `rows_examined`, `rows_sorted`, or the `full_scan` flag since it is highly likely that these are taking up CPU resources. For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/mysql-em-plugin/en/myoem-metric-sysschema-statementanalysis-category.html).

#### How do I figure out why the IO resource is utilized? {#high-io}

Approximate IO usage by {{ MY }} threads is available from system views. To access them, you need the `PROCESS` cluster-level [administrative privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

1. Grant a user the `PROCESS` privilege by running the [CLI](../../cli/) command below:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster_ID>
   ```

1. Retrieve a list of threads using the query below:

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

The threads supporting the buffer pool and replication are generally higher in the table. This is normal.

#### How do I figure out why the network resource is utilized? {#high-network}

High network load may result: from a `SELECT` that returns many rows, an `INSERT` of large amounts of data, or an `UPDATE` that modifies many records. In the event of a write operation, updates will copy over to the replicated hosts, which will create additional traffic.

Approximate network usage by {{ MY }} threads is available from system views. To access them, you need the `PROCESS` cluster-level [administrative privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

1. Grant a user the `PROCESS` privilege by running the [CLI](../../cli/) command below:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster_ID>
   ```

1. Retrieve a list of threads using the query below:

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

   This query returns statistics from the thread launch, so long-lived connections (such as those used for replication) will be closer to the top.

#### How do I figure out why locks are put in place? {#locks}

If there is no unusual load on the cluster's resources, and queries still take too long to run, use system views to retrieve information on lock waits. To access them, you need the `PROCESS` cluster-level [administrative privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

1. Grant a user the `PROCESS` privilege by running the [CLI](../../cli/) command below:

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

For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/sys-schema-table-lock-waits.html).

#### How do I optimize problem queries? {#query-optimization}

See the official {{ MY }} documentation:

* [Optimizing queries with `EXPLAIN`](https://dev.mysql.com/doc/refman/5.7/en/using-explain.html).
* [Optimizing SQL statements](https://dev.mysql.com/doc/refman/5.7/en/statement-optimization.html).
* [Optimizing tables](https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb.html).
