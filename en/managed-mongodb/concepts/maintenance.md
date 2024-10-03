---
title: Maintenance in {{ mmg-full-name }}
description: Maintenance in {{ mmg-name }} means automatic installation of updates and fixes for your database hosts (including disabled clusters), changes to the host class and storage size, and other maintenance activities.
---

# Maintenance in {{ mmg-name }}

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Changing a major DBMS version is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

## Maintenance procedure {#maintenance-order}

The way of running the {{ mmg-name }} cluster maintenance depends on the number of hosts and whether there are any [shards](sharding.md).

### Non-sharded clusters

Maintenance is performed as follows:

1. [Secondary replicas](replication.md) undergo maintenance one by one. The hosts are queued randomly. A secondary replica becomes unavailable while being restarted during maintenance.
1. After that, the primary replica (master) undergoes maintenance. If it is restarted and becomes unavailable, one of the secondary replicas will take its role. A single-host cluster will be unavailable during its maintenance.

### Sharded cluster

In sharded clusters, maintenance is run as follows:

1. The load balancer stops.
1. The hosts with the `MONGOINFRA` role for standard sharding or `MONGOCFG` for advanced sharding undergo maintenance one by one. For hosts with the `MONGOINFRA` role, only the MongoCFG service undergoes maintenance. Host maintenance is run in the same way as it would in a non-sharded cluster:

   1. Secondary replicas undergo maintenance one by one. The hosts are queued randomly. A secondary replica becomes unavailable while being restarted during maintenance.
   1. Then, the primary replica undergoes maintenance. If it is restarted and becomes unavailable, one of the secondary replicas will take its role.

1. Shards undergo maintenance one by one, in ascending order by shard number. Host maintenance in each shard is the same as in non-sharded clusters:

   1. Secondary replicas undergo maintenance one by one. The hosts are queued randomly. A secondary replica becomes unavailable while being restarted during maintenance.
   1. Then, the primary replica undergoes maintenance. If it is restarted and becomes unavailable, one of the secondary replicas will take its role. A single-host shard will be unavailable during its maintenance.

1. The hosts with the `MONGOINFRA` role for standard sharding or `MONGOS` for advanced sharding undergo maintenance one by one. For hosts with the `MONGOINFRA` role, the MongoS service undergoes maintenance. The hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while being restarted.
1. The load balancer resumes its operation.
