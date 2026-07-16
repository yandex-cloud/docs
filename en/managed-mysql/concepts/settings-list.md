# {{ MY }} settings

For a {{ mmy-name }} cluster, you can set {{ MY }} settings. Some settings are configured [at the cluster level](#dbms-cluster-settings), while others, [at the user level](#dbms-user-settings).

The label next to the setting name shows which interface can be used to configure this setting: the management console, CLI, API, or {{ TF }}. The {{ tag-all }} label means you can use any of the above interfaces.

The name for a setting depends on the interface you use. For example, **Innodb buffer pool size** in the management console matches:
- `innodb_buffer_pool_size` in gRPC, the CLI, or {{ TF }}.
- `innodbBufferPoolSize` in the REST API.

## How settings depend on the host class {#settings-instance-dependent}

Some {{ MY }} setting values may be automatically changed as you edit the host class:

- If no values are set or the values are not compatible with the new class, the defaults for this class will apply.
- If the settings you specify manually are compatible with the new class, they will not be changed.

The settings that depend on the host class are:

- [Innodb buffer pool size](#setting-buffer-pool-size).
- [Max connections](#setting-max-connections).
- [Thread cache size](#setting-thread-cache-size).

## Cluster-level DBMS settings {#dbms-cluster-settings}

{% include [mmy-dbms-settings](../../_includes/mdb/mmy-dbms-settings.md) %}

## Custom settings {#dbms-user-settings}

These settings apply at the individual user level.

{% include [mmy-dbms-user-settings](../../_includes/mdb/mmy-dbms-user-settings.md) %}

For information about managing user permissions to access database objects, see [{#T}](user-rights.md).
