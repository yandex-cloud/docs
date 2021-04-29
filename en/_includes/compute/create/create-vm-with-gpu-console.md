To create a VM:

1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.

1. In the list of services, select **{{ compute-name }}**.

1. Click **Create VM**.

1. Under **Basic parameters**:

   - Enter a name and description for the VM.

     {% include [name-fqdn](../name-fqdn.md) %}

   - (optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.

   - Select the [availability zone](../../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Images from {{ marketplace-name }}**, select one of the GPU-oriented images and OS version.

   {% include [gpu-os](../gpu-os.md) %}

1. (optional) Configure the boot disk under **Disks**:
   - Specify the necessary disk size.
   - Select the [disk type](../../../compute/concepts/disk.md#disks_types).
     If you want to create an instance from an existing disk, go to **Disks** [add a disk](../../../compute/operations/vm-create/create-from-disks.md).

1. Under **Computing resources**:
   - Choose the [platform](../../../compute/concepts/vm-platforms.md#gpu-platforms) Intel Broadwell with NVIDIA® Tesla® v100.
   - Choose the [configuration](../../../compute/concepts/gpus.md#config) of the VM by specifying the required number of GPUs.
   - If necessary, make your VM [preemptible](../../../compute/concepts/preemptible-vm.md).

1. Under **Network settings**:
   - Specify the subnet ID or select a [cloud network](../../../vpc/concepts/network.md#network) from the list. If you don't have a network, click **Create a new network** to create one:
     - In the window that opens, enter a name for the new network and choose a subnet to connect the virtual machine to. Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet) (if there's no subnet, create one). Then click **Create**.
   - In the **Public IP** field, choose a method for assigning an IP address:
     - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
     - **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
     - **No address**: Don't assign a public IP address.
   - (optional) Enable [DDoS protection](../../../vpc/ddos-protection/index.md).

1. Under **Access**, specify the data required to access the VM:

   - Enter the username in the **Login** field.

     {% note alert %}

     Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

     {% endnote %}

   - In the **SSH key** field, paste the contents of the [public key file](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Click **Create VM**.

The virtual machine appears in the list.