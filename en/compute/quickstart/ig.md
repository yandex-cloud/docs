# Creating instance groups

Create an instance group using the [Instance Groups](../concepts/instance-groups/index.md) component in the {{ yandex-cloud }} management console.

## Before you start {#before-you-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [payment account](../../billing/concepts/billing-account.md), and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Creating an instance group {#create-ig}

You can create an automatically scaled group or a group with a fixed number of instances. Learn more in [{#T}](../concepts/instance-groups/scale.md).

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

To create an instance group:

1. In the [management console]({{ link-console-main }}), select a folder to create your instance group in.
1. In the list of services, select **{{ compute-name }}**.
1. Go to the **Instance groups** tab.
1. Click **Create group**.
1. Under **Basic parameters**:

    - Enter a name and description of the instance group. Naming requirements:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    - Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.
1. In the **Allocation** section, select the desired availability zones. Group instances may reside in different availability zones and regions. [Learn more about {{ yandex-cloud }} geography](../../overview/concepts/geo-scope.md).
1. In the **Instance template** section, click **Set** to set the basic instance configuration:
    - Under **Basic parameters**:
        - Enter a description for the basic instance.
        - Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one.
    - Select a public [image](../../compute/operations/images-with-pre-installed-software/get-list.md).
    - In the **Disks** section:
        - Select the [disk type](../../compute/concepts/disk.md#disks_types).
        - Specify the disk size.
        - (optional) Click **Add disk** to add more disks.
    - Under **Computing resources**:
        - Choose the [platform](../../compute/concepts/vm-platforms.md).
        - Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and number of vCPUs and RAM you need.
        - (optional) Specify that the VM must be [preemptible](../../compute/concepts/preemptible-vm.md).
    - Under **Network settings**:
        - Select the [cloud network](../../compute/concepts/vm.md#network) and the subnet. If there is no network, create one:
            - Click **Create new network**.
            - Enter a name for the new network and choose the network to connect the instance group to.
            - Select a subnet or create a new one. Each network must have at least one subnet.
            - Click **Create**.
        - In the **Public IP** field, choose a method for assigning an IP address:
            - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
            - **No address**: Don't assign a public IP address.
    - Under **Access**:
        - If you selected a Linux-based public image:
            - Enter the username in the **Login** field.
            - Under **SSH key**, paste the contents of the public key file. You have to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connections on your own.
        - If you selected a Windows-based public image:
            - In the **Password** field, set a password for the `Administrator` user. The `Administrator` user is created automatically.
        - Click **Add**.
1. Under **Allow when creating and updating**, specify:

    - The number of instances that can exceed the group size.
    - The number of instances the group size can be reduced by.
    - The number of instances that can be created simultaneously.
    - The number of instances that can be deleted simultaneously.

        For more information, see [{#T}](../../compute/concepts/instance-groups/policies/deploy-policy.md).
1. In the **Scalability** section:
    - Select the [scaling type](../../compute/concepts/instance-groups/scale.md).
    - If you selected the **Fixed** type, specify the size of the group.
    - If you selected **Automatic**, specify:
        - The minimum number of instances per availability zone.
        - Maximum group size.
        - Utilization measurement period: The period for which utilization measurements should be averaged for each instance in the group.
        - Instance warmup period: The period during which the created instance is not taken into account when measuring the average load on the group.
        - Stabilization period: The interval during which the required number of instances in the group can't be reduced.
        - Initial group size: The number of instances created with the group.
        - Target CPU performance level. Set as a percentage.
1. Under **Integration with Load Balancer**:

    - (optional) Click the **Create target group** toggle. [Target groups](../../network-load-balancer/concepts/target-resources.md) are necessary for the [network load balancer](../../network-load-balancer/concepts/index.md) to distribute loads.
        - Enter a name and description for the target group.
1. Under **Health checks**:

    - (optional) Click the **Activate** toggle.
       - Select the check type: **HTTP** or **TCP**.
       - Specify a port number from the range 1-32767.
       - If you chose the HTTP check, specify the URL to perform checks for.
       - Specify the response timeout in seconds.
       - Specify the interval, in seconds, for sending health check requests.
       - Set the healthy threshold, which is the number of successful checks required in order to consider the VM ready to receive traffic.
       - Set the unhealthy threshold, which is the number of failed checks after which no traffic will be routed to the VM.
1. Click **Create**.

The instance group appears in the list.

## What's next {#what-is-next}

- Watch [tutorials for creating web services in {{ yandex-cloud }}](../../tutorials/web/index.md).
- Learn [how to work with instance groups](../operations/index.md).
- Read [answers to frequently asked questions](../qa/general.md).

