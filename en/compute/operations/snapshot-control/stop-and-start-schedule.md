# Interrupting and starting a disk snapshot schedule

## Interrupting a schedule {#stop-schedule}

To interrupt automatic [scheduled](../../concepts/snapshot.md) creation of [disk snapshots](../../concepts/snapshot-schedule.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the schedule is located.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **Disk snapshots**.
   1. Go to the **Snapshot schedules** tab.
   1. Next to the schedule you wish to interrupt, click ![image](../../../_assets/options.svg) and select **Stop**.
   1. Confirm the schedule stop.

- API

   1. Retrieve a list of schedules using the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API method or the [list](../../api-ref/SnapshotSchedule/list.md) method for the REST API `SnapshotSchedule` resource.
   1. Interrupt a snapshot schedule using the [SnapshotScheduleService/Disable](../../api-ref/grpc/snapshot_schedule_service.md#Disable) gRPC API method or the [disable](../../api-ref/SnapshotSchedule/disable.md) method for the REST API `SnapshotSchedule` resource.

{% endlist %}

The schedule [status](../../concepts/snapshot-schedule.md#statuses) changes to `INACTIVE` – disk snapshots won't be created or deleted.

All snapshot creation and deletion operations that started prior to interrupting the schedule will be completed.

## Starting a schedule {#start-schedule}

To start automatic scheduled creation of disk snapshots:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the schedule is located.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/snapshots.svg) **Disk snapshots**.
   1. Go to the **Snapshot schedules** tab.
   1. Next to the schedule you wish to start, click ![image](../../../_assets/options.svg) and select **Start**.

- API

   1. Retrieve a list of schedules using the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API method or the [list](../../api-ref/SnapshotSchedule/list.md) method for the REST API `SnapshotSchedule` resource.
   1. Start a snapshot schedule using the [SnapshotScheduleService/Enable](../../api-ref/grpc/snapshot_schedule_service.md#Enable) gRPC API method or the [enable](../../api-ref/SnapshotSchedule/enable.md) method for the REST API `SnapshotSchedule` resource.

{% endlist %}

The schedule status changes to `ACTIVE` — new disk snapshots will be created, old ones deleted (if the corresponding parameter of [snapshot retention](../../concepts/snapshot-schedule.md#retention) is selected).

#### What's next {#what-is-next}

* [{#T}](update-schedule.md)
* [{#T}](delete-schedule.md)
