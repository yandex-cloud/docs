# Deleting a disk snapshot schedule

To delete a disk snapshot schedule:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the schedule is located.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **Disk snapshots**.
   1. Go to the **Snapshot schedules** tab.
   1. Next to the schedule you wish to delete, click ![image](../../../_assets/options.svg) and select **Delete**.
   1. Confirm schedule deletion.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI commands for managing schedules:

      ```bash
      yc compute snapshot-schedule --help
      yc compute snapshot-schedule delete --help
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

   1. Delete the selected schedule:

      ```bash
      yc compute snapshot-schedule delete <name_or_ID_of_the_schedule>
      ```
      Result:
      ```text
      done (5s)
      ```

- API

   1. Retrieve a list of schedules using the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API method or the [list](../../api-ref/SnapshotSchedule/list.md) method for the REST API `SnapshotSchedule` resource.
   1. Delete a snapshot schedule using the [SnapshotScheduleService/Delete](../../api-ref/grpc/snapshot_schedule_service.md#Delete) gRPC API method or the [delete](../../api-ref/SnapshotSchedule/delete.md) method for the REST API `SnapshotSchedule` resource.

{% endlist %}

All snapshot creation and deletion operations that started prior to deleting the schedule will be completed.
