---
title: Maintenance in {{ msp-full-name }}
description: In {{ msp-name }}, maintenance means automatic installation of updates and patches for hosts (including for stopped clusters), host class modifications, and other maintenance operations.
---

# Maintenance in {{ msp-full-name }}

Maintenance includes:

* Automatic installation of {{ SPRK }} updates and patches for hosts (including for stopped clusters).
* Other maintenance activities.

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/cluster-update.md#change-additional-settings):

* The **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** option (default) allows performing maintenance at any time.
* The **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** option allows you to select the day of the week and UTC time interval for the maintenance. For example, you can choose the cluster's least busy time.

In the management console, you select the maintenance start time as an hour interval. In other interfaces, you specify this interval by its sequence number, from `1` to `24`.

> For example, to start maintenance in the interval from `00:00` to `01:00`, put `1`; from `04:00` to `05:00`, `5`.

{% note info %}

To view maintenance task information, you need the `managed-spark.maintenanceTask.viewer` [role](../security.md#managed-spark-maintenanceTask-viewer) or higher.

To manage maintenance tasks, you need the `managed-spark.maintenanceTask.editor` [role](../security.md#managed-spark-maintenanceTask-editor) or higher.

{% endnote %}