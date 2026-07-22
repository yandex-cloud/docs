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

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start maintenance in the interval from `00:00` to `01:00`, put `1`; from `04:00` to `05:00`, `5`.

{% note info %}

To view maintenance task information, you need the `managed-airflow.maintenanceTask.viewer` [role](../security/index.md#managed-airflow-maintenanceTask-viewer) or higher.

To manage maintenance tasks, you need the `managed-airflow.maintenanceTask.editor` [role](../security/index.md#managed-airflow-maintenanceTask-editor) or higher.

{% endnote %}

## Useful links {#see-also}

* [Managing maintenance in a {{ maf-name }} cluster](../operations/cluster-maintenance.md)