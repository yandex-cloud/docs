---
title: "Maintenance in {{ mrd-full-name }}"
description: "Maintenance in {{ mrd-name }} means automatic installation of updates and fixes for your database hosts (including disabled clusters), changes to the host class and storage size, and other maintenance activities."
---

# Maintenance in {{ mrd-name }}

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Changing a major DBMS version is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

## Maintenance procedure {#maintenance-order}

The way of running the {{ mrd-name }} cluster maintenance depends on the number of hosts and whether there are any [shards](sharding.md).

### Non-sharded clusters

Maintenance is performed as follows:

1. [Replica hosts](replication.md) undergo maintenance one by one. The hosts are queued randomly. A replica becomes temporarily unavailable if it needs to be restarted during maintenance.
1. Maintenance is performed on a master host. If it is restarted and becomes unavailable, one of the replicas takes its role. A single-host cluster will be unavailable during its maintenance.

### Sharded cluster

In sharded clusters, maintenance is performed shard by shard in ascending order by shard number. Host maintenance in each shard is the same as in non-sharded clusters:

1. Replica hosts undergo maintenance one by one. The hosts are queued randomly. A replica becomes temporarily unavailable if it needs to be restarted during maintenance.
1. Maintenance is performed on a master host. If it is restarted and becomes unavailable, one of the replicas takes its role. A single-host shard will be unavailable during its maintenance.
