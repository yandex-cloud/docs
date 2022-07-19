# Deleting a disk image

{% note warning %}

Deleting a disk image is an operation that cannot be canceled or reversed. You cannot restore a deleted image.

{% endnote %}

Deleting an image does not delete the VMs and disks created from this image. They need to be deleted separately.

To delete an image:

{% list tabs %}

- Management console

   1. In the management console, select the folder the image belongs to.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/image-pic.svg) **Images**.
   1. In the row with the desired image, click ![image](../../../_assets/horizontal-ellipsis.svg) and select the **Delete** command from the menu.
   1. Confirm the deletion.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See a description of the CLI's delete image commands:

      ```
      yc compute image delete --help
      ```

   1. Get a list of images in the default folder:

      {% include [compute-image-list](../../../_includes/compute/image-list.md) %}

   1. Select the identifier (`ID`) or name (`NAME`) of the desired image.
   1. Delete the image:

      ```
      yc compute image delete \
          --name first-image
      ```

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   Images created using {{ TF }} can be deleted:

   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete resources using the command:

      ```
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   1. Confirm the deletion of resources.

{% endlist %}
