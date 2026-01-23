# {{ mmy-name }} performance analysis and tuning

The following issues usually cause reduced performance of a {{ mmy-name }} cluster:

* [High CPU, disk I/O, and network usage](#cpu-io-deficit).
* [Inefficient query execution in {{ MY }}](#inefficient-queries).
* [Locks](#localize-locking-issues).

{{ MY }} [monitoring](../../managed-mysql/operations/monitoring.md) and [performance diagnostic](../../managed-mysql/operations/performance-diagnostics.md) tools for a {{ mmy-name }} cluster, along with special {{ MY }} queries, will help detect these issues.

## Getting started {#before-start}

1. Select the databases to analyze.
1. [Enable statistics collection](../../managed-mysql/operations/performance-diagnostics.md).
1. Create a [{{ MY }} user](../../managed-mysql/operations/cluster-users.md#adduser) with the [PROCESS](../../managed-mysql/operations/grant.md#db-privileges) privilege for these databases. Use this {{ MY }} user to run all diagnostic queries.

## Diagnosing resource shortages {#cpu-io-deficit}

A resource shortage is a likely cause of reduced cluster performance. [Cluster monitoring](../../managed-mysql/operations/monitoring.md) charts (CPU, disk I/O, and network connections) clearly show any resource shortages. If a steadily growing resource usage chart flattens, the resource has hit its [limit](../../managed-mysql/concepts/limits.md) or run beyond the guaranteed service level. 

You can use special queries to find out what causes increased resource usage:

- To estimate disk I/O usage by different {{ MY }} threads, run this query:

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

   This query returns a list of {{ MY }} file threads ranked by the amount of memory they use, from highest to lowest. Threads that serve replication and the [InnoDB buffer](https://dev.mysql.com/doc/refman/8.0/en/innodb-buffer-pool.html) for caching tables and indexes usually lead the list.

- To estimate network resource usage by different {{ MY }} threads, run this query:

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

   This query returns statistics since the threads were started, so long-lived connections, such as those used for replication, will be closer to the top.
   
   Pay close attention to read and write operations affecting many rows. These can also cause increased network load. For writes, WAL changes will be applied to replicas, which further increases network load.

- You cannot monitor CPU consumption for individual {{ MY }} queries, but you can identify queries that run inefficiently (see below). 

## Diagnosing inefficient query execution {#inefficient-queries}

To identify {{ MY }} queries that run inefficiently, use this query:

```sql
SELECT *
FROM   sys.statement_analysis
LIMIT  10
```

It returns the 10 longest-running queries in the entire server history.

Pay attention to queries with high values for `ROWS_EXAMINED`, `ROWS_SORTED`, or those with the `FULL_SCAN` flag.

For more information about the output, see [this {{ MY }} article](https://dev.mysql.com/doc/mysql-em-plugin/en/myoem-metric-sysschema-statementanalysis-category.html).

## Diagnosing locks {#localize-locking-issues}

Cluster performance may degrade because of locks caused by multiple simultaneous attempts to access the same database resource, e.g., table or row.

To diagnose locking issues, check the query lock wait queues:

  - Table-level lock wait queue:

    ```sql
    SELECT * FROM sys.schema_table_lock_waits 
    ```

  - Row-level lock wait queue:

    ```sql
    SELECT * FROM sys.innodb_lock_waits
    ```

## Troubleshooting {#solving} 

You can try to optimize any queries with performance issues you have diagnosed. There are several ways for optimization:

- Analyze the query plan using [the `EXPLAIN` command](https://dev.mysql.com/doc/refman/5.7/en/using-explain.html) and use the query optimization techniques from [this {{ MY }} article](https://dev.mysql.com/doc/refman/5.7/en/statement-optimization.html).

- [Optimize InnoDB tables](https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb.html) to reduce disk usage.

If optimizing or removing such queries is not an option, consider [upgrading your host class](../../managed-mysql/operations/update.md#change-resource-preset).
