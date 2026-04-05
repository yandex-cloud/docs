---
title: Maintenance in {{ maf-full-name }}
description: In {{ mtr-name }}, maintenance means automatic installation of updates and fixes for cluster components (including for disabled clusters), changing component configurations, and other maintenance activities.
---

# Maintenance in {{ maf-full-name }}

Maintenance means:

* Automatic installation of {{ AF }} updates and revisions for cluster [components](index.md#components) (including for disabled clusters).
* Other maintenance activities.

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/cluster-update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

{% note info %}

Viewing information on maintenance tasks requires the `managed-airflow.maintenanceTask.viewer` [role](../security/index.md#managed-airflow-maintenanceTask-viewer) or higher.

Managing maintenance tasks requires the `managed-airflow.maintenanceTask.editor` [role](../security/index.md#managed-airflow-maintenanceTask-editor) or higher.

{% endnote %}

## See also {#see-also}

* [Managing maintenance in a {{ maf-name }} cluster](../operations/cluster-maintenance.md)