1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
   * Enter a name and description for the VM. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

   * Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an [image](../concepts/image.md) and a Linux-based OS version.
1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.instances.create.section_disk }}** tab and configure a boot [disk](../concepts/disk.md):
   * Select [disk type](../concepts/disk.md#disks_types).
   * Specify the required disk size.

      If you want to create a VM from an existing disk, under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, [add a disk](../operations/vm-create/create-from-disks.md):
      * Click **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * Enter the disk name.
      * Select [disk type](../concepts/disk.md#disks_types).
      * Specify the desired block size.
      * Specify the desired disk size.
      * (Optional) Enable the **{{ ui-key.yacloud.compute.instances.create-disk.field_additional }}** option in the **{{ ui-key.yacloud.compute.instances.create-disk.field_auto-delete }}** field if you need to automatically delete the disk when deleting the VM it will be attached to.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}`.
      * Click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.


1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** tab and attach the [file storage](../concepts/filesystem.md):
   * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
   * In the window that opens, specify the file storage.
   * Enter the device name.
   * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.


1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Choose a [platform](../concepts/vm-platforms.md).
   * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
   * If required, make your VM [preemptible](../concepts/preemptible-vm.md).
   * (Optional) Enable a [software-accelerated network](../concepts/software-accelerated-network.md).

1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   {% include [network-settings](../../_includes/compute/network-settings.md) %}


1. {% include [backup-info](../../_includes/compute/backup-info.md) %}


1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
   * (Optional) Select or create a [service account](../../iam/concepts/users/service-accounts.md). With a service account, you can flexibly configure access rights for your resources.
   * Enter username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

      {% note alert %}

      Do not use the `root` username or other names reserved by the OS. To perform operations that require superuser permissions, use the `sudo` command.

      {% endnote %}

   * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
   * If required, grant access to the [serial console](../operations/serial-console/index.md).

   {% include [vm-connect-linux](../../_includes/vm-connect-linux.md) %}

1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_placement }}**, select a VM [placement group](../concepts/placement-groups.md).
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

The VM appears in the list. Once created, the VM is assigned an [IP address](../../vpc/concepts/address.md) and a [host name](../../vpc/concepts/address.md#fqdn) (FQDN).