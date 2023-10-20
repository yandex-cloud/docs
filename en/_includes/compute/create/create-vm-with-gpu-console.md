1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. At the top right, click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
   * Enter a name and description for the VM. The naming requirements are as follows:

      {% include [name-format](../../name-format.md) %}

      {% include [name-fqdn](../name-fqdn.md) %}

   * Select an [availability zone](../../../overview/concepts/geo-scope.md) to place your virtual machine in.

      
      {% include [gpu-zones](../gpu-zones.md) %}



1. Select one of the [GPU-oriented images](/marketplace?search=gpu) and OS version under **{{ ui-key.yacloud.compute.instances.create.section_image }}** in the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.

   {% include [gpu-os](../gpu-os.md) %}

1. (Optional) Configure the boot disk under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**:
   * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
   * Specify the required disk size.


   * {% include [encryption-section-boot](../../../_includes/compute/encryption-section-boot.md) %}



1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** tab and attach the [file storage](../../../compute/concepts/filesystem.md):

   * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
   * In the window that opens, select the file storage.
   * Enter the device name.
   * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.


1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Choose a [platform](../../../compute/concepts/vm-platforms.md#gpu-platforms):

      
     * {{ v100-broadwell }}
     * {{ v100-cascade-lake }}
     * {{ a100-epyc }}
     * {{ t4-ice-lake }}
     
     

   * Select a VM [configuration](../../../compute/concepts/gpus.md#config) specifying the required number of GPUs.
   * Make your VM [preemptible](../../../compute/concepts/preemptible-vm.md), if required.


1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   {% include [network-settings](../../../_includes/compute/network-settings.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data required to access the VM:
   * (Optional) Select or create a [service account](../../../iam/concepts/index.md#sa). With a service account, you can flexibly configure access rights for your resources.

      For VMs with a Linux-based operating system:
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

         {% note alert %}

         Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

         {% endnote %}

      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.

      * (Optional) Enable access to the [serial console](../../../compute/operations/index.md#serial-console), if required.

      {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

The virtual machine will appear in the list.
