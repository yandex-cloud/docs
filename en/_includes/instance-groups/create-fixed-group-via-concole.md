To create a fixed-size instance group:

1. In the [management console]({{ link-console-main }}), select a folder to create your instance group in.

1. In the list of services, select {{ compute-name }}.

1. On the **Virtual machines** page, go to the **Instance groups** tab.

1. Click **Create group**.

1. Under **Basic parameters**:

    - Enter a name and description of the instance group. Naming requirements:

        {% include [name-format](../name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    - Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.

1. In the **Allocation** section, select the desired availability zones. Group instances may reside in different availability zones and regions. [Learn more about Yandex.Cloud geography](../../overview/concepts/geo-scope.md).

1. In the **Instance template** section, click **Set** to set the basic instance configuration:
    - Select a public [image](../../compute/operations/images-with-pre-installed-software/get-list.md).
    - In the **Disks** section:
        - Select the [disk type](../../compute/concepts/disk.md#disks_types).
        - Specify the disk size.
To add more disks, click **Add disk**.
    - Under **Computing resources**:
        - Choose a [platform](../../compute/concepts/vm-platforms.md).
        - Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the necessary number of vCPUs and amount of RAM.
        - {% include [include](specify-preemptible-vm.md) %}
    - Under **Network settings**:
        - Select the [cloud network](../../compute/concepts/vm.md#network) and the subnet. If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).
        - Specify if a public IP address is required.
        - Select the [cloud network](../../vpc/concepts/network.md#network) from the list, or specify its ID. If you don't have a network, click **Create a new network** to create one:
            - In the window that opens, enter a name for the new network and choose a subnet to connect the virtual machine to. Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet) (if there's no subnet, create one). Then click **Create**.
        - In the **Public IP** field, choose a method for assigning an IP address:
            - **Auto**: Assign a random IP address from the Yandex.Cloud IP pool.
            - **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
            - **No address**: Don't assign a public IP address.
        - If necessary, select [DDoS protection](../../vpc/ddos-protection/).
    - Under **Access**, specify the data required to access the VM:
        - Enter the username in the **Login** field.
        - Under **SSH key**, paste the contents of the public key file. You have to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connections on your own.
        - In the **SSH key** field, paste the contents of the [public key file](../../compute/quickstart/quick-create-linux.md#create-ssh).
    - Click **Add**.

1. Under **Allow when creating and updating**, specify:

    - The number of instances that can exceed the group size.

    - The number of instances the group size can be reduced by.

    - The number of instances that can be created simultaneously.

    - The number of instances that can be deleted simultaneously.

        For more information, see [{#T}](../../compute/concepts/instance-groups/policies/deploy-policy.md).

1. In the **Scalability** section:
    - Select the [scaling type](../../compute/concepts/instance-groups/scale.md). Currently, you can only create fixed-size groups.
    - Specify the group size.

1. Click **Create**.
The instance group appears in the list.

