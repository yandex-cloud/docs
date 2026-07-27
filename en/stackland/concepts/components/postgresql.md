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

* `enabled`: Enables and disables the component.
* `settings.stackland-postgres`: Operator pod settings:
  * `replicas`: Number of operator replicas.
  * `resources`: Resource requests and limits for the operator pod.
* `settings.stackland-wal-g`: WAL-G sidecar resources (backups/restores): `resources` with `requests` and `limits`.
* `settings.monitoring`: Monitoring, `enabled: true/false`. It is enabled by default if you skip this section.
* `settings.performance-diagnostics`: Performance diagnostics, `enabled: true/false`.
* `settings.defaultPostgresResources`: Default resources (requests/limits) for PostgreSQL instances in clusters.
* `settings.defaultPoolerResources`: Default resources for Pooler (PgBouncer) instances.

All `settings` sections are optional; you can specify only those you need.

## Users and databases {#users-and-databases}

In Managed PostgreSQL, you can manage cluster users and databases in a declarative way using custom Kubernetes resources:

* `PostgresqlRole`: PostgreSQL role and its permissions. For more information, see [{#T}](../../operations/postgresql/create-user.md), [{#T}](../../operations/postgresql/edit-user.md), and [{#T}](../../operations/postgresql/delete-user.md).
* `PostgresqlDatabase`: Database and its schemas. For more information, see [{#T}](../../operations/postgresql/create-database.md), [{#T}](../../operations/postgresql/edit-database.md), and [{#T}](../../operations/postgresql/delete-database.md).

Both resources belong to the `postgresql.stackland.yandex.cloud/v1alpha1` group and are associated with the cluster via the `spec.cluster` field.

### User authentication {#authentication}

The user's password is stored in a Kubernetes Secret. There are two possible options:

* If the `spec.authentication` section in the `PostgresqlRole` resource is not set, the operator automatically creates a Secret of the same name as the `PostgresqlRole` resource and writes the generated password to that Secret.
* If `spec.authentication.secretName` specifies a name of an existing Secret and the `password` authentication type, the operator uses credentials from that Secret. The Secret must contain the `username` key with the username and the `password` key with the password.

To change the password, update the `password` key value in the associated Secret.

### Immutable database fields {#immutable-database-fields}

Once the database is created, you cannot change the following fields:

* `name`: Name of the PostgreSQL database.
* `template`: Template used to create the database.
* `encoding`: Character encoding.
* `localeProvider`, `locale`, `localeCollate`, `localeCType`, `icuLocale`, `icuRules`, `builtinLocale`: Locale provider and settings.
* `collationVersion`: Collation version.

### Schemas {#schemas}

The `spec.schemas` list of the `PostgresqlDatabase` resource describes managed PostgreSQL schemas. Each element has a `state` field set to `present` to create or support, or `absent`, to delete. The operator writes the current state to `status.schemas`.

### Resource status {#status}

* `PostgresqlRole.status.ready`: `true` if the role was successfully applied in the cluster.
* `PostgresqlDatabase.status.applied`: `true` if the database was successfully applied in the cluster.
* `status.conditions`: Standard Kubernetes conditions (`type`, `status`, `reason`, `message`, and `lastTransitionTime`) describing the resource reconciliation progress.

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
