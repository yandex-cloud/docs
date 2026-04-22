---
title: Maintenance in {{ maf-full-name }}
description: In {{ maf-name }}, maintenance means automatic installation of updates and patches for cluster components (including for stopped clusters), component configuration modifications, and other maintenance operations.
---

# Maintenance in {{ maf-full-name }}

Maintenance includes:

* Automatic installation of {{ AF }} updates and revisions for cluster [components](index.md#components) (including for disabled clusters).
* Other maintenance activities.

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/cluster-update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

{% note info %}

To view maintenance task information, you need the `managed-airflow.maintenanceTask.viewer` [role](../security/index.md#managed-airflow-maintenanceTask-viewer) or higher.

To manage maintenance tasks, you need the `managed-airflow.maintenanceTask.editor` [role](../security/index.md#managed-airflow-maintenanceTask-editor) or higher.

{% endnote %}

## See also {#see-also}

* [Managing maintenance in a {{ maf-name }} cluster](../operations/cluster-maintenance.md)