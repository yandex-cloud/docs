To create a [VM](../concepts/vm.md):
1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
1. In the list of services, select **{{ compute-name }}**.
1. Click **Create VM**.
1. Under **Basic parameters**:
   * Enter a name and description for the VM. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

   * Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
1. Under **Image/boot disk selection**, select an [image](../concepts/image.md) and a Linux-based OS version.
1. (Optional) Under **Disks and file storage**, select the **Disks** tab and configure a boot [disk](../concepts/disk.md):
   * Select the [disk type](../concepts/disk.md#disks_types).
   * Specify the required disk size.

      If you wish to create a VM from an existing disk, under **Disks and file storage**, [add a disk](../operations/vm-create/create-from-disks.md):
      * Click **Add disk**.
      * Enter the disk name.
      * Select the [disk type](../concepts/disk.md#disks_types).
      * Specify the desired block size.
      * Specify the required disk size.
      * (optional) Enable the **Delete with the VM** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Select `Disk` as content.
      * Click **Add**.


1. (optional) Under **Disks and file storage**, click the **File storage tab** and connect a [file store](../concepts/filesystem.md):
   * Click **Connect file storage**.
   * In the window that opens, select a file store.
   * Enter a device name.
   * Click **Connect file storage**.


1. Under **Computing resources**:
   * Choose a [platform](../concepts/vm-platforms.md).
   * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
   * If required, make your VM [preemptible](../concepts/preemptible-vm.md).
   * (optional) Enable a [software-accelerated network](../concepts/software-accelerated-network.md).
1. Under **Network settings**:

   {% include [network-settings](../../_includes/compute/network-settings.md) %}


1. {% include [backup-info](../../_includes/compute/backup-info.md) %}


1. Under **Access**, specify the information required to access the instance:
   * (optional) Select or create a [service account](../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.
   * Enter the username in the **Login** field.

      {% note alert %}

      Do not use the `root` username or other names reserved by the OS. To perform operations that require superuser permissions, use the `sudo` command.

      {% endnote %}

   * In the **SSH key** field, paste the contents of the [public key](../operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
   * If required, grant access to the [serial console](../operations/serial-console/index.md).
1. (optional) Under **Placement**, select a VM [placement group](../concepts/placement-groups.md).
1. Click **Create VM**.

The VM appears in the list. Once created, the VM is assigned an [IP address](../../vpc/concepts/address.md) and a [host name](../../vpc/concepts/address.md#fqdn) (FQDN).