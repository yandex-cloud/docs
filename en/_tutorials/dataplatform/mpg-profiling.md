# Performance analysis and tuning in {{ mpg-name }}

{{ mpg-name }} cluster performance drops most often due to one of the following:

* [Inefficient query execution in {{ PG }}](#inefficient-queries).
* [High CPU load, frequent disk reads and writes, and network requests](#cpu-io-deficit).
* [Locks](#localize-locking-issues).
* [Running out of available connections](#connection-errors).
* [Running out of free storage space](#storage-issues).

Here are some tips for diagnosing and fixing these issues.


## Before you begin {#before-start}

1. Select databases to troubleshoot.
1. [Enable database access in the management console](../../managed-postgresql/operations/web-sql-query.md#sql-cluster-access).
1. [Activate statistics collection](../../managed-postgresql/operations/performance-diagnostics.md#activate-stats-collector) about sessions and queries.
1. [Enable the `auto_explain` module](../../managed-postgresql/operations/performance-diagnostics.md#auto-explain-enable) for extended query execution plan logging.
1. If you want more queries to appear in the performance log, reduce the value of the [`log_min_duration_statement` parameter](../../managed-postgresql/concepts/settings-list.md#setting-log-min-duration-statement) in the [DB settings](../../managed-postgresql/operations/update.md#change-postgresql-config).

   {% note warning %}

   When the value of `log_min_duration_statement` is `0`, all queries are included in the log, regardless of the time of their execution. In this case, you can run out of storage space quickly.

   {% endnote %}


## Diagnosing inefficient query execution {#inefficient-queries}

To identify problematic queries, make a selection from the {{ PG }} system table `pg_stat_activity`:

```sql
SELECT NOW() - query_start AS duration, query, state
FROM pg_stat_activity
WHERE state != 'idle' ORDER BY 1 DESC;
```

A list of queries running on the server is returned. Check queries with a large `duration`.

To learn more about the information in the output, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Troubleshooting issues with inefficient queries {#solving-inefficient-queries}

There are several ways to optimize problematic queries:

* Analyze the query plan using the [`EXPLAIN`](https://www.postgresql.org/docs/current/sql-explain.html) command.

   Check queries that don't use indexes (a large number of rows in the `Seq Scan` nodes). Such queries increase utilization of both I/O (there're more reads from the disk) and CPU (it takes more processor time to process a large number of rows).

   [Create](https://www.postgresql.org/docs/current/sql-createindex.html) or [update](https://www.postgresql.org/docs/current/sql-reindex.html) appropriate indexes.

   {% note tip %}

   To visualize the execution plans of the available queries, use the **SQL** tab on the cluster management page.

   For more information, see [{#T}](../../managed-postgresql/operations/web-sql-query.md).

   {% endnote %}

* Update statistics using the [`ANALYZE`](https://www.postgresql.org/docs/current/sql-analyze.html) command.

   The query execution plan is based on the statistics collected by the DBMS. If the data in the DBMS is updated frequently, these statistics quickly become outdated. Use the `ANALYZE` query for the DBMS to perform another analysis of the table or the entire database:

   ```sql
   ANALYZE <table or database name>
   ```

   If necessary, in the [DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config), increase the value of `default_statistics_target`, then run the `ANALYZE` query again.

   For more information about the `default_statistics_target` parameter, see the [{{ PG }} settings](../../managed-postgresql/concepts/settings-list.md#setting-default-statistics-target).

* Create extended statistics objects.

   {{ PG }} doesn't collect statistics about the correlation of data between columns of the same table. This is because the number of possible combinations of columns can be extremely large. If there is a relationship between columns, [create extended statistics objects](https://www.postgresql.org/docs/current/planner-stats.html#PLANNER-STATS-EXTENDED). The scheduler will then be able to optimize queries based on information about the correlation of data in the columns.

* Analyze query execution plan statistics in {{ PG }} logs.

   The {{ PG }} `auto_explain` module outputs query execution plan information to the {{ PG }} log. You can collect statistics by searching the lines in the log. For more information, see the [{{ PG }}documentation](https://www.postgresql.org/docs/current/auto-explain.html).

If you can't optimize the identified queries or manage without them, the only option is to [raise the host class](../../managed-postgresql/operations/update.md#change-resource-preset).

## Diagnosing resource shortages {#cpu-io-deficit}

Resource shortage is a likely cause of cluster performance degradation. Resource shortages become evident from [cluster monitoring](../../managed-postgresql/operations/monitoring.md) charts (CPU, disk I/O operations, network connections). If a resource utilization chart continued to rise but then plateaued, the resource load has reached its [limit](../../managed-postgresql/concepts/limits.md) or is exceeding the guaranteed service level.

In most cases, high CPU utilization and high disk I/O are due to suboptimal indexes or a large load on the hosts. Examine the data on [sessions](../../managed-postgresql/operations/performance-diagnostics.md#get-sessions) and [queries](../../managed-postgresql/operations/performance-diagnostics.md#get-queryes) collected by the [performance diagnostics](../../managed-postgresql/operations/performance-diagnostics.md) tool.


## Troubleshooting resource shortage issues {#solving-cpu-io-deficit}

[Try optimizing](#solving-inefficient-queries) identified queries that consume a large amount of resources. If the load is still high or there is nothing to optimize, the only option is to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Detecting locks {#localize-locking-issues}

Cluster performance may degrade because of locks obtained when there are multiple simultaneous attempts to access the same DB resource (table, row).

To detect locks using the [performance diagnostics tool](../../managed-postgresql/operations/performance-diagnostics.md):

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click on the name of the cluster and select the **Performance diagnostics** tab.
1. On the **Sessions** tab in **Slice by**, select the value _WAIT_EVENT_TYPE_.

   * Examine the **Lock** chart. It shows the number of queries that were in the locked state during the selected period.
   * To get detailed information about queries running during the selected period, go to the **Queries** tab.

   For more information about what statistics you can get, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6).

To diagnose the presence of locks using {{ PG }}, run the query:

```sql
SELECT * FROM pg_locks pl LEFT JOIN pg_stat_activity psa
    ON pl.pid = psa.pid;
```

For more information about selecting queries with locks, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/view-pg-locks.html).


## Troubleshooting locking issues {#solving-locking-issues}

Try [optimizing the identified queries](#solving-inefficient-queries). If the load is still high or there is nothing to optimize, the only option is to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Diagnosing connection errors {#connection-errors}

The number of DB connections is limited by the `max_connections` parameter and is calculated by the formula:

```text
200 × <vCPU share on the host> — 15
```

Here, `<vCPU share on the host>` is the product of the number of vCPUs by their guaranteed performance and `15` is the number of reserved service connections. The resulting number of connections is distributed between the database roles.

If the number of open connections reaches the limit, errors appear in the cluster logs:

* **Too many connections for role**.
* **Server conn crashed**.
* **Invalid server parameter**.
* **Query wait timeout**.

To get detailed information about the usage of available connections using [monitoring](../../managed-postgresql/operations/monitoring.md) tools:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. On the **Monitoring** tab, check the **PostgreSQL connections, [count]** and **Pooler connections, [count]** charts.

   {{ mpg-name }} doesn't allow connections directly to the DBMS, instead, they are connected to the connection pooler.

   Review the charts:

   * **PostgreSQL connections, [count]** reflects the number of connections between the DBMS and the pooler.

      Check the number of connections in the **Waiting** and **Idle in transaction** statuses. High values indicate that some queries keep connections open for too long.

   * **Pooler connections, [count]** reflects the usage of connections to the pooler.

      Check the number of connections in the **Used clients** status. This parameter shows the number of connections initiated by the application with the cluster.


## Troubleshooting connection issues {#solving-connection-errors}

To fix issues with the number of connections:

* Increase the value of [`max_connections`](../../managed-postgresql/concepts/settings-list.md#setting-max-connections) in the [DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config).

* [Distribute free connections between users](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

* Optimize queries so that there are no long transactions.

If the load is still high or there is nothing to optimize, the only option is to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Diagnosing insufficient storage space {#storage-issues}

If the cluster shows poor performance and the logs show `ERROR: cannot execute INSERT in a read-only transaction`, it's possible that cluster storage has run out of free space and it has switched to [read-only mode](../../managed-postgresql/concepts/storage.md).

To check for free space in cluster storage:

1. Go to the folder page and select **{{ mpg-name }}**.
1. Click on the cluster name and select the **Monitoring** tab.
1. Check the **Disk capacity in primary, [bytes]** chart.

   Check the value of the **Used** parameter, showing the degree of cluster storage usage.


## Troubleshooting problems with insufficient storage space {#solving-storage-issues}

For recommendations on troubleshooting these issues, see [{#T}](../../managed-postgresql/concepts/storage.md#read-only-solutions) and [{#T}](../../managed-postgresql/concepts/storage.md#read-only-monitor).
