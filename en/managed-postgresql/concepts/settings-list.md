# {{ PG }} settings

For {{ mpg-name }} clusters, you can configure settings that relate to {{ PG }}. Some settings are configured [at the cluster level](#dbms-cluster-settings) and some [at the user level](#user-level-settings).

The label next to the setting name lets you determine which interface is used to set the value of this setting: the management console, CLI, API, SQL, or {{ TF }}. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented in a different way, for example:
- **Backend flush after** in the management console corresponds to:
   - `backend_flush_after` in the gRPC API, CLI, {{ TF }}, and SQL.
   - `backendFlushAfter` in the REST API.
- **Default transaction isolation** in the user-level settings in the management console corresponds to:
   - `--default-transaction-isolation` in the CLI.
   - `default_transaction_isolation` in the gRPC API.
   - `defaultTransactionIsolation` in the REST API.

## Settings dependency on the host class and storage size {#settings-instance-dependent}

Values of some {{ PG }} settings can be automatically adjusted when you change the host class or storage size:

- If the values weren't set or aren't suitable for the new class/size, the default settings for this class/size are applied.
- If the manually set settings are suitable for the new class/size, they don't change.

List of settings that depend on the host class:

- [Autovacuum max workers](#setting-autovacuum-max-workers).
- [Autovacuum vacuum cost delay](#setting-autovacuum-vacuum-cost-delay).
- [Autovacuum vacuum cost limit](#setting-autovacuum-vacuum-cost-limit).
- [Conn limit](#setting-conn-limit).
- [Max connections](#setting-max-connections).
- [Shared buffers](#setting-shared-buffers)

List of settings that depend on the storage size:

- [Max wal size](#setting-max-wal-size)
- [Min wal size](#setting-min-wal-size)

## Cluster-level settings {#dbms-cluster-settings}

You can use the following settings:

{% include [mpg-dbms-settings](../../_includes/mdb/mpg/dbms-settings.md) %}

## User-level settings {#dbms-user-settings}

These settings affect the behavior of {{ PG }} when handling user queries.

{% include [mpg-dbms-user-settings](../../_includes/mdb/mpg-dbms-user-settings.md) %}
