To create a VM:

1. In the [management console]({{ link-console-main }}), select a folder to create a VM in.

1. In the list of services, select **{{ compute-name }}**.

1. Click **Create VM**.

1. Under **Basic parameters**:

    - Enter a name and description for the VM. Naming requirements:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    - Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Images from {{ marketplace-name }}**, select an [image](../operations/images-with-pre-installed-software/get-list.md) and a Linux-based OS version.

1. (optional) Configure the boot disk under **Disks**:
      - Specify the necessary disk size.
      - Select a [disk type](../concepts/disk.md#disks_types).

   If you want to create an instance from an existing disk, go to **Disks** [to add a disk](../operations/vm-create/create-from-disks.md).

1. Under **Computing resources**:
    - Choose the [platform](../concepts/vm-platforms.md).
    - Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and number of vCPUs and RAM you need.
    - If necessary, make your VM [preemptible](../concepts/preemptible-vm.md).

1. Under **Network settings**:
    - Specify the subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list. If you don't have a network, click **Create a new network** to create one:
        - In the window that opens, enter a name for the new network and choose a subnet to connect the virtual machine to. Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet) (if there's no subnet, create one). Then click **Create**.
    - In the **Public IP** field, choose a method for assigning an IP address:
        - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
        - **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
        - **No address**: Don't assign a public IP address.
    - (optional) Create a record for the VM in the [DNS zone](../../dns/concepts/dns-zone.md). Expand the **DNS settings for internal addresses** section and specify the zone, FQDN, and TTL for the record. For more information, see [Yandex Cloud DNS integration with Yandex Compute Cloud](../../dns/concepts/compute-integration.md).
    - (optional) Enable [DDoS protection](../../vpc/ddos-protection/).

1. Under **Access**, specify the data required to access the VM:

    - (optional) Select or create a [service account](../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.

    - Enter the username in the **Login** field.

      {% note alert %}

      Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

      {% endnote %}

    - In the **SSH key** field, paste the contents of the [public key](../operations/vm-connect/ssh#creating-ssh-keys) file.

1. Click **Create VM**.

The virtual machine appears in the list. When a VM is being created, it is assigned an [IP address](../../vpc/concepts/address) and [hostname](../../vpc/concepts/address#fqdn) (FQDN).
