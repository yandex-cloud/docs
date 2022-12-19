---
title: "How to delete a disk"
description: "You can only delete a disk that is not attached to a virtual machine. Deleting a disk is an operation that cannot be canceled or reversed. You cannot restore a deleted disk. If you delete a disk, its snapshots are not deleted with it. Snapshots need to be deleted separately. To delete a disk from the management console, select the folder that hosts the disk, select the {{ compute-name }} service, on the Instances page, click Disks. In the line of the appropriate disk, click the select icon and then Delete."
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
   1. In the window that opens, click **Delete**.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete disk commands:

      ```bash
      yc compute disk delete --help
      ```

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Select the identifier (`ID`) or the name (`NAME`) of the desired image.
   1. Delete the disk:

      ```bash
      yc compute disk delete \
        --name first-disk
      ```

- API

   You can delete a disk using the API [delete](../../api-ref/Disk/delete.md) method.

   To request the list of available disks, use the [list](../../api-ref/Disk/list.md).

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   You can delete disks created with {{ TF }}:
   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete resources using the command:

      ```bash
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and instances.

      {% endnote %}

   1. Type the word `yes`, then press **Enter**.

{% endlist %}