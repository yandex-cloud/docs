# {{ mpg-name }} performance analysis and tuning

{{ mpg-name }} cluster performance drops most often due to one of the following:

* [Inefficient query execution in {{ PG }}](#inefficient-queries).
* [High CPU load, frequent disk reads and writes, and network requests](#cpu-io-deficit).
* [Locks](#localize-locking-issues).
* [Running out of available connections](#connection-errors).
* [Running out of free storage space](#storage-issues).

Here are some tips for diagnosing and fixing these issues.

To detect potential issues in a cluster, [use tools](../../managed-postgresql/tutorials/performance-problems.md) for comprehensive cluster state analysis.

## Getting started {#before-start}

1. Select databases to troubleshoot.


1. [Enable the **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**](../../managed-postgresql/operations/update.md#change-additional-settings) option in the cluster.


1. [Activate statistics collection](../../managed-postgresql/operations/performance-diagnostics.md#activate-stats-collector) about sessions and queries.
1. [Enable the `auto_explain` module](../../managed-postgresql/operations/performance-diagnostics.md#auto-explain-enable) for extended query execution plan logging.
1. If you want more queries to appear in the performance log, reduce the value of the [`log_min_duration_statement` parameter](../../managed-postgresql/concepts/settings-list.md#setting-log-min-duration-statement) in the [DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config).

    {% note warning %}

    When `log_min_duration_statement` is set to `0`, all queries are logged, regardless of the time they take to complete. In this case, you can run out of storage space quickly.

    {% endnote %}


## Diagnosing inefficient query execution {#inefficient-queries}

There are two ways to identify problematic queries:

* Retrieve them from the {{ PG }} `pg_stat_activity` system table:

    ```sql
    SELECT NOW() - query_start AS duration, query, state
    FROM pg_stat_activity
    WHERE state != 'idle' ORDER BY 1 DESC;
    ```

    This will return a list of queries running on the server. Pay attention to queries with a high `duration` value.

    To learn more about the information in the output, see the [{{ PG }}](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW) documentation.

* [Get and analyze query statistics](../../managed-postgresql/operations/performance-diagnostics.md#get-queries) using the diagnostics tool integrated into {{ mpg-name }}.

## Troubleshooting issues with inefficient queries {#solving-inefficient-queries}

There are several ways to optimize problematic queries:

* Analyze the query plan using the [`EXPLAIN`](https://www.postgresql.org/docs/current/sql-explain.html) command.

    Check queries that do not use indexes (a large number of rows in the `Seq Scan` nodes). Such queries increase utilization of both I/O (due to more reads from the disk) and CPU (as it takes more processor time to process large numbers of rows).

    [Create](https://www.postgresql.org/docs/current/sql-createindex.html) or [update](https://www.postgresql.org/docs/current/sql-reindex.html) appropriate indexes.

    
    {% note tip %}

    To visualize the execution plans of the available queries, use the **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}** tab on the cluster management page.

    For more information, see [{#T}](../../managed-postgresql/operations/web-sql-query.md).

    {% endnote %}


* [Log the query execution plan automatically ](../../managed-postgresql/operations/performance-diagnostics.md#auto-explain-enable) using the [`auto_explain` module](https://www.postgresql.org/docs/current/auto-explain.html).

* Update statistics using the [`ANALYZE`](https://www.postgresql.org/docs/current/sql-analyze.html) command.

    The query execution plan is based on the statistics collected by the DBMS. If the data in the DBMS is updated frequently, these statistics quickly become outdated. Use the `ANALYZE` query for the DBMS to perform a new analysis of the table or entire database:

    ```sql
    ANALYZE <table_or_database_name>;
    ```

    If required, in the [DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config), increase the value of `default_statistics_target`, then run the `ANALYZE` query again.

    For more information about the `default_statistics_target` parameter, see the [{{ PG }} settings](../../managed-postgresql/concepts/settings-list.md#setting-default-statistics-target).

* Create extended statistics objects.

    {{ PG }} does not collect statistics about the correlation of data between columns of the same table. This is because the number of possible combinations of columns can be extremely large. If there is a relationship between columns, [create extended statistics objects](https://www.postgresql.org/docs/current/planner-stats.html#PLANNER-STATS-EXTENDED). The scheduler will then be able to optimize queries based on information about the correlation of data in the columns.

* Analyze query execution plan statistics in {{ PG }} logs.

    The {{ PG }} `auto_explain` module outputs info on the query execution plan to the {{ PG }} log. You can collect statistics by searching the lines in the log. For more information, see the [{{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html) documentation.

If you cannot optimize the identified queries or manage without them, the only option is to [change the host class to a higher one](../../managed-postgresql/operations/update.md#change-resource-preset).

## Diagnosing resource shortages {#cpu-io-deficit}

Resource shortage is a likely cause of cluster performance degradation. Resource shortages become evident from [cluster monitoring](../../managed-postgresql/operations/monitoring.md) charts (CPU, disk I/O operations, network connections). If a resource utilization chart continued to rise but then plateaued, the resource load has reached its [limit](../../managed-postgresql/concepts/limits.md) or is exceeding the guaranteed service level.

In most cases, high CPU utilization and high disk I/O are due to suboptimal indexes or a large load on the hosts. Check the data on [sessions](../../managed-postgresql/operations/performance-diagnostics.md#get-sessions) and [queries](../../managed-postgresql/operations/performance-diagnostics.md#get-queryes) collected by the [performance diagnostics](../../managed-postgresql/operations/performance-diagnostics.md) tool.


## Troubleshooting resource shortage issues {#solving-cpu-io-deficit}

[Try optimizing](#solving-inefficient-queries) identified queries that consume a large amount of resources. If the load is still high or there is nothing to optimize, the only option is to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Detecting locks {#localize-locking-issues}

Cluster performance may degrade because of locks obtained when there are multiple simultaneous attempts to access the same DB resource (table, row).

To detect locks using the [performance diagnostics tool](../../managed-postgresql/operations/performance-diagnostics.md):

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** tab.
1. On the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_sessions }}** tab, in the **Slice** field, select **WAIT_EVENT_TYPE**.

    * Check the **Lock** chart. It shows the number of queries that were in the locked state during the selected period.
    * To get detailed information about queries running during the selected period, go to the **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}** tab.

    For more information about what statistics you can get, see the [{{ PG }}](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6) documentation.

To diagnose the presence of locks using {{ PG }}, run the query:

```sql
SELECT * FROM pg_locks pl LEFT JOIN pg_stat_activity psa
    ON pl.pid = psa.pid;
```

For more information about selecting queries with locks, see the [{{ PG }}](https://www.postgresql.org/docs/current/view-pg-locks.html) documentation.


## Troubleshooting locking issues {#solving-locking-issues}

Try [optimizing the identified queries](#solving-inefficient-queries). If the load is still high or there is nothing to optimize, the only option is to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Diagnosing connection errors {#connection-errors}

The number of DB connections is limited by the `max_connections` parameter and is calculated by the following formula:

```text
200 × <vCPU_share_on_host>: 15
```

Where `<vCPU_share_on_host>` is the product of the number of vCPUs by their guaranteed share and `15` is the number of reserved service connections. The resulting number of connections is distributed between the database roles.

If the number of open connections reaches the limit, errors appear in the cluster logs:

* **Too many connections for role**.
* **Server conn crashed**.
* **Invalid server parameter**.
* **Query wait timeout**.

To get detailed information about the usage of available connections using [monitoring](../../managed-postgresql/operations/monitoring.md) tools:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}** tab.
1. Check the **Total pooler connections** chart.

    {{ mpg-name }} does not allow connections directly to the DBMS; instead, they go to the connection pooler.

    * The **Clients** parameter reflects the number of client connections to the connection pooler.

    * The **Servers** parameter reflects the number of connections between the DBMS and the connection pooler.

        Take note of the number of connections: if the values are high, this means some queries keep connections open for too long.

## Troubleshooting connection issues {#solving-connection-errors}

To fix issues with the number of connections:

* Increase the [`max_connections`](../../managed-postgresql/concepts/settings-list.md#setting-max-connections) value in the [DBMS settings](../../managed-postgresql/operations/update.md#change-postgresql-config).

* [Distribute free connections between users](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

* Optimize queries so that there are no long transactions.

If the load is still high or there is nothing to optimize, the only option is to [upgrade the host class](../../managed-postgresql/operations/update.md#change-resource-preset).


## Diagnosing insufficient storage space {#storage-issues}

If the cluster shows poor performance and the logs show `ERROR: cannot execute INSERT in a read-only transaction`, the cluster storage might have run out of free space and switched to [read-only mode](../../managed-postgresql/concepts/storage.md).

To check for free space in cluster storage:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}** tab.
1. Check the **Disk capacity in primary, [bytes]** chart.

    Check the value of the **Used** parameter that shows the degree of cluster storage usage.


## Troubleshooting problems with insufficient storage space {#solving-storage-issues}

For recommendations on troubleshooting these issues, see [{#T}](../../managed-postgresql/concepts/storage.md#manage-storage-space).
