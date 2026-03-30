---
title: Maintenance in {{ mtr-full-name }}
description: In {{ mtr-name }}, maintenance means automatic installation of updates and patches for hosts (including for stopped clusters), host class modifications, and other maintenance operations.
---

# Maintenance in {{ mtr-name }}

Maintenance includes:

* Automatic installation of {{ TR }} updates and patches for hosts (including for stopped clusters).
* Other maintenance activities.

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/cluster-update.md#change-additional-settings):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

{% note info %}

Viewing information on maintenance tasks requires the `managed-trino.maintenanceTask.viewer` [role](../security.md#managed-trino-maintenanceTask-viewer) or higher.

Managing maintenance tasks requires the `managed-trino.maintenanceTask.editor` [role](../security.md#managed-trino-maintenanceTask-editor) or higher.

{% endnote %}