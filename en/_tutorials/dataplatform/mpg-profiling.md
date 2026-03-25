# {{ mpg-name }} performance analysis and tuning

{{ mpg-name }} cluster performance decline most often stems from one of the following causes:

* [Inefficient {{ PG }} queries](#inefficient-queries).
* [High CPU, disk I/O, and network usage](#cpu-io-deficit).
* [Locks](#localize-locking-issues).
* [Exhaustion of available connections](#connection-errors).
* [Insufficient storage space](#storage-issues).

The following are tips for diagnosing and resolving these issues.

To detect potential issues in a cluster, use comprehensive health analysis [tools](../../managed-postgresql/tutorials/performance-problems.md).

## Getting started {#before-start}

1. Select target databases for diagnostic analysis.
1. Enable the **Access from the management console** [cluster setting](../../managed-postgresql/operations/update.md#change-additional-settings).
1. [Enable session and query statistics collection](../../managed-postgresql/operations/performance-diagnostics.md#activate-stats-collector).
1. [Enable the `auto_explain`](../../managed-postgresql/operations/performance-diagnostics.md#auto-explain-enable) module for extended query plan logging.
1. To capture more queries in the performance log, lower the [`log_min_duration_statement`](../../managed-postgresql/concepts/settings-list.md#setting-log-min-duration-statement) threshold in the [DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config).

    {% note warning %}

    With `log_min_duration_statement` set to `0`, the system will log all queries, regardless of their duration. This can lead to the rapid exhaustion of free storage space.

    {% endnote %}


## Diagnosing inefficient queries {#inefficient-queries}

You can identify problematic queries using the following two methods:

* Query the {{ PG }} system table `pg_stat_activity`:

    ```sql
    SELECT NOW() - query_start AS duration, query, state
    FROM pg_stat_activity
    WHERE state != 'idle' ORDER BY 1 DESC;
    ```

    You will see a list of queries running on the server. Look for the queries with a high `duration` value.

    To learn more about this output, see [this {{ PG }} article](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

* [Retrieve and analyze query statistics](../../managed-postgresql/operations/performance-diagnostics.md#get-queries) using the {{ mpg-name }} built-in diagnostics tool.

## Troubleshooting inefficient queries {#solving-inefficient-queries}

There are several ways to optimize problematic queries:

* Analyze query plans using [`EXPLAIN`](https://www.postgresql.org/docs/current/sql-explain.html).

    Look for queries that do not use indexes, indicated by a high row count in `Seq Scan` nodes. These queries increase both I/O load, due to more disk reads, and CPU usage, as processing a large number of rows requires more processor time.

    [Create](https://www.postgresql.org/docs/current/sql-createindex.html) or [update](https://www.postgresql.org/docs/current/sql-reindex.html) the necessary indexes.

    {% note tip %}

    To see query plans, navigate to the **SQL** tab on the cluster management page.

    For more information, see [{#T}](../../managed-postgresql/operations/web-sql-query.md).

    {% endnote %}

* [Automatically log query plans](../../managed-postgresql/operations/performance-diagnostics.md#auto-explain-enable) using the [`auto_explain`](https://www.postgresql.org/docs/current/auto-explain.html) module.

* Update statistics using [`ANALYZE`](https://www.postgresql.org/docs/current/sql-analyze.html).

    The DBMS builds query plans using the collected statistics. Frequent data updates cause these statistics to become outdated rapidly. Use `ANALYZE` to force the DBMS to reanalyze a table or the entire database.

    ```sql
    ANALYZE <table_or_database_name>;
    ```

    If needed, increase `default_statistics_target` in the [DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config), then run `ANALYZE` again.

    To learn more about `default_statistics_target`, see [{{ PG }} settings](../../managed-postgresql/concepts/settings-list.md#setting-default-statistics-target).

* Create extended statistics objects.

    {{ PG }} does not collect statistics on data correlation between columns in the same table. This is due to the potentially vast number of column combinations. If some columns are correlated, [create extended statistics objects](https://www.postgresql.org/docs/current/planner-stats.html#PLANNER-STATS-EXTENDED). This allows the planner to optimize queries using information about data correlation between columns.

* Analyze query plan statistics in {{ PG }} logs.

    The {{ PG }} `auto_explain` module logs query plan statistics, which you can later review using a text search through log entries. For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

If you can neither optimize troublesome queries nor eliminate them, you have to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).

## Diagnosing resource shortages {#cpu-io-deficit}

A resource shortage, a likely cause of cluster performance degradation, can be identified by checking metrics like CPU, disk I/O, and network usage on [cluster monitoring](../../managed-postgresql/operations/monitoring.md) charts. A resource usage chart showing steady growth followed by a plateau indicates that the workload has reached its [limit](../../managed-postgresql/concepts/limits.md) or is exceeding the guaranteed service level.

In most cases, high CPU and disk I/O usage are caused by inefficient indexes or excessive host workload. Review the [session](../../managed-postgresql/operations/performance-diagnostics.md#get-sessions) and [query](../../managed-postgresql/operations/performance-diagnostics.md#get-queryes) data collected by the [performance diagnostics](../../managed-postgresql/operations/performance-diagnostics.md) tool.


## Troubleshooting resource shortages {#solving-cpu-io-deficit}

[Try to optimize](#solving-inefficient-queries) resource-heavy queries. If the load remains high after optimization, you have to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Diagnosing database locks {#localize-locking-issues}

Cluster performance degradation can be caused by locks that occur when multiple processes attempt to access the same database resource, e.g., table or row, concurrently.

To detect locks using the [performance diagnostics tool](../../managed-postgresql/operations/performance-diagnostics.md), do the following:

1. In the [management console]({{ link-console-main }}), select a folder.
1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}** service.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** tab.
1. In the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_sessions }}** field of the **Slice** tab, select **WAIT_EVENT_TYPE**.

    * Review the **Lock** chart showing the number of queries locked during the selected time frame.
    * For detailed information on queries that ran during the selected time period, switch to the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}** tab.

    To learn what statistics you can get, see the [{{ PG }} guides](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6).

To identify locks using {{ PG }} built-in tools, run the following query:

```sql
SELECT * FROM pg_locks pl LEFT JOIN pg_stat_activity psa
    ON pl.pid = psa.pid;
```

   Learn more about retrieving queries involved in locks in [this {{ PG }} article](https://www.postgresql.org/docs/current/view-pg-locks.html).


## Troubleshooting locking issues {#solving-locking-issues}

Try [to optimize troublesome queries](#solving-inefficient-queries). If the load remains high after optimization, you have to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Diagnosing connection errors {#connection-errors}

The number of  connections is limited by the `max_connections` setting,  calculated as:

```text
200 × <vCPU_share_on_host>: 15
```

Here, `<vCPU_share_on_host>` is the product of the number of vCPUs and their CPU guarantee, and `15` is the number of connections reserved for maintenance tasks. The resulting connection pool is distributed across the database roles.

If the number of open connections reaches the limit, the system logs the following errors:

* **Too many connections for role**.
* **Server conn crashed**.
* **Invalid server parameter**.
* **Query wait timeout**.

To review available connection usage details via [monitoring](../../managed-postgresql/operations/monitoring.md) tools:

1. In the [management console]({{ link-console-main }}), select a folder.
1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}** service.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}** tab.
1. Review the **Total pooler connections** chart.

    {{ mpg-name }} does not allow direct DBMS connections. All connections are made via the connection pooler.

    * The **Clients** metric shows the number of client connections to the connection pooler.

    * The **Servers** metric shows the number of connections between the DBMS and the connection pooler.

        Pay attention to the connection count. High values indicate that some queries are keeping connections open for too long.

## Troubleshooting connection issues {#solving-connection-errors}

To address connection limit issues:

* Increase the [`max_connections`](../../managed-postgresql/concepts/settings-list.md#setting-max-connections) value in the [DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config).

* [Distribute available connections among users](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

* Optimize queries to eliminate long-running transactions.

If the load remains high after optimization, you have to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Diagnosing storage space shortages {#storage-issues}

Poor cluster performance accompanied by the `ERROR: cannot execute INSERT in a read-only transaction` error in logs may indicate that storage space has been depleted, causing the cluster to switch to [read-only mode](../../managed-postgresql/concepts/storage.md).

To check available cluster storage space:

1. In the [management console]({{ link-console-main }}), select a folder.
1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}** service.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}** tab.
1. Review the **Disk capacity in primary, [bytes]** chart.

    Pay attention to the **Used** metric showing the cluster storage usage.


## Troubleshooting storage space shortages {#solving-storage-issues}

For troubleshooting recommendations, see [{#T}](../../managed-postgresql/concepts/storage.md#manage-storage-space).
