---
title: Managing maintenance of GPU VMs in {{ compute-full-name }}
description: Follow this guide to manage maintenance of GPU virtual machines in {{ compute-full-name }}.
---

# Managing maintenance of GPU VMs

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{{ compute-name }} performs occasional [maintenance](../../concepts/gpus-maintenance.md) of GPU VMs and notifies users of the scheduled date and time. You can view the list of maintenance [tasks](../../concepts/gpus-maintenance.md#tasks) scheduled for your VMs and reschedule them as needed.

## Viewing VM maintenance tasks

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to view VM maintenance tasks.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![bars-play](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.compute.maintenance_js7p4 }}**.

      The window that opens displays a list of all maintenance tasks for GPU VMs, which includes:

      * `{{ ui-key.yacloud.common.id }}`: Task ID.
      * `{{ ui-key.yacloud.compute.maintenance.task_pZ1gY }}`: Action performed during maintenance affecting the VM availability, e.g., `Restart`.
      * `{{ ui-key.yacloud.compute.maintenance.status_pZ1gY }}`: Task [status](../../concepts/gpus-maintenance.md#maintenance-status).
      * `{{ ui-key.yacloud.compute.maintenance.resource_pZ1gY }}`: Name of the VM to undergo maintenance.
      * `Start date`: Start date and time of the scheduled VM maintenance if the task is pending; otherwise, the actual maintenance start date and time.
      * `Completed`: Maintenance completion date and time.

      To view [details](../../concepts/gpus-maintenance.md#tasks) of a maintenance task, click the relevant row in the task list. Use the top-of-page filter to quickly find the task you need in the list.

      Dates and times displayed in the task details match the time zone selected in the user’s [management console]({{ link-console-main }}) settings.

  {% note tip %}

  You can also view details of a scheduled VM maintenance task in a note ![bulb](../../../_assets/console-icons/bulb.svg) within the **{{ ui-key.yacloud.common.name }}** field in the list of VMs under **{{ ui-key.yacloud.compute.instances.label_title }}** and on the relevant VM page.

  {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. To view the list of VM maintenance tasks, run the following command:

      ```bash
      yc compute maintenance list \
        --cloud-id <cloud_ID> \
        --folder-id <folder_ID> \
        --resource-id <VM_ID> \
        --filter <filter> \
        --order <sorting_order>
      ```

      Where:
      * `--cloud-id`: [ID](../../../resource-manager/operations/cloud/get-id.md) of the cloud where you want to view tasks.
      * `--folder-id`: [ID](../../../resource-manager/operations/folder/get-id.md) of the folder where you want to view tasks.
      * `--resource-id`: ID of the VM to view tasks for.

          {% note info %}

          `--cloud-id`, `--folder-id`, and `--resource-id` are mutually exclusive: you can use only one of them.
          
          If none of these parameters is set, the command will output the list of maintenance tasks in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

          {% endnote %}

      * `--filter`: Filter to apply to the task list you obtained. This is an optional parameter. By default, the command outputs the full list of maintenance tasks.
      
          You can filter the list by task status (`status`) or by VM ID (`resource_id`). For example: `--filter 'status = "SCHEDULED"'` or `--filter 'resource_id = "a7loutvf73vg********"'`.
      * `sort_order`: Task list sorting order. This is an optional parameter. Possible values:
      
          * `created_at`: By the task creation time.
          * `start_scheduled_at`: By the scheduled time of the task.
          * `started_at`: By the task start time.

          By default, tasks are sorted in ascending order. To sort tasks in descending order, use the `DESC` setting, e.g., `--order 'created_at DESC'`.

      Result:

      ```bash
      +----------------------+----------------------+----------------------+------------------+----------------------+-----------+---------------------+---------------------+---------------------+
      |          ID          |       CLOUD ID       |      FOLDER ID       |  RESOURCE TYPE   |     RESOURCE ID      |  STATUS   |     CREATED AT      | START SCHEDULED AT  |     STARTED AT      |
      +----------------------+----------------------+----------------------+------------------+----------------------+-----------+---------------------+---------------------+---------------------+
      | a7l0b4nkle3b******** | a7lia87mbaom******** | a7lt6g8ht345******** | compute.instance | a7loutvf73vg******** | SUCCEEDED | 2025-09-03 11:08:15 | 2025-09-03 11:15:39 | 2025-09-03 11:15:52 |
      | a7l742uljpl3******** | a7lia87mbaom******** | a7lt6g8ht345******** | compute.instance | a7l7f7n9dbfq******** | SCHEDULED | 2025-09-03 11:58:59 | 2025-09-08 07:00:00 |                     |
      +----------------------+----------------------+----------------------+------------------+----------------------+-----------+---------------------+---------------------+---------------------+
      ```

      The `ID` field contains the task ID.

  1. To view information about a specific task, run the following command with the ID of your task:

      ```bash
      yc compute maintenance get <task_ID>
      ```

      Result:

      ```bash
      id: a7l742uljpl3********
      resource_path:
        - id: a7l7f7n9dbfq********
          type: compute.instance
        - id: aoepotm5k3oa********
          type: resource-manager.folder
        - id: a7lia87mbaom********
          type: resource-manager.cloud
      status: SCHEDULED
      created_at: "2025-09-03T11:58:59Z"
      start_scheduled_at: "2025-09-08T07:00:00Z"
      completion_scheduled_at: "2025-09-08T15:00:00Z"
      max_start_scheduled_at: "2025-09-08T07:00:00Z"
      user_controllable: true
      ```

{% endlist %}

## Rescheduling VM maintenance tasks {#reschedule-maintenance}

You can reschedule a task to an earlier or later date and time:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the VM to reschedule a maintenance task for.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![bars-play](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.compute.maintenance_js7p4 }}**.
  1. In the list that opens, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the task in question and select ![arrow-uturn-cw-right](../../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.compute.maintenance.MaintenanceActions.reschedule_rDGt3 }}**. In the window that opens:

      1. Select a new date and time window for the task.

          To see how far you can postpone the maintenance task, click the task row in the list. In the window that opens, the **Can be postponed until** field shows the latest possible date and time.
      1. Click **{{ ui-key.yacloud.compute.components.MaintenanceRescheduleDialog.button_reschedule_3SHfY }}**.

  {% note tip %}

  You can also reschedule a VM maintenance task by clicking ![bulb](../../../_assets/console-icons/bulb.svg) in the **{{ ui-key.yacloud.common.name }}** field in the VM list under **{{ ui-key.yacloud.compute.instances.label_title }}**, and on the relevant VM page.

  {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Get](#list-scheduled-maintenance) the ID of the maintenance task you need.
  1. To reschedule the VM maintenance task, run this command:

      ```bash
      yc compute maintenance reschedule <task_ID> \
        --time "<new_scheduled_date_and_time>"
      ```

      Where:
      * `<task_ID>`: ID of the task to reschedule, obtained in the previous step.
      * `<new_scheduled_date_and_time>`: New date and time for the task, e.g., `2025-09-07T07:00:00Z`.

        Provide the time in [ISO 8601](https://{{ lang }}.wikipedia.org/wiki/ISO_8601) UTC format with zero offset. For Moscow time, add `+03:00` instead of `Z` at the end of the line: `2025-09-07T07:00:00+03:00`.
        
      Result:

      ```bash
      id: a7l742uljpl3********
      resource_path:
        - id: a7l7f7n9dbfq********
          type: compute.instance
        - id: aoepotm5k3oa********
          type: resource-manager.folder
        - id: a7lia87mbaom********
          type: resource-manager.cloud
      status: SCHEDULED
      created_at: "2025-09-03T11:58:59Z"
      start_scheduled_at: "2025-09-07T07:00:00Z"
      completion_scheduled_at: "2025-09-07T15:00:00Z"
      max_start_scheduled_at: "2025-09-08T07:00:00Z"
      user_controllable: true
      ```

{% endlist %}

## Instant start of scheduled maintenance tasks {#execute-now}

You can instantly start a scheduled VM maintenance task.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the VM to start a maintenance task for.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![bars-play](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.compute.maintenance_js7p4 }}**.
  1. In the list that opens, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the task in question and select ![play](../../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.compute.maintenance.MaintenanceActions.perform-now_m8iqx }}**.
  1. In the window that opens, confirm that you want to instantly start the task.

  {% note tip %}

  You can also instantly start a VM maintenance task by clicking ![bulb](../../../_assets/console-icons/bulb.svg) in the **{{ ui-key.yacloud.common.name }}** field in the VM list under **{{ ui-key.yacloud.compute.instances.label_title }}**, and on the relevant VM page.

  {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Get](#list-scheduled-maintenance) the ID of the maintenance task you need.
  1. To instantly start a task, run the following command with the task ID you obtained in the previous step:

      ```bash
      yc compute maintenance reschedule <task_ID> \
        --immediate
      ```

      Result:

      ```bash
      id: a7l742uljpl3********
      resource_path:
        - id: a7l7f7n9dbfq********
          type: compute.instance
        - id: aoepotm5k3oa********
          type: resource-manager.folder
        - id: a7lia87mbaom********
          type: resource-manager.cloud
      status: RUNNING
      created_at: "2025-09-03T11:58:59Z"
      start_scheduled_at: "2025-09-03T13:07:13.136955876Z"
      completion_scheduled_at: "2025-09-04T21:07:13.136955876Z"
      max_start_scheduled_at: "2025-09-08T07:00:00Z"
      user_controllable: true
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/gpus-maintenance.md)