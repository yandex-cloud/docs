To create a VM:
1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
1. In the list of services, select **{{ compute-name }}**.
1. Click **Create VM**.
1. Under **Basic parameters**:
   * Enter a name and description for the VM. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

   * Select an [availability zone](../../overview/concepts/geo-scope.md) to put your virtual machine in.

1. Under **Image/boot disk selection**, select an [image](../operations/images-with-pre-installed-software/get-list.md) and a Windows-based operating system.

1. (optional) Under **Disk{% if product == "yandex-cloud" %} and file storage{% endif %}**, click the **Disks** tab and configure a boot disk:
   * Select the [disk type](../concepts/disk.md#disks_types).
   * Specify the necessary disk size.

      If you wish to create a virtual machine from an existing disk, under **Disks{% if product == "yandex-cloud" %} and file storage{% endif %}**, [add a disk](../operations/vm-create/create-from-disks.md):
      * Click **Add disk**.
      * Enter the disk name.
      * Select the [disk type](../concepts/disk.md#disks_types).
      * Specify the desired block size.
      * Specify the necessary disk size.
      * (optional) Enable the **Delete with the VM** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Select `Disk` as content.
      * Click **Add**.

{% if product == "yandex-cloud" %}
1. (optional) Under **Disks and file storage**, click the **File storage tab** and connect a [file store](../concepts/filesystem.md):
   * Click **Connect file storage**.
   * In the resulting window, select a file store.
   * Enter a device name.
   * Click **Connect file storage**.
      {% endif %}

1. Under **Computing resources**:
   * Choose a [platform](../concepts/vm-platforms.md).
   * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
   * If necessary, make your VM [preemptible](../concepts/preemptible-vm.md).
   * (optional) Enable a [software-accelerated network](../concepts/software-accelerated-network.md).

1. Under **Network settings**:
   * Enter a subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list.
      If you don't have a network, click **Create network** to create one:
      * In the window that opens, enter the network name and folder to host the network.
      * (optional) To automatically create subnets, select the **Create subnets** option.
      * Click **Create**.
         Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **Add subnet**.
   * In the **Public IP** field, choose a method for assigning an IP address:
      * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool. {% if product == "yandex-cloud" %}With this, you can enable [DDoS protection](../../vpc/ddos-protection/index.md) using the option below.{% endif %}
      * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
      * **No address**: Don't assign a public IP address.
   * In the **Internal address** field, select the method for assigning internal addresses: **Auto** or **Manual**.
   * (optional) Create a record for the VM in the [DNS zone](../../dns/concepts/dns-zone.md). Expand the **DNS settings for internal addresses** section, click **Add record** and specify the zone, FQDN and TTL for the record. For more information, see [Cloud DNS integration with Compute Cloud](../../dns/concepts/compute-integration.md).
   * Select [appropriate security groups](../../vpc/concepts/security-groups.md) (if there is no corresponding field, the virtual machine will be enabled for all incoming and outgoing traffic).

1. Under **Access**, specify the data required to access the VM:
   * (optional) Select or create a [service account](../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.
   * When you create a VM, the `Administrator` user is automatically created in the operating system. In the **Password** field, enter this user's password.

      {% note info %}

      If you lost your password to log in to the VM, you may need to create a new VM with a disk from a snapshot. For more information, see [{#T}](../operations/vm-connect/recovery-access.md).

      {% endnote %}

      {% include [password-requirements](../../_includes/compute/password-requirements.md) %}

   * If required, grant access to the [serial console](../operations/serial-console/index.md).

1. (optional) Under **Placement**, select a VM [placement group](../concepts/placement-groups.md).
1. Click **Create VM**.

The virtual machine appears in the list. When a VM is created, it is assigned an [IP address](../../vpc/concepts/address.md) and [hostname](../../vpc/concepts/address.md#fqdn) (FQDN). You can use this data to access the VM via RDP.
