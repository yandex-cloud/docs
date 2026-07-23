---
title: Maintenance in {{ mmg-full-name }}
description: In {{ mmg-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mmg-name }}

Maintenance includes:

* Automatic installation of DBMS updates and patches for hosts (including for stopped clusters).
* Scheduled [automatic storage expansion](./storage.md#auto-rescale).
* Other maintenance activities.

A major DBMS version update is not part of maintenance. For more information about migrating between versions, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set your preferred maintenance start time using the {{ yandex-cloud }} interfaces ([management console]({{ link-console-main }}), [CLI](../../cli/index.yaml), {{ TF }}, and API) when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md#change-additional-settings):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start maintenance in the interval from `00:00` to `01:00`, put `1`; from `04:00` to `05:00`, `5`.

{% note info %}

To view maintenance task information, you need the `managed-mongodb.maintenanceTask.viewer` [role](../security/index.md#managed-mongodb-maintenanceTask-viewer) or higher.

To manage maintenance tasks, you need the `managed-mongodb.maintenanceTask.editor` [role](../security/index.md#managed-mongodb-maintenanceTask-editor) or higher.

{% endnote %}

## Maintenance workflow {#maintenance-order}

The {{ mmg-name }} cluster maintenance workflow depends on the number of hosts and [sharding](sharding.md).

### Non-sharded cluster

The maintenance procedure is as follows:

1. [Secondary replicas](replication.md) undergo maintenance one by one. Such hosts are queued randomly. A secondary replica becomes unavailable while being restarted during maintenance.
1. After that, the primary replica (master) undergoes maintenance. If it is restarted and becomes unavailable, one of the secondary replicas will take its role. A single-host cluster will be unavailable during its maintenance.

### Sharded cluster

In sharded clusters, the maintenance procedure is as follows:

1. The load balancer stops.
1. Hosts with the `MONGOINFRA` role for standard sharding or `MONGOCFG` for advanced sharding undergo maintenance one by one. For hosts with the `MONGOINFRA` role, only MongoCFG is subject to maintenance. Host maintenance is run in the same way as it would in a non-sharded cluster:

    1. Secondary replicas undergo maintenance one by one. Such hosts are queued randomly. A secondary replica becomes unavailable while being restarted during maintenance.
    1. Then, the primary replica undergoes maintenance. If it is restarted and becomes unavailable, one of the secondary replicas will take its role.

1. Shards undergo maintenance one by one, in ascending order by shard number. Host maintenance in each shard is the same as in non-sharded clusters:

    1. Secondary replicas undergo maintenance one by one. Such hosts are queued randomly. A secondary replica becomes unavailable while being restarted during maintenance.
    1. Then, the primary replica undergoes maintenance. If it is restarted and becomes unavailable, one of the secondary replicas will take its role. A single-host shard will be unavailable during its maintenance.

1. Hosts with the `MONGOINFRA` role for standard sharding or `MONGOS` for advanced sharding undergo maintenance one by one. For hosts with the `MONGOINFRA` role, MongoS is subject to maintenance. Such hosts are queued randomly. Any host that requires a restart during maintenance will be unavailable until maintenance is complete.
1. The load balancer resumes its operation.
