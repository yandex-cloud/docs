---
title: "Maintenance in {{ mch-name }}"
description: "Maintenance in {{ mch-name }} means automatic installation of ClickHouse updates and fixes for your database hosts (including disabled clusters), changes to the host class and storage size, and other maintenance activities."
---

# Maintenance in {{ mch-name }}

Maintenance in {{ mch-name }} means:

* Automatic installation of ClickHouse updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Changing a major DBMS version is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

* **Unspecified time** (default): Maintenance can be performed at any time.
* **On schedule**: Set the preferred maintenance start time, i.e., the day and time (UTC) you want to perform maintenance at. For example, you can choose a time when the cluster is least loaded.

## Maintenance procedure {#maintenance-order}

Maintenance procedure for {{ mch-name }} clusters depends on the number of [shards](sharding.md) and hosts in the shards:

* In single-host clusters, maintenance is performed on a single {{ CH }} host. This means, if a cluster needs to be restarted during maintenance, it will become unavailable.
* If a cluster consists of a few {{ CH }} hosts in a single shard, [host replicas](replication.md) undergo maintenance one by one. The hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while it is being restarted. If you access the cluster using the FQDN or IP address of the {{ CH }} host, such a cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#auto) always pointing to the available host.
* If a cluster consists of multiple shards, maintenance is performed shard by shard in ascending order by shard number. Maintenance is first performed on hosts of one shard, then two shards, four, and so on, up to ten. Host maintenance is the same as in clusters with a single shard. If you access the cluster shard using the FQDN or IP address of the {{ CH }} host, such a shard may become unavailable. To make your application continuously available, access the shard using a [special FQDN](../operations/connect.md#auto), always pointing to the available host in a shard.
