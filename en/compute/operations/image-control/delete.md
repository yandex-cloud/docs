---
title: "How to delete a disk image"
description: "This guide describes how you can delete a disk image."
---

# Deleting a disk image

{% note warning %}

Deleting a disk image is an operation that cannot be canceled or reversed. You cannot restore a deleted image.

{% endnote %}

Deleting an image does not delete the VMs and disks created from this image. They need to be deleted separately.

To delete an image:

{% list tabs %}

- Management console

   1. In the management console, select the folder the image belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/image-pic.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
   1. In the line of the appropriate image, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.images.button_action-delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.images.popup-confirm_button_delete }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See a description of the CLI's delete image commands:

      ```bash
      yc compute image delete --help
      ```

   1. Get a list of images in the default folder:

      {% include [compute-image-list](../../../_includes/compute/image-list.md) %}

   1. Select the identifier (`ID`) or name (`NAME`) of the desired image.
   1. Delete the image:

      ```bash
      yc compute image delete \
        --name first-image
      ```

- API

   Use the [delete](../../api-ref/Image/delete.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Delete](../../api-ref/grpc/image_service.md#Delete) gRPC API call.

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   Images created using {{ TF }} can be deleted:
   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete the resources using this command:

      ```bash
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and instances.

      {% endnote %}

   1. Type `yes` and press **Enter**.

{% endlist %}