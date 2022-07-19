---
title: "How to remove a disc"
description: "You can only delete a disk that is not connected to the virtual machine. Deleting a disk is an irreversible and irreversible operation, it is impossible to recover a deleted disk. Deleting a disk does not delete snapshots of this disk. Snapshots must be deleted separately. To delete a disk in the management console, select the directory, which owns the disk, select the Compute Cloud service, on the Virtual Machines page, go to the Disks tab. In the row with the required disk, click the selection icon and click Delete. "
---

# Deleting a disk

{% note warning %}

You can only delete a disk that is not attached to a virtual machine. For instructions on detaching a disk, see [{#T}](../vm-control/vm-detach-disk.md). Deleting a disk is an operation that cannot be canceled or reversed. You cannot restore a deleted disk.

{% endnote %}

If you delete a disk, its snapshots are not deleted with it. Snapshots need to be [deleted](../snapshot-control/delete.md) separately.

To delete a disk:

{% list tabs %}

- Management console

   1. In the management console, select the folder the disk belongs to.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/disks-pic.svg) **Disks**.
   1. In the row with the desired disk, click ![image](../../../_assets/dots.svg) and select the **Delete** command from the menu.
   1. Confirm the deletion.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete disk commands:

      ```
      yc compute disk delete --help
      ```

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Select the identifier (`ID`) or the name (`NAME`) of the desired image.
   1. Delete the disk:

      ```
      yc compute disk delete \
          --name first-disk
      ```

- API

   You can delete a disk using the API [delete](../../api-ref/Disk/delete.md) method.

   To request the list of available disks, use the [list](../../api-ref/Disk/list.md).

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   You can delete disks created with {{ TF }}:

   1. In the command line, go to the directory with the {{ TF }} configuration file.
   2. Delete resources using the command:

      ```
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   3. Confirm the deletion of resources.


{% endlist %}
