---
title: Maintenance in {{ mos-full-name }}
description: In {{ mos-name }}, maintenance means automatic installation of database updates and patches for hosts (including for stopped clusters), host class and storage size modifications, and other maintenance operations.
---

# Maintenance in {{ mos-name }}

Maintenance includes:

* Automatic installation of {{ OS }} updates and patches for host groups (including for stopped clusters).
* Scheduled [automatic storage expansion](storage.md#auto-rescale).
* Other maintenance activities.

A major DBMS version update is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

{% note info %}

Viewing information on maintenance tasks requires the `managed-opensearch.maintenanceTask.viewer` [role](../security/index.md#managed-opensearch-maintenanceTask-viewer) or higher.

Managing maintenance tasks requires the `managed-opensearch.maintenanceTask.editor` [role](../security/index.md#managed-opensearch-maintenanceTask-editor) or higher.

{% endnote %}

## Maintenance workflow {#maintenance-order}

In {{ mos-name }} single-host clusters, a single host undergoes maintenance. This means, if you restart such a cluster during maintenance, it will become unavailable.

In multi-host clusters, hosts undergo maintenance one by one. Such hosts are queued randomly. If you restart a host during maintenance, it will become unavailable for this time period. If you access a cluster using the [FQDN of the {{ OS }} host](../operations/connect/fqdn.md), the cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect/fqdn.md#special-fqdns) always pointing to the available host.
