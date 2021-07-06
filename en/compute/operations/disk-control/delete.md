---
title: "How to remove a disc"
description: "You can only delete a disk that is not connected to the virtual machine. Deleting a disk is an irreversible and irreversible operation, it is impossible to recover a deleted disk. Deleting a disk does not delete snapshots of this disk. Snapshots must be deleted separately. To delete a disk in the management console, select the directory, which owns the disk, select the Compute Cloud service, on the Virtual Machines page, go to the Disks tab. In the row with the required disk, click the selection icon and click Delete. "
---

# Deleting a disk

You can only delete a disk that is not attached to any VM.

{% note warning %}

Deleting a disk is an operation that cannot be canceled or reversed. You cannot restore a deleted disk.

{% endnote %}

If you delete a disk, its snapshots are not deleted with it. Snapshots need to be [deleted](../snapshot-control/delete.md) separately.

To delete a disk:

{% list tabs %}

- Management console
  
  1. In the management console, select the folder the disk belongs to.
  1. Click on the **Compute Cloud** tile.
  1. On the **Virtual machines** page, go to the **Disks** tab.
  1. In the row with the appropriate disk, click on the icon ![image](../../../_assets/dots.svg) and select the **Delete** command.
  1. Confirm the deletion.
  
- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's delete disk commands:
  
      ```
      $ yc compute disk delete --help
      ```
  
  1. Get a list of disks in the default folder:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
  1. Select the `ID` or `NAME` of the necessary disk.
  1. Delete the disk:
  
      ```
      $ yc compute disk delete \
          --name first-disk
      ```
  
{% endlist %}

