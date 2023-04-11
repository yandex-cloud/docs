# Creating a VM from a public image

To create a VM:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
   1. Click **Create resource**.
   1. Select **Virtual machine**.
   1. In the **Name** field, enter a name for the VM.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Select an [availability zone](../../../overview/concepts/geo-scope.md) to put your virtual machine in.
   1. Select a public image with the software you want to use.
   1. (optional) If you wish to add more disks to the virtual machine, [select them](../vm-create/create-from-disks.md) under **Disks and file storage** by clicking the **Disks** tab.
         1. (optional) If you wish to connect more file stores to the virtual machine, attach them under **Disks and file storage** by clicking the **File stores** tab. [Create](../filesystem/create.md) the storages first.
   1. Under **Computing resources**:
      * Choose a [platform](../../concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../concepts/performance-levels.md) and the required number of vCPUs as well as the amount of RAM.

      {% note info %}

      Each public image has its own minimum requirements for a virtual machine. A [GitLab](/marketplace/products/yc/gitlab) image from {{ marketplace-name }}, for instance, requires at least 4 virtual cores and 8 GB of RAM.

      {% endnote %}

   1. Under **Network settings**:
      * Enter a subnet ID or select a [cloud network](../../../vpc/concepts/network.md#network) from the list. You can select the search scope: in the current folder or in all folders. If you don't have a network, click **Create network** to create one:
         * In the window that opens, enter the folder to host the new network, as well as the network name.
         * Enable the option **Create subnets**: each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet).
         * Click **Create**.
      * In the **Public IP** field, choose a method for assigning an IP address:
         * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
         * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
         * **No address**: Do not assign a public IP address.
            * (optional) If necessary, enable [DDoS protection](../../../vpc/ddos-protection/index.md).
      * Select the [appropriate security groups](../../../vpc/concepts/security-groups.md).

         {% include [security-groups-note-vm](../../../_includes/vpc/security-groups-note-vm.md) %}

   1. Under **Access**, specify the data required to access the VM:
      * (optional) Select or create a [service account](../../../iam/concepts/index.md#sa). By using a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the [public key](../vm-connect/ssh.md#creating-ssh-keys) file.
      * (optional) If necessary, enable access to the [serial console](../index.md#serial-console).
   1. Specify data required for accessing the VM.
   1. Click **Create VM**.

   VM creation takes several minutes. When the VM status changes to `RUNNING`, proceed to [configuring software](setup.md). You can monitor VM statuses on the list of VMs in the folder.

{% endlist %}
