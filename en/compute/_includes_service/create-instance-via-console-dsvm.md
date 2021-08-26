Creating an instance from a public [DSVM]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/f2e4v304qn35mhilnsbc){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/marketplace/products/f2e4v304qn35mhilnsbc){% endif %} image

1. In the [management console](https://console.cloud.yandex.com), select a folder to create a VM in.
1. From the list of services, select {{ compute-name }}.
1. Click **Create VM**.
1. Under **Basic parameters**:
    - Enter a name and description for the VM. Naming requirements:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    - (optional) Select or create a [service account](../../iam/concepts/index.md#sa). By using a service account, you can flexibly configure access rights for your resources.

    - Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.
1. Under **Images from {{ marketplace-name }}**, click **Choose** and select a DSVM [image](../operations/images-with-pre-installed-software/get-list.md).
1. (optional) If you want to add additional disks to the instance, [select them](../operations/vm-create/create-from-disks.md) in the **Disks** section.
1. Under **Computing resources**:
    - Choose the [platform](../concepts/vm-platforms.md).
    - Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the necessary number of vCPUs and amount of RAM.
    - If necessary, make your VM [preemptible](../concepts/preemptible-vm.md).
    - (optional) Enable a [software-accelerated network](../concepts/software-accelerated-network.md).
1. Under **Network settings**:
    - Specify the subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list. If you don't have a network, click **Create a new network** to create one:
        - In the window that opens, enter a name for the new network and choose a subnet to connect the virtual machine to. Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet) (if there's no subnet, create one). Then click **Create**.
    - In the **Public IP** field, choose a method for assigning an IP address:
        - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
        - **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
        - **No address**: Don't assign a public IP address.
    - (optional) If necessary, enable [DDoS protection](../../vpc/ddos-protection/).
1. Under **Access**, specify the data required to access the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the [public key file](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    - (optional) If necessary, enable access to the [serial console](../operations/index.md#serial-console).
1. Click **Create VM**.

The virtual machine appears in the list. When a VM is being created, it is assigned an [IP address](../../vpc/concepts/address) and [hostname](../../vpc/concepts/address.md#fqdn) (FQDN).

