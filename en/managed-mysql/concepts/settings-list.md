# {{ MY }} settings

For {{ mmy-name }} clusters, you can configure {{ MY }} settings. Some settings are configured [at the cluster level](#dbms-cluster-settings), while others, [at the user level](#dbms-user-settings).

The label next to the setting name shows which interface can be used to set the value of this setting: the management console, CLI, API, or {{ TF }}. The {{ tag-all }} label means that all of the above interfaces are supported.

Depending on the selected interface, the same setting may be represented in a different way. For example, **Innodb buffer pool size** in the management console matches:
- `innodb_buffer_pool_size` in gRPC, CLI, or {{ TF }}.
- `innodbBufferPoolSize` in the REST API.

## How settings depend on the host class {#settings-instance-dependent}

The values of some {{ MY }} settings can be automatically adjusted when you change the host class:

- If the values were not specified or are not suitable for the new class, the default settings for this class will be applied.
- If the settings you specified manually are suitable for the new class, they will not change.

The settings that depend on the host class are:

- [Innodb buffer pool size](#setting-buffer-pool-size).
- [Max connections](#setting-max-connections).
- [Thread cache size](#setting-thread-cache-size).

## Cluster-level DBMS settings {#dbms-cluster-settings}

{% include [mmy-dbms-settings](../../_includes/mdb/mmy-dbms-settings.md) %}

## Custom settings {#dbms-user-settings}

These settings apply at the individual user level.

{% include [mmy-dbms-user-settings](../../_includes/mdb/mmy-dbms-user-settings.md) %}

For information about managing user permissions to access DB objects, see [{#T}](user-rights.md).
