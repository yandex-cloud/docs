# Performance analysis and tuning of {{ mmy-name }}

The following issues normally impact {{ mmy-name }} cluster performance:

* [High CPU load, frequent disk reads and writes, and network requests](#cpu-io-deficit).
* [Inefficient query execution in {{ MY }}](#inefficient-queries).
* [Locks](#localize-locking-issues).

[Monitoring](../../managed-mysql/operations/monitoring.md) tools for {{ MY }} to [troubleshoot performance issues](../../managed-mysql/operations/performance-diagnostics.md) in {{ mmy-name }} clusters and special {{ MY }} queries will help detect these problems.

## Before you begin {#before-start}

1. Select databases to troubleshoot.
1. [Enable statistics collection](../../managed-mysql/operations/performance-diagnostics.md).
1. Create a [{{ MY }} user](../../managed-mysql/operations/cluster-users.md#adduser) with the [`PROCESS`](../../managed-mysql/operations/grant.md#db-privileges) privilege for these databases. Troubleshooting queries must run under this user's account.

## Diagnosing resource shortages {#cpu-io-deficit}

Resource shortage is a likely cause of cluster performance degradation. Resource shortages become evident from [cluster monitoring](../../managed-mysql/operations/monitoring.md) charts (CPU, disk I/O operations, network connections). If a continuously increasing resource utilization plot has leveled out, resource usage has reached its [limit](../../managed-mysql/concepts/limits.md) or exceeded the guaranteed service level.

Special queries can help determine the reasons for elevated resource utilization:

- To estimate Disk IO utilization by different {{ MY }} threads, execute the query:

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
   ORDER BY io.bytes DESC 
   ```

   The query returns a list of {{ MY }} file threads, ranked in descending order by the amount of memory used. Threads that serve replication and the [InnoDB buffer](https://dev.mysql.com/doc/refman/8.0/en/innodb-buffer-pool.html) for caching tables and indexes are usually at the top of the list.

- To estimate network resource utilization by different {{ MY }} threads, execute the query:

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
   ORDER BY net.bytes DESC
   ```

   This query returns statistics from thread launch, so long-lived connections (such as replication) will be returned in the top rows.

   Note the read and write operations that handle a large number of rows. These can also cause increased network load. For writes, changes in WAL will be copied to replicas, which will further increase network load.

- It is not possible to track CPU utilization with individual queries against {{ MY }}, but inefficient queries (see below) can be identified.

## Diagnosing inefficient query execution {#inefficient-queries}

To identify problematic queries against {{ MY }}, execute the query:

```sql
SELECT *
FROM   sys.statement_analysis
LIMIT  10
```

The query returns the 10 longest running queries in the entire server history.

You should pay attention to queries with high `ROWS_EXAMINED`, `ROWS_SORTED`, or the `FULL_SCAN` flag.

To learn more about the information in the output, see the [{{ MY }} documentation](https://dev.mysql.com/doc/mysql-em-plugin/en/myoem-metric-sysschema-statementanalysis-category.html).

## Detecting locks {#localize-locking-issues}

Cluster performance may degrade because of locks obtained when there are multiple simultaneous attempts to access the same DB resource (table, row).

To troubleshoot, check lock queues in queries:

- Table-level lock queue:

   ```sql
   SELECT * FROM sys.schema_table_lock_waits 
   ```

- Individual row-level lock queue:

   ```sql
   SELECT * FROM sys.innodb_lock_waits
   ```

## Solving problems {#solving}

You can try to tune any problematic queries identified in the course of troubleshooting. There are several ways to optimize:

- Analyze the query plan using the [`EXPLAIN` command](https://dev.mysql.com/doc/refman/5.7/en/using-explain.html) and use the query optimization techniques from the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/5.7/en/statement-optimization.html).

- [Optimize InnoDB tables](https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb.html) to reduce disk workload.

If you can't optimize the identified problem queries or manage without them, you can [raise the host class](../../managed-mysql/operations/update.md#change-resource-preset).
