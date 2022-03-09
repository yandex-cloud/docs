To create a VM:

1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
1. In the list of services, select **{{ compute-name }}**.
1. Click **Create VM**.
1. Under **Basic parameters**:

    * Enter a name and description for the VM. Naming requirements:

        {% include [name-format](../../name-format.md) %}

        {% include [name-fqdn](../name-fqdn.md) %}

    * Select the [availability zone](../../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Image/boot disk selection**, on the **{{ marketplace-name }}** tab, select one of the GPU-oriented [images](../../../compute/operations/images-with-pre-installed-software/get-list.md) and the OS version.

    {% include [gpu-os](../gpu-os.md) %}

1. (optional) Under **Disks**, click **Add disk** and configure the boot disk:

    * Enter the disk name.
    * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
    * Specify the desired block size.
    * Specify the necessary disk size.
    * (optional) Enable the **Delete with the VM** option if you need to automatically delete the disk when deleting the VM it will be attached to.
    * Click **Add**.

        If you want to create a VM from an existing disk, [add a disk](../../../compute/operations/vm-create/create-from-disks.md).

1. (optional) Under **File storages**, attach the [file storage](../../../compute/concepts/filesystem.md) and enter the device name.
1. Under **Computing resources**:
    * Choose a [platform](../../../compute/concepts/vm-platforms.md#gpu-platforms):
        * {{ v100-broadwell }}.
        * {{ v100-cascade-lake }}.
        * {{ a100-epyc }}.
    * Choose the [configuration](../../../compute/concepts/gpus.md#config) of the virtual machine by specifying the required number of GPUs.
    * If necessary, make your VM [preemptible](../../../compute/concepts/preemptible-vm.md).

1. Under **Network settings**:
    * Specify the subnet ID or select a [cloud network](../../../vpc/concepts/network.md#network) from the list.
        If you don't have a network, click **Create network** to create one:
        * In the window that opens, enter the network name and folder to host the network.
        * (optional) To automatically create subnets, select the **Create subnets** option.
        * Click **Create**.
        Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **Add subnet**.
    * In the **Public IP** field, choose a method for assigning an IP address:
        * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool. In this case, you can enable [protection from DDoS attacks](../../../vpc/ddos-protection/index.md) using the option below.
        * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
        * **No address**: Don't assign a public IP address.
    * In the **Internal address** field, select the method for assigning internal addresses: **Auto** or **Manual**.
    * (optional) Create a record for the VM in the [DNS zone](../../../dns/concepts/dns-zone.md). Expand the **DNS settings for internal addresses** section, click **Add record** and specify the zone, FQDN and TTL for the record. For more information, see [Yandex Cloud DNS integration with Yandex Compute Cloud](../../../dns/concepts/compute-integration.md).
    * Select the [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the VM).

1. Under **Access**, specify the data required to access the VM:

    * (optional) Select or create a [service account](../../../iam/concepts/index.md#sa). By using a service account, you can flexibly configure access rights for your resources.

        For VMs with a Linux-based operating system:

    * Enter the username in the **Login** field.

     {% note alert %}

     Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

     {% endnote %}

    * In the **SSH key** field, paste the contents of the [public key file](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

        For VMs with a Windows-based operating system:

    * When you create a VM, the `Administrator` user is automatically created in the operating system. In the **Password** field, set a password for this user to log in to the VM via RDP.

        {% include [password-requirements](../../compute/password-requirements.md) %}

    * (optional) If needed, grant access to the [serial console](../../../compute/operations/index.md#serial-console).

1. Click **Create VM**.

The virtual machine appears in the list.
