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

{% list tabs group=instructions %}

- Management console {#console}

   1. In the management console, select the folder the disk belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. In the line of the appropriate disk, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete disk commands:

      ```bash
      yc compute disk delete --help
      ```

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Select the disk you intend to use by `ID` or `NAME`.
   1. Delete the disk:

      ```bash
      yc compute disk delete \
        --name first-disk
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   You can delete disks created with {{ TF }}:
   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete the resources using this command:

      ```bash
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and instances.

      {% endnote %}

   1. Type `yes` and press **Enter**.

- API {#api}

   To delete a disk, use the [delete](../../api-ref/Disk/delete.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Delete](../../api-ref/grpc/disk_service.md#Delete) gRPC API call.

   To request the list of available disks, use the [list](../../api-ref/Disk/list.md) REST API method or the [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API call.

{% endlist %}