# Creating an image from a {{ compute-name }} VM

To create a {{ cloud-desktop-name }} [custom image](../../concepts/images.md#custom-images) from a {{ compute-name }} [VM](../../../compute/concepts/vm.md):
1. If you do not have a VM, [create](../../../compute/operations/vm-create/create-linux-vm.md) one.
1. Contact [support]({{ link-console-support }}) to connect your VM to {{ cloud-desktop-name }}.
1. [Create](../../../compute/operations/image-create/create-from-disk.md) an image from the VM's disk.
1. Add the image to {{ cloud-desktop-name }}:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create an image.
      1. In the list of services, select **{{ cloud-desktop-name }}**.
      1. On the left-hand panel, select ![image](../../../_assets/cloud-desktop/images.svg) **Images**.
      1. Click **Add image**.
      1. In the **Image source** field, select **{{ compute-name }}**.
      1. In the **{{ compute-name }} image** field, select the previously created image.
      1. Enter the image name.
      1. Click **Add**.

   {% endlist %}
