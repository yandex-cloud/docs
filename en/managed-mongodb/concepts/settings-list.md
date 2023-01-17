# {{ MG }} settings

When [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-mongod-config) a {{ mmg-name }} cluster, you can specify settings that pertain to {{ MG }}.

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}, or {{ TF }}. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented differently. For example, **Max incoming connections** in the management console matches:

* `max_incoming_connections` in gRPC, CLI, or {{ TF }}.
* `maxIncomingConnections` in the REST API.

The following settings are only available for the {{ mmg-name }} cluster Enterprise version.

* [Audit log](#setting-audit-log).
* [Security](#setting-security).

In a sharded cluster, some settings are only available to certain [host roles](sharding.md#shard-management).

## Settings dependency on the host class {#settings-instance-dependent}

Values of some {{ MG }} settings can be automatically adjusted when you change the host class:

* If the values weren't set or aren't suitable for the new class, the default settings for this class are applied.
* If the manually set settings are suitable for the new class, they don't change.

List of settings that depend on the host class:

* [Net → Max incoming connections](#setting-max-incoming-connections).
* [Engine config → Cache size gb](#setting-engine-cache-size).

## Cluster-level DBMS settings {#dbms-cluster-settings}

{% include [mmg-dbms-settings](../../_includes/mdb/mmg-dbms-settings.md) %}
