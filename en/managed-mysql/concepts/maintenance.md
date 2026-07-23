---
title: Maintenance in {{ mmy-full-name }}
description: In {{ mmy-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mmy-name }}

Maintenance in {{ mmy-name }} includes:

* Automatic installation of DBMS updates and patches for hosts (including for stopped clusters).
* Other maintenance activities.

Changing a DBMS version is not part of maintenance. For more information about migrating between versions, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start maintenance in the interval from `00:00` to `01:00`, put `1`; from `04:00` to `05:00`, `5`.

{% note info %}

To view maintenance task information, you need the `managed-mysql.maintenanceTask.viewer` [role](../security/index.md#managed-mysql-maintenanceTask-viewer) or higher.

To manage maintenance tasks, you need the `managed-mysql.maintenanceTask.editor` [role](../security/index.md#managed-mysql-maintenanceTask-editor) or higher.

{% endnote %}

## Maintenance workflow {#maintenance-order}

In {{ mmy-name }} single-host clusters, a master host undergoes maintenance. Therefore, it may become unavailable in case it is restarted.

In multi-host clusters, the maintenance is run as follows:

1. [Replicas](replication.md) undergo maintenance one by one. The replicas are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Master host undergoes maintenance and gets updated. If the master host needs to restart and becomes unavailable, one of the replicas will assume its role. Once the upgrade is complete, the host with the highest [failover priority](../concepts/replication.md#master-failover) will become the new master. In a cluster with several hosts of maximum priority, the one with the least lag behind the master will be selected.

    {% include [note-role-master](../../_includes/mdb/mmy/note-role-master.md) %}

    If you access a cluster using the [FQDN of the master host](../operations/connect/fqdn.md), the cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect/fqdn.md#special-fqdns) that always points to the current master host.

## How maintenance impacts a cluster {#impact-on-cluster}

{% include [impact-on-cluster](../../_includes/impact-on-cluster.md) %}