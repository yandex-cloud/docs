To create a VM:
1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
1. In the list of services, select **{{ compute-name }}**.
1. Click **Create VM**.
1. Under **Basic parameters**:
   * Enter a name and description for the VM. The naming requirements are as follows:

      {% include [name-format](../../name-format.md) %}

      {% include [name-fqdn](../name-fqdn.md) %}

   * Select an [availability zone](../../../overview/concepts/geo-scope.md) to put your virtual machine in.

     
     {% include [gpu-zones](../gpu-zones.md) %}

 

1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select a [GPU-oriented image](/marketplace?search=gpu) and OS version.

   {% include [gpu-os](../gpu-os.md) %}

1. (optional) Under **Disks and file storage**, configure a boot disk:
   * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
   * Specify the required disk size.

1. (optional) Under **Disks and file storage**, select the **File storage** tab, connect a [file store](../../../compute/concepts/filesystem.md), and enter the device name.

1. Under **Computing resources**:
   * Choose a [platform](../../../compute/concepts/vm-platforms.md#gpu-platforms):

     
     * {{ v100-broadwell }}
     * {{ v100-cascade-lake }}
     * {{ a100-epyc }}
     * {{ t4-ice-lake }}
     
     

   * Select a VM [configuration](../../../compute/concepts/gpus.md#config) specifying the required number of GPU.
   * Make your VM [preemptible](../../../compute/concepts/preemptible-vm.md), if required. 
 

1. Under **Network settings**:

   {% include [network-settings](../../../_includes/compute/network-settings.md) %}

1. Under **Access**, specify the data required to access the VM:
   * (optional) Select or create a [service account](../../../iam/concepts/index.md#sa). By using a service account, you can flexibly configure access rights for your resources.

      For VMs with a Linux-based operating system:
      * Enter the username in the **Login** field.

         {% note alert %}

         Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

         {% endnote %}

      * In the **SSH key** field, paste the contents of the [public key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.

      * (optional) Enable access to the [serial console](../../../compute/operations/index.md#serial-console), if required.

1. Click **Create VM**.

The virtual machine will appear in the list.
