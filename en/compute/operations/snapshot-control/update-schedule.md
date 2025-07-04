---
title: How to update a disk snapshot schedule in {{ compute-full-name }}
description: Follow this guide to update a disk snapshot schedule in {{ compute-name }}.
---

# Updating a disk snapshot schedule


## Updating basic settings {#update-basic-parameters}

To update basic settings of a [disk snapshot](../../concepts/snapshot.md) [schedule](../../concepts/snapshot-schedule.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the schedule.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. Navigate to the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab.
  1. Next to the schedule you want to update, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit [disk](../../concepts/disk.md) snapshot schedule parameters as needed:
     * **{{ ui-key.yacloud.common.name }}**. Follow these naming requirements:

       {% include [name-format](../../../_includes/name-format.md) %}

     * **{{ ui-key.yacloud.common.description }}**.
     * Under **{{ ui-key.yacloud.compute.snapshots-schedules.label_schedule-policy }}**, select the disk snapshot frequency: `{{ ui-key.yacloud.compute.snapshots-schedules.label_hourly }}`, `{{ ui-key.yacloud.compute.snapshots-schedules.label_daily }}`, `{{ ui-key.yacloud.compute.snapshots-schedules.label_weekly }}`, or [`{{ ui-key.yacloud.compute.snapshots-schedules.label_custom }}`](../../concepts/snapshot-schedule.md#cron). The snapshot creation time is specified in [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).
     * In the **{{ ui-key.yacloud.compute.snapshots-schedules.label_start-at }}** field, set the start date for your schedule.
     * Select the disk snapshot retention policy:
       * **{{ ui-key.yacloud.compute.snapshots-schedules.label_empty-retention-policy }}**: Enable to retain all disk snapshots created by this schedule. 
       * **{{ ui-key.yacloud.compute.snapshots-schedules.message_store-last-begin_many }}**: Specify the number of the latest disk snapshots to retain or the number of days for which you want to retain the snapshots. Any other disk snapshots created by this schedule will be deleted automatically.

       {% note info %}

       There are [quotas](../../concepts/limits.md#compute-quotas) on the number and total size of disk snapshots in the cloud.

       {% endnote %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) commands for managing schedules:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule update --help
     ```

  1. Get a list of schedules in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Result:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Update the parameters of the selected schedule:

     ```bash
     yc compute snapshot-schedule update <schedule_name_or_ID> \
       --new-name <new_name_for_schedule> \
       --description <description> \
       --expression <cron_expression> \
       --retention-period <disk_snapshot_retention_period> \
       --snapshot-count <number_of_disk_snapshots> \
       --start-at <start_date_and_time> \
       --labels <labels>
      ```

     Where:
     * `--new-name`: New name for the schedule.
     * `--description`: Description.
     * `--expression`: [Cron expression](../../concepts/snapshot-schedule.md#cron).
     * `--retention-period`: [Disk](../../concepts/disk.md) snapshot retention period in seconds (`s`), minutes (`m`), or hours (`h`).
     * `--snapshot-count`: Number of retained disk snapshots. Use either `--snapshot-count` or `--retention-period`. Learn more about disk snapshot retention policies [here](../../concepts/snapshot-schedule.md#retention).
     * `--start-at`: Start date and time. You can also specify a period relative to the current time point, e.g., `"2022-12-31T16:39:00+05:00"` or `"2h"`.
     * `--labels`: List of labels in `key=value` format.

     For more information about the `yc compute snapshot-schedule update` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/snapshot-schedule/update.md).

     Result:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the section specifying the schedule:

     {% cut "Example of specifying a schedule in {{ TF }} configuration" %}

     ```hcl
     resource "yandex_compute_snapshot_schedule" "default" {
       name = "my-name"

       schedule_policy {
         expression = "0 0 * * *"
       }

       snapshot_count = 1

       snapshot_spec {
         description = "snapshot-description"
         labels = {
           snapshot-label = "my-snapshot-label-value"
         }
       }

       disk_ids = ["test_disk_id", "another_test_disk_id"]
     }
     ```

     {% endcut %}

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the schedule update and settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc compute snapshot-schedule get <schedule_name>
  ```

- API {#api}

  1. Get a list of schedules using the [list](../../api-ref/SnapshotSchedule/list.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md) gRPC API call.

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

  1. Update a [disk](../../concepts/disk.md) snapshot schedule using the [update](../../api-ref/SnapshotSchedule/update.md) REST API method for the `SnapshotSchedule` resource or the [SnapshotScheduleService/Update](../../api-ref/grpc/SnapshotSchedule/update.md) gRPC API call.

{% endlist %}

## Updating a disk list {#update-disk-list}

To edit a list of disks for which snapshots are scheduled:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the schedule.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. On the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab, select the schedule for which you want to update a disk list.
  1. Update the disk list:
     * To add a new disk, under **{{ ui-key.yacloud.compute.snapshots-schedules.title_snapshot-schedule-disks }}**, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.compute.snapshots-schedules.action_attach-disk }}**. In the window that opens, choose a disk to add to the schedule and click **{{ ui-key.yacloud.common.save }}**.

       {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     * To remove a disk, under **{{ ui-key.yacloud.compute.snapshots-schedules.title_snapshot-schedule-disks }}**, next to the disk you want to remove from the schedule, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.snapshots-schedules.action_detach-disk }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Add or [remove](#remove) disks using the `add-disks` and `remove-disks` commands.

  To add disks:
  1. See the description of the CLI commands for managing schedules:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule add-disks --help
     ```

  1. Get a list of schedules in the default folder:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Result:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Get disk IDs to add them to the schedule:

     ```bash
     yc compute disk list --format yaml
     ```

     Result:

     ```text
     - id: epdcq9g3co9s********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-13T14:37:44Z"
     ...
       instance_ids:
         - fhm1c7u23aiq********
       disk_placement_policy: {}
     ```

  1. Add disks to the schedule:

     ```bash
     yc compute snapshot-schedule add-disks <schedule_name_or_ID> \
       --disk-id <disk_1_ID>,<disk_2_ID>
     ```

     Result:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

  To remove disks: {#remove}
  1. See the description of the CLI commands for managing schedules:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule remove-disks --help
     ```

  1. Get a list of schedules in the default folder:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Result:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Get a list of disks in the current schedule:

     ```bash
     yc compute snapshot-schedule list-disks <schedule_name_or_ID> \
       --format yaml
     ```

     Result:

     ```text
     - id: epdcq9g3co9s********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-13T14:37:44Z"
     ...
       instance_ids:
         - fhm1c7u23aiq********
       disk_placement_policy: {}
     ```

  1. Remove disks from the schedule:

     ```bash
     yc compute snapshot-schedule remove-disks <schedule_name_or_ID> \
       --disk-id <disk_1_ID>,<disk_2_ID>
     ```

     Result:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

- API {#api}

  1. Get a list of schedules using the [list](../../api-ref/SnapshotSchedule/list.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md) gRPC API call.
  1. Get a list of disks using the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.
  1. Update the list of disks in a schedule using the [updateDisks](../../api-ref/SnapshotSchedule/updateDisks.md) REST API method for the `SnapshotSchedule` resource or the [SnapshotScheduleService/UpdateDisks](../../api-ref/grpc/SnapshotSchedule/updateDisks.md) gRPC API call.

{% endlist %}

## Examples {#examples}

### Updating the name of a schedule {#change-name}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Get a list of schedules in the default folder:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Result:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Update the name of the selected schedule:

     ```bash
     yc compute snapshot-schedule update sched-1 \
       --new-name "my-schedule"
     ```

     Result:

     ```text
     done (3s)
     id: fc8e52mvchb2********
     folder_id: e1ea8s8l71li********
     ...
       expression: 36 14 */1 * *
     snapshot_count: "3"
     snapshot_spec: {}
     ```

{% endlist %}

#### What's next {#what-is-next}

* [{#T}](stop-and-start-schedule.md).
* [{#T}](delete-schedule.md).