# Performance issues

#### Degraded performance at peak loads {#degradation-at-peak}

Review the slow query log:
1. In the [{{ MY }} cluster settings](../operations/update.md#change-mysql-config), set **Long query time** to a value greater than zero.
1. In the [management console]({{ link-console-main }}), select the **Logs** tab on the cluster page.
1. In the top left-hand corner, select `MYSQL_SLOW_QUERY` from the drop-down list.

#### General performance degradation {#general-degradation}

Check host monitoring charts:
1. Go to the folder page and select **{{ mmy-short-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Go to the **Monitoring** page:
   * We recommend upgrading the host class:
      * When the value of `Steal` on the **CPU usage** chart is consistently high.
      * When the value of `Free` on the **Memory usage** chart is consistently low.
   * If `iowait` on the **CPU usage** chart is high, the disk storage IOPS limits may be exceeded. We recommend increasing the value to the next [allocation unit](../../compute/concepts/limits.md#compute-limits-disks) threshold, at least, or using faster disks. For more information on limits and disk performance, please review the [{{ compute-full-name }} documentation](../../compute/concepts/disk.md).

{% include [qa-replica-lagging](../../_includes/mdb/mmy/qa-replica-lagging.md) %}

#### Resources taking a long time to load {#long-load}

Check host monitoring charts:
1. Go to the folder page and select **{{ mmy-short-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Go to the **Monitoring** page.
1. Find the problem resource: its plot will be approaching or will have crossed its boundary.
1. Select the other hosts from the drop-down list and check them as well.

If the charts do not show overload in the cluster's resources, refer to the recommendations under [Locking mechanisms](#locks) and [Query optimization](#query-optimization).

#### Cause of high CPU usage {#high-cpu}

You can retrieve information on the use of the CPU resource with the help of system views. For access, you will require the `PROCESS` cluster-level [administrative privilege](../concepts/settings-list.md#setting-administrative-privileges).

1. Grant a user the `PROCESS` privilege by running the [CLI](../../cli/) command below:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster ID>
   ```

1. Retrieve a list of longest-running database queries by executing the following query:

   ```sql
   SELECT * FROM sys.statement_analysis LIMIT 10;
   ```

Note the queries with high `rows_examined`, `rows_sorted`, or the `full_scan` flag since it is highly likely that these are taking up CPU resources. For more information, please review the [{{ MY }} documentation](https://dev.mysql.com/doc/mysql-em-plugin/en/myoem-metric-sysschema-statementanalysis-category.html).

#### Cause of high IO usage {#high-io}

Approximate IO usage by {{ MY }} threads is available from system views. For access, you will require the `PROCESS` cluster-level [administrative privilege](../concepts/settings-list.md#setting-administrative-privileges).

1. Grant a user the `PROCESS` privilege by running the [CLI](../../cli/) command below:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster ID>
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

#### Cause of high network usage {#high-network}

High network load may result: from a `SELECT` that returns many rows, an `INSERT` of large amounts of data, or an `UPDATE` that modifies many records. In the event of a write operation, updates will copy over to the replicated hosts, which will create additional traffic.

Approximate network usage by {{ MY }} threads is available from system views. For access, you will require the `PROCESS` cluster-level [administrative privilege](../concepts/settings-list.md#setting-administrative-privileges).

1. Grant a user the `PROCESS` privilege by running the [CLI](../../cli/) command below:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster ID>
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

   This query returns statistics from thread launch, so long-lived connections (such as those used for replication) will be close to the top.

#### Locking mechanisms {#locks}

If there is no unusual load on a cluster's resources, and queries still take too long to run, use system views to retrieve information on lock waits. For access, you will require the `PROCESS` cluster-level [administrative privilege](../concepts/settings-list.md#setting-administrative-privileges).

1. Grant a user the `PROCESS` privilege by running the [CLI](../../cli/) command below:

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <username> \
       --cluster-id <cluster ID>
   ```

1. For table-level locks, run the following query:

   ```sql
   SELECT * FROM sys.schema_table_lock_waits;
   ```

1. For row-level locks, run the following query:

   ```sql
   SELECT * FROM sys.innodb_lock_waits;
   ```

For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/sys-schema-table-lock-waits.html).

#### Problem query optimization {#query-optimization}

We recommend that you consult the official {{ MY }} documentation:

* [Optimizing queries with `EXPLAIN`](https://dev.mysql.com/doc/refman/5.7/en/using-explain.html).
* [Optimizing SQL statements](https://dev.mysql.com/doc/refman/5.7/en/statement-optimization.html).
* [Optimizing tables](https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb.html).
