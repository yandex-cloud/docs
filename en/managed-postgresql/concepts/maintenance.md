---
title: Maintenance in {{ mpg-full-name }}
description: In {{ mpg-name }}, maintenance means automatic installation of updates and patches for DBMS hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mpg-name }}

Maintenance in {{ mpg-name }} includes:

* Automatic installation of DBMS updates and patches for hosts (including for stopped clusters).
* Scheduled [automatic storage expansion](./storage.md#auto-rescale).
* Other maintenance activities.

A major DBMS version update is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/cluster-maintenance.md#set-maintenance-window):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

{% note info %}

Viewing information on maintenance tasks requires the `managed-postgresql.maintenanceTask.viewer` [role](../security/index.md#managed-postgresql-maintenanceTask-viewer) or higher.

Managing maintenance tasks requires the `managed-postgresql.maintenanceTask.editor` [role](../security/index.md#managed-postgresql-maintenanceTask-editor) or higher.

{% endnote %}

## Maintenance workflow {#maintenance-order}

In {{ mpg-name }} single-host clusters, a master host undergoes maintenance. Therefore, it may become unavailable in case it is restarted.

In multi-host clusters, the maintenance is run as follows:

1. [Replica hosts](replication.md) undergo maintenance one by one. The replicas are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Master host undergoes maintenance and gets updated. If the master host needs to restart and becomes unavailable, one of the replicas will assume its role.

    If you access a cluster using the [FQDN of the master host](../operations/connect/fqdn.md), the cluster may become unavailable. To make your application continuously available, access the cluster using a [specific FQDN](../operations/connect/fqdn.md#fqdn-master) that always points to the master host.
