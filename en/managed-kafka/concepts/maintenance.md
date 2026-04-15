---
title: Maintenance in {{ mkf-full-name }}
description: In {{ mkf-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mkf-name }}

Maintenance includes:

* Automatic installation of {{ KF }} updates and patches for hosts (including for stopped clusters).
* Scheduled [automatic storage expansion](./storage.md#auto-rescale).
* Other maintenance activities.

Maintenance includes changes within one {{ KF }} major version. Learn more about migrating between major versions [here](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/cluster-update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

{% note info %}

Viewing information on maintenance tasks requires the `managed-kafka.maintenanceTask.viewer` [role](../security/index.md#managed-kafka-maintenanceTask-viewer) or higher.

Managing maintenance tasks requires the `managed-kafka.maintenanceTask.editor` [role](../security/index.md#managed-kafka-maintenanceTask-editor) or higher.

{% endnote %}

## Maintenance procedure {#maintenance-order}

In single-host {{ mkf-name }} clusters, a single [broker host](brokers.md) undergoes maintenance. This means, if you restart such a cluster during maintenance, it will become unavailable.

In multi-host clusters, broker hosts undergo maintenance one by one. Such hosts are queued randomly. A broker host becomes unavailable while it is being restarted during maintenance.

## Karapace availability {#karapace}

{% include [karapace-maintenance](../../_includes/mdb/mkf/karapace-maintenance.md) %}

[Learn more about managing data schemas](managed-schema-registry.md).