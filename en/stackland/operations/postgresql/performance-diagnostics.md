# {{ PG }} performance diagnostics

Performance diagnostics is a feature for collecting and visualizing performance statistics for {{ PG }} clusters. It enables analyzing SQL query performance and session activity to identify bottlenecks and streamline database operations.

## Getting started {#before-you-begin}

Make sure that:

* Managed {{ PG }} component is installed.
* Managed {{ CH }} component is installed and enabled.
* Monitoring component with Grafana is installed.
* You have permissions to modify the `ManagedPostgresConfig` configuration and create `PostgresqlCluster` clusters.

## Enabling diagnostics at the platform level {#enable-platform}

To enable performance diagnostics for all {{ PG }} clusters, run this command:

```bash
kubectl patch ManagedPostgresConfigs main --type='merge' -p='{"spec":{"settings": {"performance-diagnostics":{"enabled":true}}}}'
```

After performance diagnostics is enabled at the platform level, the system automatically deploys components for metric collection and storage ({{ CH }} and Grafana dashboards).

## Enabling statistics collection for a cluster {#enable-cluster}

After activating performance diagnostics at the platform level, enable statistics collection for each individual cluster.

To enable statistics collection for a {{ PG }} cluster:

1. Create or update the `PostgresqlCluster` specification:

   {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/enable-perfdiag-cluster.md) %}

   Where `enablePerfDiagStatsCollect: true` enables performance statistics collection for this cluster.

1. Apply the configuration:

   ```bash
   kubectl apply -f postgresql-cluster.yaml
   ```

1. Wait for the cluster pods to restart. To check their status, run this command:

   ```bash
   kubectl get pods -l postgresql=my-postgres-cluster
   ```

After the restart, a `perfdiag` sidecar container will run in each cluster pod, collecting statistics from {{ PG }} and sending them to {{ CH }}.

## Viewing data in Grafana {#view-grafana}

To view collected performance metrics:

1. Open Grafana.

1. In the left-hand menu, select **Dashboards**.

1. Find and open the **PostgreSQL Cluster Performance Diagnostics** dashboard.

1. At the top of the dashboard, select:
   * **Cluster**: Cluster name
   * **Time range**: Time range for analysis

### Dashboard panels {#dashboard-panels}

The dashboard is organized into the following sections and panels:

#### Sessions activity statistics {#sessions-stats}

**Sessions stats (for the moment of interval end)** is a table displaying active {{ PG }} sessions at the end of the selected time interval. It contains the following data:

* Collection time (`collect_time`)
* Host and host role (`host` and `host_role`)
* Database and user (`database` and `user`)
* Session state (`state`)
* Active query (`query`)
* Process ID (`pid`)
* Application and client details (`application_name`, `client_addr`, `client_hostname`, and `client_port`)
* Wait events (`wait_event_type` and `wait_event`)
* Timestamps (`backend_start`, `xact_start`, `query_start`, and `state_change`)
* Transaction IDs (`backend_xid` and `backend_xmin`)
* Backend type (`backend_type`)
* Blocking processes (`blocking_pids`)
* Query ID (`queryid`)

#### Per-statement statistics {#per-statement-stats}

This section contains time-series charts and a table with SQL query statistics.

**Time-series charts**:

* **Top queries by average execution time**, in milliseconds
* **Top queries by consumed CPU user time**, in CPU cores
* **Top queries by consumed CPU system time**, in CPU cores
* **Top queries by avg rows scanned**
* **Top queries by reads from filesystem**, in bytes
* **Top queries by writes to filesystem**, in bytes
* **Top queries by average calls per second**
* **Shared blocks read**
* **Shared blocks written**
* **Query-local blocks read**
* **Query-local blocks written**
* **Temp blocks read**
* **Temp blocks written**
* **Top queries by generated WALs**, in bytes

**Table:**

**Per-query statistics for period (sorted by avg CPU consumption)** is a pivot table of per-query statistics for the selected period, sorted by average CPU usage. It includes the following information:
  * Host role (`host_role`)
  * User and database (`user` and `database`)
  * Query ID and text (`queryid` and `query`)
  * Total number of calls (`total_calls`)
  * Total number of scanned rows (`total_rows_scanned`)
  * Total execution time (`total_exec_time`)
  * Average execution time (`average_exec_time`)
  * Total CPU time (`total_cpu_time`)
  * Average CPU time (`average_cpu_time`)
  * Total size of filesystem operations (`total_fs_bytes`)
  * Average filesystem read size (`average_fs_reads_bytes`)
  * Average filesystem write size (`average_fs_writes_bytes`)

## Performance analysis {#performance-analysis}

### Identifying slow queries {#slow-queries}

To find slow-running queries:

1. On the **Per-Statement Statistics** panel, sort queries by **Average Execution Time** or **Total Execution Time**.
1. Focus on queries with high execution times.
1. Analyze their execution plans using `EXPLAIN ANALYZE`.

### Analyzing resource usage {#resource-usage}

To identify resource-intensive queries:

1. Check the **CPU Usage** panel for queries with high CPU consumption.
1. Review the **I/O Operations** panel for queries with heavy I/O activity.
1. Examine the **WAL Generated** panel for queries producing large volumes of WAL records.

### Identifying blockers {#blocking}

To identify blocking processes:

1. In the **Sessions Activity Statistics** panel, find sessions with a non-empty `blocking_pids` field.
1. Identify which queries are causing the block.
1. Optimize transaction logic or add appropriate indexes.

## Disabling diagnostics {#disable}

To disable statistics collection for a cluster, run this command:

```
kubectl patch ManagedPostgresConfigs main --type='merge' -p='{"spec":{"settings": {"performance-diagnostics":{"enabled":false}}}}'
```

{% note warning %}

Disabling the feature at the platform level will delete all collected metrics from {{ CH }}.

{% endnote %}

## See also {#see-also}

* [{#T}](../../concepts/components/postgresql.md)
* [{#T}](create-cluster.md)
* [{#T}](../../concepts/components/monitoring.md)
