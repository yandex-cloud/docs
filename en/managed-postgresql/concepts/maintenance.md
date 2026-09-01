---
title: Maintenance in {{ mpg-full-name }}
description: In {{ mpg-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mpg-name }}

Maintenance in {{ mpg-name }} includes:

* Installing minor updates and security fixes for the DBMS and/or connection pooler.
* Updating the host OS and other underlying software.
* Scheduled [automatic storage expansion](./storage.md#auto-rescale).
* Forced DBMS version upgrade.
* Other maintenance activities.

For more information on self-managed major version upgrades, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set your preferred maintenance start time using the {{ yandex-cloud }} interfaces ([management console]({{ link-console-main }}), [CLI](../../cli/index.yaml), {{ TF }}, and API) when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-maintenance.md#set-maintenance-window) a cluster:

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start maintenance in the interval from `00:00` to `01:00`, put `1`; from `04:00` to `05:00`, `5`.

{{ mpg-name }} sends email notifications for upcoming maintenance. We recommend setting up monitoring of incoming messages from {{ yandex-cloud }}. You can always [reschedule maintenance](../operations/cluster-maintenance.md#postpone-planned-maintenance) to a more convenient time, if required. 
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

More information on operations during maintenance:

| Operation | Trigger | Process | Impact on application |
| :--- | :--- | :--- | :--- |
| Restart | {{ PG }} minor updates, system library updates | Each cluster node stops and starts in turn. The {{ PG }} process restarts on each node. | There is a brief connection drop on each host while the {{ PG }} process stops and restarts. It may last from a few seconds to several minutes depending on the load. To minimize downtime, a checkpoint runs right before the restart. Incomplete write operations will be aborted. |
| Master switchover | Updates that require a server reboot | Each cluster node stops and reboots in turn. If the current master reboots, a replica is promoted to the new master. | Connections are terminated. Switchover is faster than a full server reboot. Your application must be able to handle a brief read-only state and search for a master. |
| Forced version upgrade | Major upgrades of clusters on unsupported versions | The master stops, updates, and stays offline. Replicas are switched off and updated one by one. Updated replicas restart in read-only mode. The master turns back on after all replicas update. | Connections are terminated during the installation of updates. We recommend that you plan a manual cluster version [upgrade](../operations/cluster-version-update.md) before it reaches end-of-life. |

## How maintenance impacts a cluster {#impact-on-cluster}

{% include [impact-on-cluster](../../_includes/impact-on-cluster.md) %}


