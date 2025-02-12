---
title: How to delete a disk image
description: Follow this guide to delete a disk image.
---

# Deleting a disk image

{% note warning %}

Deleting a disk image is permanent and cannot be undone, so you cannot recover a deleted image.

{% endnote %}

Deleting an image does not affect the VMs or disks created from that image. They must be deleted separately.

To delete an image:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the folder the image belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
  1. In the line with the image, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.images.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI commands for deleting images:

     ```bash
     yc compute image delete --help
     ```

  1. Get a list of images in the default folder:

     {% include [compute-image-list](../../../_includes/compute/image-list.md) %}

  1. Select `ID` or `NAME` of the image in question.
  1. Delete the image:

     ```bash
     yc compute image delete \
       --name first-image
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete an image created with {{ TF }}, follow these steps:
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

  Use the [delete](../../api-ref/Image/delete.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Delete](../../api-ref/grpc/Image/delete.md) gRPC API call.

{% endlist %}