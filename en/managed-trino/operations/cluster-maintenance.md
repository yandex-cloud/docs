---
title: '{{ TR }} cluster maintenance'
description: Follow this guide to view information about planned and performed {{ TR }} cluster maintenance and schedule maintenance.
---

# {{ TR }} cluster maintenance

{{ mtr-full-name }} cluster [maintenance](../concepts/maintenance.md) can be managed.

## Getting a list of maintenances {#list-maintenance}

{% list tabs group=instructions %}

- Management console {#console}
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.

  To view maintenances with a particular status, click **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** above the list of maintenances and select the status of interest from the drop-down menu. To find a specific maintenance, enter its ID or task name in the field above the list of maintenances.

{% endlist %}

## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click the maintenance ID you need.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Moving scheduled maintenance {#postpone-planned-maintenance}

Maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status is scheduled for the date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can move them to a new date and time if needed.

To move a maintenance to a new date and time:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. In the window that opens:
      * To move a maintenance forward to the next maintenance window, click **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** and then **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
      * To move a maintenance forward or backward to a specific UTC date and time, click **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, then select a new date and time and click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

{% endlist %}

## Performing scheduled maintenance immediately {#exec-planned-maintenance}

If you need to, you can perform a maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately without waiting for the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

To perform a scheduled cluster maintenance immediately:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

By default, maintenance can be scheduled to any time slot. You can select a particular day of week and hour for the maintenance. For example, you can specify the time when the cluster is least loaded.

{% note warning %}

By selecting a new maintenance interval you will automatically cancel scheduled maintenance unless it falls within the new interval.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. In the window that opens:
     * To allow maintenance at any time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (default).
     * To allow maintenance once a week at a particular time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** and specify the day of week and hour in UTC.

{% endlist %}
