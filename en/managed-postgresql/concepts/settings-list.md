# {{ PG }} settings

For {{ mpg-name }} clusters, you can configure {{ PG }} settings. Some settings are configured [at the cluster level](#dbms-cluster-settings), while others, [at the user level](#user-level-settings).

The label next to the setting name shows which interface can be used to set the value of this setting: the management console, CLI, API, or {{ TF }}. The {{ tag-all }} label means that all of the above interfaces are supported.

Depending on the selected interface, the same setting may be represented in a different way, e.g.:
- **Backend flush after** in the management console is the same as:
   - `backend_flush_after` in the gRPC API, CLI, and {{ TF }}.
   - `backendFlushAfter` in the REST API.
- **Default transaction isolation** in the user-level settings in the management console is the same as:
   - `--default-transaction-isolation` in the CLI.
   - `default_transaction_isolation` in the gRPC API.
   - `defaultTransactionIsolation` in the REST API.

## Settings dependency on the host class and storage size {#settings-instance-dependent}

The values of some {{ PG }} settings can be automatically adjusted when you change the host class or storage size:

- If the values were not specified or are not suitable for the new class or size, the default settings for this class or size will be applied.
- If the settings you specified manually are suitable for the new class or size, they will not change.

The settings that depend on the host class are:

- [Autovacuum max workers](#setting-autovacuum-max-workers).
- [Autovacuum vacuum cost delay](#setting-autovacuum-vacuum-cost-delay).
- [Autovacuum vacuum cost limit](#setting-autovacuum-vacuum-cost-limit).
- [Conn limit](#setting-conn-limit).
- [Max connections](#setting-max-connections).
- [Shared buffers](#setting-shared-buffers).

The settings that depend on the storage size are:

- [Max wal size](#setting-max-wal-size)
- [Min wal size](#setting-min-wal-size)

## Cluster-level settings {#dbms-cluster-settings}

You can use the following settings at the cluster level:

{% include [mpg-dbms-settings](../../_includes/mdb/mpg/dbms-settings.md) %}

## User-level settings {#dbms-user-settings}

These settings affect the behavior of {{ PG }} when handling user queries:

{% include [mpg-dbms-user-settings](../../_includes/mdb/mpg-dbms-user-settings.md) %}
