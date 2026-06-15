---
title: Maintenance in {{ mpg-full-name }}
description: In {{ mpg-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mpg-name }}

Maintenance in {{ mpg-name }} includes:

* Installing minor updates and security fixes for the DBMS and/or connection pooler.
* Updating the host OS and other underlying software.
* Scheduled [automatic storage expansion](./storage.md#auto-rescale).
* Other maintenance activities.

A major DBMS version update is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set your preferred maintenance start time using the {{ yandex-cloud }} interfaces ([management console]({{ link-console-main }}), [CLI](../../cli/index.yaml), {{ TF }}, and API) when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-maintenance.md#set-maintenance-window) a cluster:

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start a maintenance session from `00:00` to `01:00`, enter `1`; from `04:00` to `05:00`, `5`.

{% note info %}

To view maintenance task information, you need the `managed-postgresql.maintenanceTask.viewer` [role](../security/index.md#managed-postgresql-maintenanceTask-viewer) or higher.

To manage maintenance tasks, you need the `managed-postgresql.maintenanceTask.editor` [role](../security/index.md#managed-postgresql-maintenanceTask-editor) or higher.

{% endnote %}

## Maintenance workflow {#maintenance-order}

In {{ mpg-name }} single-host clusters, a master host undergoes maintenance. Therefore, it may become unavailable in case it is restarted.

In multi-host clusters, the maintenance is run as follows:

1. [Replica hosts](replication.md) undergo maintenance one by one. The replicas are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Master host undergoes maintenance and gets updated. If the master host needs to restart and becomes unavailable, one of the replicas will assume its role.

    If you access a cluster using the [FQDN of the master host](../operations/connect/fqdn.md), the cluster may become unavailable. To ensure uninterrupted operation of your application, list all the hosts and specify `target_session_attrs` when connecting to the cluster. [Read more](../operations/connect/fqdn.md#automatic-master-host-selection).

## How maintenance impacts a cluster {#impact-on-cluster}

Depending on its type, maintenance can impact your cluster as follows:

* Show little to no impact on database users.
* Break database connections in place, forcing clients to re-establish their connections.
* Make your cluster read-only for a while.
* Make your cluster completely unavailable for a while due to a reboot.
* Cause master host failover in the cluster, making the database read-only for a while.