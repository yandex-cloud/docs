---
title: How to create a disk snapshot schedule in {{ compute-full-name }}
description: Follow this guide to create a disk snapshot schedule in {{ compute-name }}.
---

# Creating a disk snapshot schedule


## Setting up an automatic disk snapshot schedule {#set-schedule}

To set up an automatic [disk snapshot](../../concepts/snapshot.md) [schedule](../../concepts/snapshot-schedule.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [disk](../../concepts/disk.md).
  1. Navigate to **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. In the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab, click **{{ ui-key.yacloud.compute.snapshots-schedules.button_create-snapshot-schedule }}**.
  1. {% include [section-schedule](../../_includes_service/schedule/section-schedule.md) %}
  1. {% include [section-storage](../../_includes_service/schedule/section-storage.md) %}
  1. {% include [section-general](../../_includes_service/schedule/section-general.md) %}
  1. {% include [section-snapshot](../../_includes_service/schedule/section-snapshot.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.
      Wait until the schedule is created.

  1. On the page that opens, under **{{ ui-key.yacloud.compute.snapshots-schedules.title_snapshot-schedule-disks }}**, click **{{ ui-key.yacloud.compute.snapshots-schedules.action_attach-disk }}**. In the window that opens, choose a disk to add to the schedule and click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) commands for managing schedules:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule create --help
     ```

  1. Create a schedule:

     ```bash
     yc compute snapshot-schedule create <schedule_name> \
       --expression "<cron_expression>" \
       --start-at "<start_date_and_time>" \
       --retention-period "<snapshot_retention_period>" \
       --description "<schedule_description>" \
       --labels "<schedule_labels>" \
       --snapshot-description "<snapshot_description>" \
       --snapshot-labels "<snapshot_labels>"
     ```

     Where:
     * `--expression`: [Cron expression](../../concepts/snapshot-schedule.md#cron). This is a required setting.
     * `--start-at`: Schedule start date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format.
     * `--retention-period`: Snapshot retention period. Specified in duration format, for example: `300ms`, `1.5h`, or `2h45m`. Use either `--retention-period` or `--snapshot-count`.
     * `--snapshot-count`: Maximum number of snapshots per [disk](../../concepts/disk.md). Use either `--snapshot-count` or `--retention-period`.
     * `--description`: Schedule description.
     * `--labels`: Schedule [labels](../../../overview/concepts/services.md#labels) in `key=value` format.
     * `--snapshot-description`: Snapshot description.
     * `--snapshot-labels`: Snapshot labels in `key=value` format.

     Result:

     ```text
     id: fd8uhc5qcinv********
     folder_id: b1g681qpemb4********
     created_at: "2026-05-25T21:03:22Z"
     name: my-schedule
     description: for my disks
     status: ACTIVE
     schedule_policy:
       start_at: "2027-01-02T15:04:05Z"
       expression: 30 0 * * *
     retention_period: 3600s
     snapshot_spec:
       description: my snapshot
     ```

     {% note info %}

     The snapshot creation time is specified in [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).

     {% endnote %}

     For more information about the `yc compute snapshot-schedule create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/snapshot-schedule/create.md).
  1. To add disks to your schedule, get [disk](../../concepts/disk.md) IDs:

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

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

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

  1. In the {{ TF }} configuration file, describe the resource you want to create:

     ```hcl
     resource "yandex_compute_snapshot_schedule" "default" {
       schedule_policy {
         expression = "<cron_expression>"
         start_at   = "<start_date_and_time>"
       }

       retention_period = "<snapshot_retention_period>"
       name             = "<schedule_name>"
       description      = "<schedule_description>"
       labels           = {
         <schedule_label_key> = "<schedule_label_value>"
       }

       snapshot_spec {
         description = "<snapshot_description>"
         labels      = {
           <snapshot_label_key> = "<snapshot_label_value>"
         }
       }

       disk_ids = ["<disk_1_ID>", "<disk_2_ID>"]
     }
     ```

     Where:
     * `schedule_policy`: Schedule properties:
       * `expression`: [Cron expression](../../concepts/snapshot-schedule.md#cron). This is a required setting.
       * `start_at`: Date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format from which the schedule will run.
     * `retention_period`: Snapshot retention period. Specified in duration format, for example: `"300ms"`, `"1.5h"`, or `"2h45m"`. Any other snapshots created by this schedule will be deleted automatically. Use either `retention_period` or `snapshot_count`.
     * `snapshot_count`: Maximum number of snapshots per [disk](../../concepts/disk.md). Use either `snapshot_count` or `retention_period`.

        {% note info %}

        There are [quotas](../../concepts/limits.md#compute-quotas) on the number and total size of snapshots in the cloud.

        {% endnote %}

     * `name`: Schedule in the following format:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `description`: Schedule description.
     * `labels`: Schedule [labels](../../../overview/concepts/services.md#labels) in `<key> = "<value>"` format.
     * `snapshot_spec`: Properties of snapshots that will be created according to the schedule:
        * `description`: Snapshot description.
        * `labels`: Snapshot labels in `<key> = "<value>"` format.

     * `disk_ids`: IDs of disks to create snapshots for.

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     Learn more about the `yandex_compute_snapshot_schedule` resource properties in the [{{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_snapshot_schedule).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will create a schedule in the specified folder. You can check the new schedule and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc compute snapshot-schedule get <schedule_name>
  ```

- API {#api}

  1. Get a list of disks using the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

  1. Create a snapshot schedule using the [create](../../api-ref/SnapshotSchedule/create.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/Create](../../api-ref/grpc/SnapshotSchedule/create.md) gRPC API call.

{% endlist %}

Snapshots will be created and deleted automatically only while the schedule has the `ACTIVE` [status](../../concepts/snapshot-schedule.md#statuses).

## Examples {#examples}

### Daily snapshots {#daily}

{% list tabs group=instructions %}

- CLI {#cli}

  To set up daily snapshots:
  1. Create a schedule using a [cron expression](../../concepts/snapshot-schedule.md#cron):

     ```bash
     yc compute snapshot-schedule create sched-1 \
       --description "Daily" \
       --expression "10 16 ? * *" \
       --start-at "2022-12-31T19:04:05+03:00" \
       --snapshot-count 7 \
       --labels "machine=file-server"
     ```

     This will create a schedule with the following parameters:
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
* [Creating a disk snapshot manually](../disk-control/create-snapshot.md).
