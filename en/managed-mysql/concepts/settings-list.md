# {{ MY }} settings

For {{ mmy-name }} clusters, you can configure settings that relate to {{ MY }}. Some settings are configured [at the cluster level](#dbms-cluster-settings) and some [at the user level](#dbms-user-settings).

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}, or {{ TF }}. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented differently. For example, **Innodb buffer pool size** in the management console matches:
- `innodb_buffer_pool_size` in gRPC, CLI, or {{ TF }}.
- `innodbBufferPoolSize` in the REST API.

## Settings dependency on the host class {#settings-instance-dependent}

Values of some {{ MY }} settings can be automatically adjusted when you change the host class:

- If the values weren't set or aren't suitable for the new class, the default settings for this class are applied.
- If the manually set settings are suitable for the new class, they don't change.

List of settings that depend on the host class:

- [Innodb buffer pool size](#setting-buffer-pool-size).
- [Max connections](#setting-max-connections).
- [Thread cache size](#setting-thread-cache-size).

## Cluster-level DBMS settings {#dbms-cluster-settings}

{% include [mmy-dbms-settings](../../_includes/mdb/mmy-dbms-settings.md) %}

## Custom settings {#dbms-user-settings}

These settings apply at the individual user level.

{% include [mmy-dbms-user-settings](../../_includes/mdb/mmy-dbms-user-settings.md) %}

For information about managing user permissions to access DB objects, see [{#T}](user-rights.md).
