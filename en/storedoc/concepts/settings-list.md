# {{ SD }} settings

When [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-mongod-config) a {{ mmg-name }} cluster, you can specify settings that pertain to {{ SD }}.

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, or API.

The name of a setting depends on the interface you use. For example, **Max incoming connections** in the management console is the same as:

* `max_incoming_connections` in gRPC or the CLI
* `maxIncomingConnections` in the REST API


In a sharded cluster, some settings are only available to certain [host roles](sharding.md#shard-management).

## How settings depend on the host class {#settings-instance-dependent}

Some {{ SD }} setting values may be automatically changed as you edit the host class:

* If no values are set or the values are not compatible with the new class, the defaults for this class will apply.
* If the settings you specify manually are compatible with the new class, they will not be changed.

The settings that depend on the host class are:

* [Net → Max incoming connections](#setting-max-incoming-connections).
* [Engine config → Cache size gb](#setting-engine-cache-size-gb).

## Cluster-level DBMS settings {#dbms-cluster-settings}

{% include [mmg-dbms-settings](../../_includes/mdb/mmg-dbms-settings.md) %}
