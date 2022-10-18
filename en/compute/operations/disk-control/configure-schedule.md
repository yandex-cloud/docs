# Configuring disk snapshot schedules

For a disk, you can create [schedules](../../concepts/snapshot-schedule.md) of [snapshot](../../concepts/snapshot.md) creation:

* [{#T}](#add-schedule).
* [{#T}](#remove-schedule).

## Adding a schedule to a disk {#add-schedule}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
   1. Select **{{ compute-name }}**.
   1. Open the ![image](../../../_assets/compute/disks-pic.svg) tab **Disks** and choose the disk.
   1. Under **Snapshot schedules**, click ![image](../../../_assets/plus.svg) **Add schedule**.
   1. Choose a schedule or create a new one. For more information about setting up schedules, see the [instructions](../snapshot-control/create-schedule.md).
   1. Click **Save**.

{% endlist %}

## Detaching a schedule from a disk {#remove-schedule}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
   1. Select **{{ compute-name }}**.
   1. Open the ![image](../../../_assets/compute/disks-pic.svg) tab **Disks** and choose the disk.
   1. Under **Snapshot schedules**, in the line with the schedule, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Detach from disk**.

{% endlist %}


#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
* [Changing a disk list in a snapshot schedule](../snapshot-control/update-schedule.md#update-disk-list)
* [Creating a disk snapshot manually](../disk-control/create-snapshot.md)
