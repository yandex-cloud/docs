---
title: Maintenance in {{ mch-full-name }}
description: In {{ mch-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mch-name }}

Maintenance in {{ mch-name }} includes:

* Automatic installation of DBMS updates and patches for hosts (including for stopped clusters).
* Scheduled [automatic storage expansion](./storage.md#auto-rescale).
* Other maintenance activities.

A major DBMS version update is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/cluster-maintenance.md#set-maintenance-window):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

## Maintenance workflow {#maintenance-order}

The maintenance workflow for {{ mch-name }} clusters depends on the number of [shards](sharding.md) and hosts in them:

* In single-host clusters, maintenance is performed on a single {{ CH }} host. This means, if you restart such a cluster during maintenance, it will become unavailable.
* If a cluster consists of multiple {{ CH }} hosts in a single shard, [replica hosts](replication.md) undergo maintenance one by one. Such hosts are queued randomly. If you restart a host during maintenance, it will become unavailable for this time period. If you access a cluster using the [FQDN of the {{ CH }} host](network.md#hostname), the cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect/fqdn.md#auto) always pointing to the available host.
* If a cluster consists of multiple shards, maintenance is performed shard by shard in ascending order by shard number. Maintenance is first performed on hosts of one shard, then two shards, four, and so on, up to ten. Host maintenance is the same as in single-shard clusters. If you access a cluster shard using the FQDN of the {{ CH }} host, the shard may become unavailable. To make your application continuously available, access the shard using a [special FQDN](../operations/connect/fqdn.md#auto), always pointing to the available host in the shard.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
