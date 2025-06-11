---
title: How to delete a disk
description: You can only delete a disk that is not attached to a virtual machine. Deleting a disk is permanent and cannot be undone, so you cannot recover a deleted disk. If you delete a disk, its snapshots remain unaffected. Snapshots must be deleted separately. To delete a disk using the management console, go to the folder the disk belongs to, select {{ compute-name }}, and go to the **Disks** tab on the **Virtual machines** page. In the line with the disk in question, click the select icon and then **Delete**.
---

# Deleting a disk

{% note warning %}

You can only delete a disk that is not attached to a virtual machine. To learn how to detach a disk, see [{#T}](../vm-control/vm-detach-disk.md). Deleting a disk is permanent and cannot be undone, so you cannot recover a deleted disk.

{% endnote %}

If you delete a disk, its snapshots remain unaffected. Snapshots must be [deleted](../snapshot-control/delete.md) separately.

To delete a disk:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the folder the disk belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. In the line with the disk, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI commands for deleting disks:

     ```bash
     yc compute disk delete --help
     ```

  1. Get a list of disks in the default folder:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select `ID` or `NAME` of the disk in question.
  1. Delete the disk:

     ```bash
     yc compute disk delete \
       --name first-disk
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a disk created with {{ TF }}, follow these steps:
  1. In the command line, go to the directory with the {{ TF }} configuration file.
  1. Delete the resources using this command:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     {{ TF }} will delete all the resources you created in the current configuration, such as clusters, networks, subnets, and VMs.

     {% endnote %}

  1. Type `yes` and press **Enter**.

- API {#api}

  To delete a disk, use the [delete](../../api-ref/Disk/delete.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Delete](../../api-ref/grpc/Disk/delete.md) gRPC API call.

  To request a list of available disks, use the [list](../../api-ref/Disk/list.md) REST API method or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.

{% endlist %}