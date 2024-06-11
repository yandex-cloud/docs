Creating an instance from a public [DSVM](/marketplace/products/f2e4v304qn35mhilnsbc) image:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter a name and description for the VM. The naming requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

         {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * Select an [availability zone](../../overview/concepts/geo-scope.md) to put your virtual machine in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [DSVM](/marketplace/products/yc/dsvm) image.
   1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.instances.create.section_disk }}** tab and configure a boot disk:
      * Select the [disk type](../concepts/disk.md#disks_types).
      * Specify the required disk size.
            1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** tab and attach the [file storage](../concepts/filesystem.md). [Create](../operations/filesystem/create.md) the storages first.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Choose a [platform](../concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the required number of vCPUs as well as the amount of RAM.
      * Make your VM [preemptible](../concepts/preemptible-vm.md), if required.
      * (Optional) Enable a [software-accelerated network](../concepts/software-accelerated-network.md).
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * Enter a subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list. You can select the search scope: in the current folder or in all folders. If you do not have a network, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:
         * In the window that opens, enter the folder to host the new network, as well as the network name.
         * In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, enable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** (each network must have at least one [subnet](../../vpc/concepts/network.md#subnet)).
         * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, choose a method for assigning an IP address:
         * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool.
         * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
         * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`: Do not assign a public IP address.
         * (Optional) Enable [DDoS protection](../../vpc/ddos-protection/index.md) in the **{{ ui-key.yacloud.component.compute.network-select.field_advanced }}** field, if required.
      * Select the [appropriate security groups](../../vpc/concepts/security-groups.md) in the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field.

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data required to access the VM:
      * (Optional) Select or create a [service account](../../iam/concepts/index.md#sa). With a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../operations/vm-connect/ssh.md#creating-ssh-keys) file.
      * (Optional) Enable access to the [serial console](../operations/index.md#serial-console) in the **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}** field, if required.

      {% include [vm-connect-linux](../../_includes/vm-connect-linux.md) %}

   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   The virtual machine will appear in the list. When a VM is created, it is assigned an [IP address](../../vpc/concepts/address) and [host name](../../vpc/concepts/address.md#fqdn) (FQDN).

{% endlist %}
