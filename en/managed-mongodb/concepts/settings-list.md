# {{ MG }} settings

When [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-mongod-config) a {{ mmg-name }} cluster, you can specify settings that pertain to {{ MG }}.

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, or API.

Depending on the selected interface, the same setting may be represented in a different way. For example, **Max incoming connections** in the management console is:

* `max_incoming_connections` in gRPC or CLI.
* `maxIncomingConnections` in the REST API.

The following settings are only available for the {{ mmg-name }} cluster Enterprise edition.

* [Audit log](#setting-audit-log).
* [Security](#setting-security).

In a sharded cluster, some settings are only available to certain [host roles](sharding.md#shard-management).

## Settings dependency on the host class {#settings-instance-dependent}

The values of some {{ MG }} settings can be automatically adjusted when you change the host class:

* If the values were not specified or are not suitable for the new class, the default settings for this class will be applied.
* If the settings you specified manually are suitable for the new class, they will not change.

The settings that depend on the host class are:

* [Net → Max incoming connections](#setting-max-incoming-connections).
* [Engine config → Cache size gb](#setting-engine-cache-size).

## Cluster-level DBMS settings {#dbms-cluster-settings}

{% include [mmg-dbms-settings](../../_includes/mdb/mmg-dbms-settings.md) %}
