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
  1. On the **Virtual machines** page, go to the **Images** tab.
  1. In the line with the appropriate image, click ![image](../../../_assets/dots.svg) and select the **Delete** command.
  1. Confirm deletion.
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. See a description of the CLI's delete image commands:
  
      ```
      $ yc compute image delete --help
      ```
  
  1. Get a list of images in the default folder:
  
      {% include [compute-image-list](../../../_includes/compute/image-list.md) %}
  
  1. Select the `ID` or `NAME` of the image you need.
  
  1. Delete the image:
  
      ```
      $ yc compute image delete \
          --name first-image
      ```
  
{% endlist %}

