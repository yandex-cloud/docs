# Creating a disk snapshot schedule

## Configuring automatic scheduled creation of disk snapshots {#set-schedule}

To configure automatic [scheduled](../../concepts/snapshot-schedule.md) creation of [disk snapshots](../../concepts/snapshot.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. In the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab, click **{{ ui-key.yacloud.common.create }}**.
   1. Configure schedule parameters:
      * Enter a name for the schedule in the following format:

         {% include [name-format](../../../_includes/name-format.md) %}

      * If required, provide a free-form text description for the schedule.
      * Select disks for which you need to create scheduled snapshots. One schedule can include several disks and one disk can be added to several schedules within the [limits](../../concepts/limits.md#compute-limits-snapshot-schedule).

         {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

      * In the **{{ ui-key.yacloud.compute.snapshots-schedules.label_schedule-policy }}** field, select how often the snapshots will be created: `{{ ui-key.yacloud.compute.snapshots-schedules.label_hourly }}`, `{{ ui-key.yacloud.compute.snapshots-schedules.label_daily }}`, `{{ ui-key.yacloud.compute.snapshots-schedules.label_weekly }}`, [or `{{ ui-key.yacloud.compute.snapshots-schedules.label_custom }}`](../../concepts/snapshot-schedule.md#cron). The time of snapshot creation is written in the [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.
      * In the **{{ ui-key.yacloud.compute.snapshots-schedules.label_start-at }}** field, set the start date for your schedule.
      * Select the policy for snapshot retention:
         * **{{ ui-key.yacloud.compute.snapshots-schedules.label_empty-retention-policy }}**: All created scheduled snapshots are kept.
         * **{{ ui-key.yacloud.compute.snapshots-schedules.message_store-last-begin_many }}**: Set the number of the last snapshots to retain or the number of days for which the snapshots to be retained are created. Other snapshots created by this schedule are deleted automatically.

         {% note info %}

         [Quotas](../../concepts/limits.md#compute-quotas) apply to the number and total amount of snapshots in the cloud.

         {% endnote %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI commands for managing schedules:

      ```bash
      yc compute snapshot-schedule --help
      yc compute snapshot-schedule create --help
      ```

   1. Create a schedule using a [cron expression](../../concepts/snapshot-schedule.md#cron):

      ```bash
      yc compute snapshot-schedule create <schedule_name> \
        --expression <cron expression>
      ```
      {% note info %}

      The time of snapshot creation is written in the [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.

      {% endnote %}

      If you need to set a [snapshot retention](../../concepts/snapshot-schedule.md#retention) policy, add the parameter `--snapshot-count` or `--retention-period`. For example:
      * `--snapshot-count 5`: Retain 5 latest snapshots.
      * `--retention-period 72h`: Retain snapshots for the last 3 days.

      To add the beginning date for a schedule, use the `--start-at` parameter. For example:
      * `--start-at "2022-12-31T16:39:00+05:00"`: The schedule starts on December 31, 2022 at 16:39 UTC+5.
      * `--start-at "2h"`: The schedule starts two hours before the current time point.

      For more information about the `yc compute snapshot-schedule create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/snapshot-schedule/create.md).

   1. To add disks to the schedule, get disk IDs:

      ```bash
      yc compute disk list --format yaml
      ```
      Result:
      ```text
      - id: epdcq9g3co9se5uhmgg5
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-10-13T14:37:44Z"
        name: disk-2
        type_id: network-hdd
        zone_id: {{ region-id }}-b
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgvc0jrpaet
        status: READY
        source_image_id: fd88d14a6790do254kj7
        instance_ids:
          - ephothb6lppn5kn8mtom
        disk_placement_policy: {}
      - id: fhm7mip40dqh2lt2hhn2
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-10-10T05:00:04Z"
        name: disk-1
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgvc0jrpaet
        status: READY
        source_image_id: fd88d14a6790do254kj7
        instance_ids:
          - fhm1c7u23aiq8scvnhag
        disk_placement_policy: {}
      ```

   1. Add disks to the schedule:

      ```bash
      yc compute snapshot-schedule add-disks <name_or_ID_of_the_schedule> \
        --disk-id <ID_of_disk_1>,<ID_of_disk_2>
      ```
      Result:
      ```text
      done (3s)
      id: fc8e52mvchb2dbp0pou2
      folder_id: e1ea8s8l71li5n96eakv
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      schedule_policy:
        start_at: "2023-01-01T00:00:00Z"
        expression: 36 14 */1 * *
      snapshot_count: "3"
      snapshot_spec: {}
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

      ```hcl
      resource "yandex_compute_snapshot_schedule" "default" {
        name = "<schedule_name>"

        schedule_policy {
          expression = "<cron_expression>"
        }

        snapshot_count = <number_of_snapshots_per_disk>

        snapshot_spec {
            description = "<snapshot_description>"
            labels = {
              <snapshot_label_key> = "<_snapshot_label_value>"
            }
        }

        disk_ids = ["<ID_of_disk_1>", "<ID_of_disk_2>"]
      }
      ```

      Where:

      * `name`: Schedule name. This is a required parameter.
      * `schedule_policy`: Section with schedule parameters. It contains the `expression` field with a [cron expression](../../concepts/snapshot-schedule.md#cron). This is a required parameter.
      * `snapshot_count`: Maximum number of snapshots per disk. This is an optional parameter.
      * `snapshot_spec`: Section with additional snapshot parameters. This is an optional parameter. It may contain the following fields:
         * `description`: Snapshot description.
         * `labels`: Snapshot [label](../../../overview/concepts/services.md#labels) in `<key> = "<value>"` format.
      * `disk_ids`: IDs of disks to create snapshots for. This is a required parameter.

      For more information about the `yandex_compute_snapshot_schedule` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_snapshot_schedule).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a schedule in the specified folder. You can check the new schedule and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc compute snapshot-schedule get <schedule_name>
   ```

- API

  1. Get the list of disks using the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API call.

      {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

  1. Create a snapshot schedule using the [create](../../api-ref/SnapshotSchedule/create.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/Create](../../api-ref/grpc/snapshot_schedule_service.md#Create) gRPC API call.

{% endlist %}

Snapshots are created and deleted automatically only while the schedule is on (`ACTIVE` [status](../../concepts/snapshot-schedule.md#statuses)).

## Examples {#examples}

### Snapshots are created every day {#daily}

{% list tabs %}

- CLI

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

      * Its name is `sched-1` and description is `Daily`.
      * It will create snapshots every day at 19:10 Moscow time.
      * It will start on December 31 at 19:04 Moscow time.
      * It will save the seven latest snapshots.
      * It will be assigned the label `machine` with the `file-server` value.

   1. To add disks to the schedule, get disk IDs:

      ```bash
      yc compute disk list --format yaml
      ```
      Result:
      ```text
      - id: epdcq9g3co9se5uhmgg5
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-10-13T14:37:44Z"
        name: disk-2
        type_id: network-hdd
        zone_id: {{ region-id }}-b
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgvc0jrpaet
        status: READY
        source_image_id: fd88d14a6790do254kj7
        instance_ids:
          - ephothb6lppn5kn8mtom
        disk_placement_policy: {}
      - id: fhm7mip40dqh2lt2hhn2
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-10-10T05:00:04Z"
        name: disk-1
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgvc0jrpaet
        status: READY
        source_image_id: fd88d14a6790do254kj7
        instance_ids:
          - fhm1c7u23aiq8scvnhag
        disk_placement_policy: {}
      ```

      ```bash
      yc compute disk list
      ```

   1. Add disks to the schedule:

      ```bash
      yc compute snapshot-schedule add-disks sched-1 \
        --disk-id epdcq9g3co9se5uhmgg5,fhm7mip40dqh2lt2hhn2
      ```
      Result:
      ```text
      done (3s)
      id: fc8bplhqmh2bnjni3lm0
      folder_id: e1ea8s8l71li5n96eakv
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

* [{#T}](stop-and-start-schedule.md)
* [{#T}](update-schedule.md)
* [{#T}](delete-schedule.md)
* [Creating a disk snapshot manually](../disk-control/create-snapshot.md)
