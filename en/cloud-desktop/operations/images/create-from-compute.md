# Creating an image from a {{ compute-name }} VM

To create a {{ cloud-desktop-name }} [custom image](../../concepts/images.md#custom-images) from a {{ compute-name }} [VM](../../../compute/concepts/vm.md):
1. If you do not have a VM, [create](../../../compute/operations/vm-create/create-linux-vm.md) one.
1. Contact [support]({{ link-console-support }}) to connect your VM to {{ cloud-desktop-name }}.
1. [Create](../../../compute/operations/image-create/create-from-disk.md) an image from the VM's disk.
1. Add the image to {{ cloud-desktop-name }}:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create an image.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
      1. In the left-hand panel, select ![image](../../../_assets/cloud-desktop/images.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
      1. Click **{{ ui-key.yacloud.vdi.button_add-image }}**.
      1. In the **{{ ui-key.yacloud.vdi.label_image-source }}** field, select `{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}`.
      1. In the **{{ ui-key.yacloud.vdi.label_image }}** field, select the previously created image.
      1. Enter the image name.
      1. Click **{{ ui-key.yacloud.common.add }}**.

   {% endlist %}
