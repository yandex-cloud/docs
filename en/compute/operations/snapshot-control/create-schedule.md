# Creating a disk snapshot schedule

To configure automatic [scheduled](../../concepts/snapshot-schedule.md) creation of [disk snapshots](../../concepts/snapshot.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **Disk snapshots**.
   1. On the **Snapshot schedules** tab, click **Create**.
   1. Configure schedule parameters:
      * Enter a name for the schedule:

         {% include [name-format](../../../_includes/name-format.md) %}

      * If required, provide a free-form text description for the schedule.
      * Select disks for which you need to create scheduled snapshots. One schedule can include several disks and one disk can be added to several schedules within the [limits](../../concepts/limits.md#compute-limits-snapshot-schedule).

      * In the **Create snapshots** field, select frequency of snapshot creation: **By hour**, **By day**, **By week**, or [**By cron expression**](../../concepts/snapshot-schedule.md#cron). The time of snapshot creation is written in the [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.
      * In the **Starting on** field, set the start date for your schedule.
      * Select the policy for snapshot retention:
         * **Store all snapshots**: All created scheduled snapshots are kept.
         * **Only the last**: Set the number of the last snapshots to retain or the number of days for which the snapshots to be retained are created. All other snapshots are deleted automatically.

         {% note info %}

         [Quotas](../../concepts/limits.md#compute-quotas) apply to the number and total amount of snapshots in the cloud.

         {% endnote %}

   1. Click **Create**.

- API

   1. Retrieve a list of disks using the [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API method or the [list](../../api-ref/Disk/list.md) method for the REST API `Disk` resource.

   1. Create a snapshot schedule using the [SnapshotScheduleService/Create](../../api-ref/grpc/snapshot_schedule_service.md#Create) gRPC API method or the [create](../../api-ref/SnapshotSchedule/create.md) method for the REST API `SnapshotSchedule` resource.

{% endlist %}

Snapshots are created and deleted automatically only while the schedule is on (`ACTIVE` [status](../../concepts/snapshot-schedule.md#statuses)).

#### See also {#see-also}

* [{#T}](stop-and-start-schedule.md)
* [{#T}](update-schedule.md)
* [{#T}](delete-schedule.md)
* [Creating a disk snapshot manually](../disk-control/create-snapshot.md)
