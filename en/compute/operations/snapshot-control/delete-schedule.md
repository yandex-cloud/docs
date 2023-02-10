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

- API

   1. Retrieve a list of schedules using the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API method or the [list](../../api-ref/SnapshotSchedule/list.md) method for the REST API `SnapshotSchedule` resource.
   1. Delete a snapshot schedule using the [SnapshotScheduleService/Delete](../../api-ref/grpc/snapshot_schedule_service.md#Delete) gRPC API method or the [delete](../../api-ref/SnapshotSchedule/delete.md) method for the REST API `SnapshotSchedule` resource.

{% endlist %}

All snapshot creation and deletion operations that started prior to deleting the schedule will be completed.
