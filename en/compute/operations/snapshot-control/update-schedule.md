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
         * **Only the last**: Set the number of the last snapshots to retain or the number of days for which the snapshots to be retained are created. All other snapshots are deleted automatically.

         {% note info %}

         [Quotas](../../concepts/limits.md#compute-quotas) apply to the number and total amount of snapshots in the cloud.

         {% endnote %}

   1. Click **Save**.

- API

   1. Retrieve a list of schedules using the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API method or the [list](../../api-ref/SnapshotSchedule/list.md) method for the REST API `SnapshotSchedule` resource.

   1. Start a snapshot schedule using the [SnapshotScheduleService/Update](../../api-ref/grpc/snapshot_schedule_service.md#Update) gRPC API method or the [update](../../api-ref/SnapshotSchedule/update.md) method for the REST API `SnapshotSchedule` resource.

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

      * To delete a disk, under **Disks**, next to the disk you wish to delete from the schedule, click ![image](../../../_assets/options.svg) and select **Delete from schedule**.

- API

   1. Retrieve a list of schedules using the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API method or the [list](../../api-ref/SnapshotSchedule/list.md) method for the REST API `SnapshotSchedule` resource.
   1. Retrieve a list of disks using the [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API method or the [list](../../api-ref/Disk/list.md) method for the REST API `Disk` resource.
   1. Change a list of disks in the schedule using the [SnapshotScheduleService/UpdateDisks](../../api-ref/grpc/snapshot_schedule_service.md#UpdateDisks) gRPC API method or the [updateDisks](../../api-ref/SnapshotSchedule/updateDisks.md) method for the REST API `SnapshotSchedule` resource.

{% endlist %}

#### What's next {#what-is-next}

* [{#T}](stop-and-start-schedule.md)
* [{#T}](delete-schedule.md)
