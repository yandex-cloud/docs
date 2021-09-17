To create a VM:

1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.

1. In the list of services, select **{{ compute-name }}**.

1. Click **Create VM**.

1. Under **Basic parameters**:

    - Enter a name and description for the VM. Naming requirements:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    - Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

    - (optional) Select or create a [service account](../../iam/concepts/index.md#sa). By using a service account, you can flexibly configure access rights for your resources.

1. Under **Images from {{ marketplace-name }}**:
    - Select **Windows**.
    - Select the operating system version and edition.

1. (optional) Configure the boot disk under **Disks**:
    - Specify the necessary disk size.
    - Select a [disk type](../concepts/disk.md#disks_types).

1. (optional) If you want to create an instance from an existing disk, go to **Disks** [to add a disk](../operations/vm-create/create-from-disks.md).

1. Under **Computing resources**:
    - Choose the [platform](../concepts/vm-platforms.md).
    - Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and number of vCPUs and RAM you need.
    - If necessary, make your VM [preemptible](../concepts/preemptible-vm.md).
    - (optional) Enable a [software-accelerated network](../concepts/software-accelerated-network.md).

1. Under **Network settings**:
    - Specify the subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list. If you don't have a network, click **Create a new network** to create one:
        - In the window that opens, enter a name for the new network and choose a subnet to connect the virtual machine to. Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet) (if there's no subnet, create one). Then click **Create**.
    - In the **Public IP** field, choose a method for assigning an IP address:
        - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
        - **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
        - **No address**: Don't assign a public IP address.
    - (optional) Create a record for the VM in the [DNS zone](../../dns/concepts/dns-zone.md). Expand the **DNS settings for internal addresses** section and specify the zone, FQDN, and TTL for the record. For more information, see [Yandex Cloud DNS integration with Yandex Compute Cloud](../../dns/concepts/compute-integration.md).
    - (optional) Enable [DDoS protection](../../vpc/ddos-protection/).
    - Select the [appropriate security groups](../../vpc/concepts/security-groups.md) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the VM).

1. When you create a VM, the `Administrator` user is automatically created in the operating system. In the **Password** field, set a password for this user to log in to the VM via RDP.

    {% include [password-requirements](../../_includes/compute/password-requirements.md) %}

1. Click **Create VM**.

The virtual machine appears in the list. When a VM is being created, it is assigned an [IP address](../../vpc/concepts/address) and [hostname](../../vpc/concepts/address#fqdn) (FQDN). You can use this data to access the VM via RDP.

