# Managed PostgreSQL

Managed PostgreSQL is a managed solution for operating PostgreSQL, an open-source object-relational DBMS. It simplifies database cluster deployment and upgrades, ensures fault tolerance, and provides tools for backup and monitoring.

With Managed PostgreSQL, you can:

* Create and recover clusters using the `PostgresqlCluster` custom resource.
* Create one-time backups using the `PostgresqlBackup` custom resource.

You can manage PostgreSQL integration through the `ManagedPostgresConfig` custom resource settings.

## Configuration {#configuration}

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/managedpostgresqlconfig.md) %}

Where:

* `enabled`: Enables/disables the component.
* `settings.stackland-postgres`: Operator pod settings:
  * `replicas`: Number of operator replicas.
  * `resources`: Resource requests and limits for the operator pod.
* `settings.stackland-wal-g`: WAL-G sidecar resources (backups/restores): `resources` with `requests` and `limits`.
* `settings.monitoring`: Monitoring, `enabled: true/false`. It is enabled by default if you skip this section.
* `settings.performance-diagnostics`: Performance diagnostics, `enabled: true/false`.
* `settings.defaultPostgresResources`: Default resources (requests/limits) for PostgreSQL instances in clusters.
* `settings.defaultPoolerResources`: Default resources for Pooler (PgBouncer) instances.

All `settings` sections are optional; you can specify only those you need.

## Performance diagnostics {#performance-diagnostics}

Performance diagnostics is a feature for collecting and visualizing performance statistics of PostgreSQL clusters. It enables analyzing SQL query performance and session activity to identify bottlenecks and streamline database operations.

The performance diagnostics system features the following components:

* **perfdiag sidecar**: Sidecar container that collects statistics from {{ PG }}.
* **{{ CH }}**: Long-term storage for performance metrics.
* **Grafana Dashboard**: Preconfigured _PostgreSQL Cluster Performance Diagnostics_ dashboard for visualizing collected data.

### Collected metrics {#collected-metrics}

Performance diagnostics collects the following types of metrics:

Session activity statistics:

* Current session state (`state`, `query`, `pid`, `user`, and `application_name`).
* Wait events (`wait_event` and `wait_event_type`).
* Blocking processes (`blocking_pids`).

Query execution statistics:

* Execution time (average and total).
* CPU usage (`user time` and `system time`).
* I/O operations (file system reads and writes, shared, local, and temp block activity).
* Number of rows processed.
* Amount of WAL records generated.
* Number of query calls.

### Enabling Performance Diagnostics {#enabling}

To use performance diagnostics, you need to:

1. Enable this feature at the platform level in the `ManagedPostgresConfig` configuration:

   ```yaml
   spec:
     settings:
       performance-diagnostics:
         enabled: true
   ```

1. Enable statistics collection for a specific cluster in `PostgresqlCluster`:

   ```yaml
   spec:
     enablePerfDiagStatsCollect: true
   ```

For more information, see [{#T}](../../operations/postgresql/performance-diagnostics.md).
