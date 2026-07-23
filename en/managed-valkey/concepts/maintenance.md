---
title: Maintenance in {{ mrd-full-name }}
description: In {{ mrd-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mrd-name }}

Maintenance includes:

* Automatic installation of DBMS updates and patches for hosts (including for stopped clusters).
* Scheduled [automatic storage expansion](storage.md#auto-rescale).
* Other maintenance activities.

A major DBMS version update is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set your preferred maintenance start time using the {{ yandex-cloud }} interfaces ([management console]({{ link-console-main }}), [CLI](../../cli/index.yaml), {{ TF }}, and API) when [creating](../operations/cluster-create.md) or [updating a cluster](../operations/update.md#change-additional-settings):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start maintenance in the interval from `00:00` to `01:00`, put `1`; from `04:00` to `05:00`, `5`.

{% note info %}

To view maintenance task information, you need the `managed-redis.maintenanceTask.viewer` [role](../security/index.md#managed-redis-maintenanceTask-viewer) or higher.

To manage maintenance tasks, you need the `managed-redis.maintenanceTask.editor` [role](../security/index.md#managed-redis-maintenanceTask-editor) or higher.

{% endnote %}

## Maintenance workflow {#maintenance-order}

The {{ mrd-name }} cluster maintenance workflow depends on the number of hosts and [sharding](sharding.md).

### Non-sharded cluster

The maintenance procedure is as follows:

1. [Replica hosts](replication.md) undergo maintenance one by one. Such hosts are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Maintenance is performed on a master host. If the master host needs to restart and becomes unavailable, one of the replicas will assume its role. A single-host cluster will be unavailable during its maintenance.

### Sharded cluster

In sharded clusters, maintenance is performed shard by shard in ascending order by shard number. Host maintenance in each shard is the same as in non-sharded clusters:

1. Replica hosts undergo maintenance one by one. Such hosts are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Maintenance is performed on a master host. If the master host needs to restart and becomes unavailable, one of the replicas will assume its role. A single-host shard will be unavailable during its maintenance.

## How maintenance impacts a cluster {#impact-on-cluster}

{% include [impact-on-cluster](../../_includes/impact-on-cluster.md) %}