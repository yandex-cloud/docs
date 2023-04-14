# Changing a disk snapshot schedule

## Changing basic settings {#update-basic-parameters}

To change basic settings of a snapshot schedule:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the schedule is located.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **Disk snapshots**.
   1. Go to the **Snapshot schedules** tab.
   1. Next to the schedule you wish to change, click ![image](../../../_assets/options.svg) and select **Edit**.
   1. Configure snapshot schedule parameters:
      * **Name**:

         {% include [name-format](../../../_includes/name-format.md) %}

      * **Description**.
      * In the **Create snapshots** field, select frequency of snapshot creation: **By hour**, **By day**, **By week**, or [**By cron expression**](../../concepts/snapshot-schedule.md#cron). The time of snapshot creation is written in the [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.
      * In the **Starting on** field, set the start date for your schedule.
      * Select the policy for snapshot retention:
         * **Store all snapshots**: All created scheduled snapshots are kept.
         * **Only the last**: Set the number of the last snapshots to retain or the number of days for which the snapshots to be retained are created. Other snapshots created by this schedule are deleted automatically.

         {% note info %}

         [Quotas](../../concepts/limits.md#compute-quotas) apply to the number and total amount of snapshots in the cloud.

         {% endnote %}

   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI commands for managing schedules:

      ```bash
      yc compute snapshot-schedule --help
      yc compute snapshot-schedule update --help
      ```

   1. Get a list of schedules in the default folder:

      ```bash
      yc compute snapshot-schedule list --format yaml
      ```
      Result:
      ```text
      - id: fc852cvb1ipd55flc7t9
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7frkrne9eo
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2bnjni3lm0
        folder_id: b8gauskl78li5n96eabk
        created_at: "2022-10-03T13:28:01Z"
        name: sched-3
        description: Daily
        labels:
          machine: file-server
        status: ACTIVE
        schedule_policy:
          start_at: "2022-12-31T19:04:05Z"
          expression: 10 19 ? * *
        snapshot_count: "7"
        snapshot_spec: {}
      ```

   1. Update the parameters of the selected schedule:

      ```bash
      yc compute snapshot-schedule update <name_or_ID_of_the_schedule> \
        --new-name <new_name_of_the_schedule> \
        --description <description> \
        --expression <cron expression> \
        --retention-period <retention_period_for_snapshots> \
        --snapshot-count <number_of_snapshots> \
        --start-at <start_date_and_time> \
        --labels <labels>
      ```
      Where:

      * `--new-name`: New name for the schedule.
      * `--description`: Description.
      * `--expression`: [Cron expression](../../concepts/snapshot-schedule.md#cron).
      * `--retention-period`: Period of snapshot retention in seconds (`s`), minutes (`m`), or hours (`h`).
      * `--snapshot-count`: Number of stored snapshots. Use either `--snapshot-count` or `--retention-period`. See about [retention policies](../../concepts/snapshot-schedule.md#retention).
      * `--start-at`: Start date and time. You can also specify a period related to the current time point. For example: `"2022-12-31T16:39:00+05:00"`, `"2h"`.
      * `--labels`: List of labels in `key=value` format.

      For more information about the `yc compute snapshot-schedule create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/snapshot-schedule/update.md).

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

- API

   1. Get the list of schedules using the [list](../../api-ref/SnapshotSchedule/list.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API call.

      {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

   1. Update a snapshot schedule using the [update](../../api-ref/SnapshotSchedule/update.md) REST API method for the `SnapshotSchedule` resource or the [SnapshotScheduleService/Update](../../api-ref/grpc/snapshot_schedule_service.md#Update) gRPC API call.

{% endlist %}

## Changing a disk list {#update-disk-list}

To change a list of disks for which snapshots are scheduled:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the schedule is located.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **Disk snapshots**.
   1. On the **Snapshot schedules** tab, choose a schedule for which you want to change a disk list.
   1. Change a disk list:
      * To add a new disk, under **Disks**, click ![image](../../../_assets/plus-sign.svg) **Add disk**. In the window that opens, choose a disk to add to the schedule and click **Save**.

         {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

      * To delete a disk, under **Disks**, next to the disk you wish to delete from the schedule, click ![image](../../../_assets/options.svg) and select **Delete from schedule**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Add or [delete](#remove) disks using the `add-disks` and `remove-disks` commands:

   To add disks:

   1. View the description of the CLI commands for managing schedules:

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
      - id: fc852cvb1ipd55flc7t9
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7frkrne9eo
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2bnjni3lm0
        folder_id: b8gauskl78li5n96eabk
        created_at: "2022-10-03T13:28:01Z"
        name: sched-3
        description: Daily
        labels:
          machine: file-server
        status: ACTIVE
        schedule_policy:
          start_at: "2022-12-31T19:04:05Z"
          expression: 10 19 ? * *
        snapshot_count: "7"
        snapshot_spec: {}
      ```

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
        start_at: "1970-01-01T00:00:00Z"
        expression: 36 14 */1 * *
      snapshot_count: "3"
      snapshot_spec: {}
      ```

   To delete disks: {#remove}

   1. View the description of the CLI commands for managing schedules:

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
      - id: fc852cvb1ipd55flc7t9
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7frkrne9eo
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2bnjni3lm0
        folder_id: b8gauskl78li5n96eabk
        created_at: "2022-10-03T13:28:01Z"
        name: sched-3
        description: Daily
        labels:
          machine: file-server
        status: ACTIVE
        schedule_policy:
          start_at: "2022-12-31T19:04:05Z"
          expression: 10 19 ? * *
        snapshot_count: "7"
        snapshot_spec: {}
      ```

   1. Get a list of disks used in the current schedule:

      ```bash
      yc compute snapshot-schedule list-disks <name_or_ID_of_the_schedule> \
        --format yaml
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
          - epdothb6lppn5kn8mtom
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
          - fhm1c7u23aiq8scvnbag
        disk_placement_policy: {}
      ```

   1. Delete disks from the schedule:

      ```bash
      yc compute snapshot-schedule remove-disks <name_or_ID_of_the_schedule> \
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
        start_at: "1970-01-01T00:00:00Z"
        expression: 36 14 */1 * *
      snapshot_count: "3"
      snapshot_spec: {}
      ```

- API

   1. Get the list of schedules using the [list](../../api-ref/SnapshotSchedule/list.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API call.
   1. Get the list of disks using the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API call.
   1. Update the list of disks in a schedule using the [updateDisks](../../api-ref/SnapshotSchedule/updateDisks.md) REST API method for the `SnapshotSchedule` resource or the [SnapshotScheduleService/UpdateDisks](../../api-ref/grpc/snapshot_schedule_service.md#UpdateDisks) gRPC API call.

{% endlist %}

## Examples {#examples}

### Updating the name of a schedule {#change-name}

{% list tabs %}

- CLI

   To set a new name for the schedule:

   1. Get a list of schedules in the default folder:

      ```bash
      yc compute snapshot-schedule list --format yaml
      ```
      Result:
      ```text
      - id: fc852cvb1ipd55flc7t9
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7frkrne9eo
        folder_id: e1ea8s8l71li5n96eakv
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2bnjni3lm0
        folder_id: b8gauskl78li5n96eabk
        created_at: "2022-10-03T13:28:01Z"
        name: sched-3
        description: Daily
        labels:
          machine: file-server
        status: ACTIVE
        schedule_policy:
          start_at: "2022-12-31T19:04:05Z"
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
      id: fc8e52mvchb2dbp0pou2
      folder_id: e1ea8s8l71li5n96eakv
      created_at: "2022-09-28T09:15:28Z"
      name: my-schedule
      status: ACTIVE
      schedule_policy:
        start_at: "1970-01-01T00:00:00Z"
        expression: 36 14 */1 * *
      snapshot_count: "3"
      snapshot_spec: {}
      ```

{% endlist %}

#### What's next {#what-is-next}

* [{#T}](stop-and-start-schedule.md)
* [{#T}](delete-schedule.md)
