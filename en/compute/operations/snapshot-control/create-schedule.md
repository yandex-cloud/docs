---
title: How to create a disk snapshot schedule in {{ compute-full-name }}
description: Follow this guide to create a disk snapshot schedule in {{ compute-name }}.
---

# Creating a disk snapshot schedule


## Configuring an automatic disk snapshot schedule {#set-schedule}

To configure automatic [scheduled](../../concepts/snapshot-schedule.md) creation of [disk snapshots](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [disk](../../concepts/disk.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. In the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab, click **{{ ui-key.yacloud.common.create }}**.
  1. Configure schedule parameters:
     * Enter a name for the schedule in the following format:

       {% include [name-format](../../../_includes/name-format.md) %}

     * If required, provide a free-form text description for the schedule.
     * Select disks for which you need to create scheduled snapshots. One schedule can include several disks and one disk can be added to several schedules within the [limits](../../concepts/limits.md#compute-limits-snapshot-schedule).

       {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     * In the **{{ ui-key.yacloud.compute.snapshots-schedules.label_schedule-policy }}** field, select how often the snapshots will be created: `{{ ui-key.yacloud.compute.snapshots-schedules.label_hourly }}`, `{{ ui-key.yacloud.compute.snapshots-schedules.label_daily }}`, `{{ ui-key.yacloud.compute.snapshots-schedules.label_weekly }}`, [or `{{ ui-key.yacloud.compute.snapshots-schedules.label_custom }}`](../../concepts/snapshot-schedule.md#cron). The snapshot creation time is specified in [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).
     * In the **{{ ui-key.yacloud.compute.snapshots-schedules.label_start-at }}** field, set the start date for your schedule.
     * Select the snapshot retention policy:
       * **{{ ui-key.yacloud.compute.snapshots-schedules.label_empty-retention-policy }}**: All the snapshots created according to this schedule will be retained.
       * **{{ ui-key.yacloud.compute.snapshots-schedules.message_store-last-begin_many }}**: Set the number of the last snapshots to be retained or the number of days for which the snapshots are to be retained. Other snapshots created according to this schedule will be deleted automatically.

       {% note info %}

       [Quotas](../../concepts/limits.md#compute-quotas) apply to the number and total amount of snapshots in the cloud.

       {% endnote %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/) commands for managing schedules:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule create --help
     ```

  1. Create a schedule using a [cron expression](../../concepts/snapshot-schedule.md#cron):

     ```bash
     yc compute snapshot-schedule create <schedule_name> \
       --expression <cron_expression>
     ```

     {% note info %}

     The snapshot creation time is specified in [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).

     {% endnote %}

     If you need to configure a [snapshot retention](../../concepts/snapshot-schedule.md#retention) policy, add the `--snapshot-count` or `--retention-period` parameter, for example:
     * `--snapshot-count 5`: Retain 5 latest snapshots.
     * `--retention-period 72h`: Retain snapshots for the last 3 days.

     To add the start date for a schedule, use the `--start-at` parameter, For example:
     * `--start-at "2022-12-31T16:39:00+05:00"`: Schedule starts at 16:39 UTC+5 on December 31, 2022.
     * `--start-at "2h"`: Schedule starts two hours before the current time point.

     For more information about the `yc compute snapshot-schedule create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/snapshot-schedule/create.md).
  1. To add disks to the schedule, get [disk](../../concepts/disk.md) IDs:

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

     ```hcl
     resource "yandex_compute_snapshot_schedule" "default" {
       name = "<schedule_name>"

       schedule_policy {
         expression = "<cron_expression>"
       }

       snapshot_count = <number_of_snapshots_for_each_disk>

       snapshot_spec {
         description = "<snapshot_description>"
         labels = {
           <snapshot_label_key> = "<snapshot_label_value>"
         }
       }

       disk_ids = ["<disk_1_ID>", "<disk_2_ID>"]
     }
     ```

     Where:
     * `name`: Schedule name. This is a required parameter.
     * `schedule_policy`: Section with schedule parameters. It contains the `expression` field with a [cron expression](../../concepts/snapshot-schedule.md#cron). This is a required parameter.
     * `snapshot_count`: Maximum number of snapshots per [disk](../../concepts/disk.md). This is an optional parameter.
     * `snapshot_spec`: Section with additional snapshot parameters. This is an optional parameter. It may contain the following fields:
       * `description`: Snapshot description.
       * `labels`: Snapshot [label](../../../overview/concepts/services.md#labels) in `<key> = "<value>"` format.
     * `disk_ids`: IDs of disks to create snapshots for. This is a required parameter.

     For more information about the `yandex_compute_snapshot_schedule` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_snapshot_schedule).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will create a schedule in the specified folder. You can check the new schedule and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc compute snapshot-schedule get <schedule_name>
  ```

- API {#api}

  1. Get the list of disks using the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

  1. Create a snapshot schedule using the [create](../../api-ref/SnapshotSchedule/create.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/Create](../../api-ref/grpc/SnapshotSchedule/create.md) gRPC API call.

{% endlist %}

Snapshots are created and deleted automatically only while the schedule is on (has the `ACTIVE` [status](../../concepts/snapshot-schedule.md#statuses)).

## Examples {#examples}

### Snapshots are created every day {#daily}

{% list tabs group=instructions %}

- CLI {#cli}

  To set up daily creation of snapshots:
  1. Create a schedule using a [cron expression](../../concepts/snapshot-schedule.md#cron):

     ```bash
     yc compute snapshot-schedule create sched-1 \
       --description "Daily" \
       --expression "10 16 ? * *" \
       --start-at "2022-12-31T19:04:05+03:00" \
       --snapshot-count 7 \
       --labels "machine=file-server"
     ```

     As a result, the following schedule is created:
     * Name: `sched-1`; description: `Daily`.
     * Snapshots taken daily at 19:10 Moscow time.
     * Start date: December 31 at 19:04 Moscow time.
     * Last seven snapshots retained.
     * Label: `machine`; label value: `file-server`.
  1. Get disk IDs to add them to the schedule:

     ```bash
     yc compute disk list --format yaml
     ```

     Result:

     ```text
     - id: epdcq9g3co9s********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-13T14:37:44Z"
       name: disk-2
       type_id: network-hdd
       zone_id: {{ region-id }}-a
       size: "21474836480"
       block_size: "4096"
       product_ids:
         - f2euv1kekdgv********
       status: READY
       source_image_id: fd88d14a6790********
       instance_ids:
         - ephothb6lppn********
       disk_placement_policy: {}
     - id: fhm7mip40dqh********
       folder_id: e1ea8s8l71li********
       created_at: "2022-10-10T05:00:04Z"
       name: disk-1
       type_id: network-hdd
       zone_id: {{ region-id }}-a
       size: "21474836480"
       block_size: "4096"
       product_ids:
         - f2euv1kekdgv********
       status: READY
       source_image_id: fd88d14a6790********
       instance_ids:
         - fhm1c7u23aiq********
       disk_placement_policy: {}
      ```

  1. Add disks to the schedule:

     ```bash
     yc compute snapshot-schedule add-disks sched-1 \
       --disk-id epdcq9g3co9s********,fhm7mip40dqh********
     ```

     Result:

     ```text
     done (3s)
     id: fc8bplhqmh2b********
     folder_id: e1ea8s8l71li********
     created_at: "2022-10-03T13:28:01Z"
     name: sched-1
     description: Daily
     labels:
       machine: file-server
     status: ACTIVE
     schedule_policy:
       start_at: "2022-12-31T16:04:05Z"
       expression: 10 16 ? * *
     snapshot_count: "7"
     snapshot_spec: {}
     ```

{% endlist %}

#### See also {#see-also}

* [{#T}](stop-and-start-schedule.md).
* [{#T}](update-schedule.md).
* [{#T}](delete-schedule.md).
* [Creating disk snapshots manually](../disk-control/create-snapshot.md).