---
title: Maintenance in {{ mrd-full-name }}
description: In {{ mrd-name }}, maintenance includes automatic installation of DBMS updates and patches for hosts (including for stopped clusters), changing the host class and storage size, and other maintenance activities.
---

# Maintenance in {{ mrd-name }}

Maintenance includes:

* Automatic installation of DBMS updates and patches for hosts (including for stopped clusters).
* Scheduled [automatic storage expansion](storage.md#auto-rescale).
* Other maintenance activities.

A major DBMS version update is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

## Maintenance workflow {#maintenance-order}

The {{ mrd-name }} cluster maintenance workflow depends on the number of hosts and [sharding](sharding.md).

### Non-sharded cluster

The maintenance procedure is as follows:

1. [Replica hosts](replication.md) undergo maintenance one by one. Such hosts are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Maintenance is performed on a master host. If the master host needs restarting and becomes unavailable, one of the replicas will assume its role. A single-host cluster will be unavailable during its maintenance.

### Sharded cluster

In sharded clusters, maintenance is performed shard by shard in ascending order by shard number. Host maintenance in each shard is the same as in non-sharded clusters:

1. Replica hosts undergo maintenance one by one. Such hosts are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Maintenance is performed on a master host. If the master host needs to restart and becomes unavailable, one of the replicas will assume its role. A single-host shard will be unavailable during its maintenance.
