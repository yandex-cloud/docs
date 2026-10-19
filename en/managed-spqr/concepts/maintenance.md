---
title: Maintenance in {{ mspqr-full-name }}
description: In {{ mspqr-full-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mspqr-name }}

Maintenance in {{ mspqr-name }} includes:

* Installing minor updates and security fixes for the DBMS and/or connection pooler.
* Updating the host OS and other underlying software.
* Forced DBMS version upgrade.
* Other maintenance activities.

## Maintenance window {#maintenance-window}

You can set your preferred maintenance start time using the {{ yandex-cloud }} interfaces ([management console]({{ link-console-main }}), [CLI](../../cli/index.yaml), {{ TF }}, and API) when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md) a cluster:

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start maintenance in the interval from `00:00` to `01:00`, put `1`; from `04:00` to `05:00`, `5`.

{% note info %}

To view maintenance task information, you need the `managed-spqr.maintenanceTask.viewer` [role](../security.md#managed-spqr-maintenanceTask-viewer) or higher.

To manage maintenance tasks, you need the `managed-spqr.maintenanceTask.editor` [role](../security.md#managed-spqr-maintenanceTask-editor) or higher.

{% endnote %}

## Maintenance workflow {#maintenance-order}

In {{ mspqr-name }} single-host clusters, the master host is subject to maintenance. Therefore, if maintenance requires restarting the master, such a cluster will go unavailable.

In multi-host clusters, maintenance follows this procedure:

1. Replica hosts undergo maintenance one by one. The replicas are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Master host undergoes maintenance and gets updated. If the master host needs to restart and becomes unavailable, one of the replicas will assume its role.

   If you access a cluster using the FQDN of the master host, the cluster may become unavailable. To ensure uninterrupted operation of your application, list all the hosts and specify `target_session_attrs` when connecting to the cluster.

During maintenance, the **Restart** operation is available. It is applied during {{ SPQR }} minor updates or system library updates. This operation stops and starts each cluster node in turn. The {{ SPQR }} process restarts on each node. 

A restart implies a brief connection drop on all hosts while the {{ SPQR }} process stops and starts. It may last from a few seconds to several minutes depending on the load. To minimize downtime, a checkpoint is created immediately prior to the restart. Incomplete write operations will be aborted.

## How maintenance impacts a cluster {#impact-on-cluster}

Depending on its type and scope, maintenance can affect the cluster in different ways: it may have no or minimum impact on database users, or cause existing database connections to be dropped. In the latter case, clients must re-establish their connections.

Maintenance tasks have an estimated duration and completion date. These time frames are calculated based on historical data from similar operations. The actual completion times may vary depending on your cluster.
