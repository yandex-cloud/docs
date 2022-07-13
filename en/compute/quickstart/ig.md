# Creating instance groups

Create an instance group using the [Instance Groups](../concepts/instance-groups/index.md) component in the {{ yandex-cloud }} management console.

## Before you begin {#before-you-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
   {% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
   {% endif %}
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Create an instance group {#create-ig}

You can create an automatically scaled group or a group with a fixed number of instances. For more information, see [{#T}](../concepts/instance-groups/scale.md).

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

To create an instance group:
1. In the [management console]({{ link-console-main }}), select a folder to create your instance group in.
1. In the list of services, select **{{ compute-name }}**.
1. On the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **Instance groups**.
1. Click **Create group**.
1. Under **Basic parameters**:
   * Enter a name and description of the instance group. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

   * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.

1. In the **Allocation** section, select the desired availability zones. {% if product == "yandex-cloud" %}Group instances may reside in different availability zones and regions. {% endif %}[More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).
1. In the **Instance template** section, click **Define** to set the base instance configuration:
   * Under **Basic parameters**:
      * Enter a description for the basic instance.
   * Select a public [image](../../compute/operations/images-with-pre-installed-software/get-list.md).
   * In the **Disks** section:
      * Select the [disk type](../../compute/concepts/disk.md#disks_types).
      * Specify the disk size.
      * (optional) Click **Add disk** to add more disks.
   * Under **Computing resources**:
      * Choose a [platform](../../compute/concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
      * (optional) Specify that the instance must be [preemptible](../../compute/concepts/preemptible-vm.md).
   * Under **Network settings**:
      * Select a [cloud network](../../compute/concepts/vm.md#network) and [subnet](../../compute/concepts/network.md#subnet). If there is no subnet, create one:
         * Click **Create subnet**.
         * Enter a name and a description for the new subnet. Specify an availability zone and a CIDR.
         * Click **Create**.
      * In the **Public IP** field, choose a method for assigning an IP address:
         * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
         * **No address**: Don't assign a public IP address.
      * (optional) Select a security group. If there is no security group, create one:
         * Click **Add security group**.
         * Enter a name and description for the security group. You will be able to add rules to the security group at a later stage using **{{ vpc-name }}**.
         * Click **Create**.
   * Under **Access**:
      * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one.
      * If you selected a Linux-based public image:
         * Enter the username in the **Login** field.
         * In the **SSH key** field, paste the contents of the public key file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connection yourself.
      {% if product == "yandex-cloud" %}* If you selected a Windows-based public image:
         * In the **Password** field, set a password for the `Administrator` user. The `Administrator` user is created automatically.{% endif %}
      * Click **Add**.
      * If required, grant access to the [serial console](../operations/serial-console/index.md).
   * Click **Save**.
1. Under **Allow when creating and updating**, specify:
   * The number of instances that can exceed the group size.
   * The number of instances the group size can be reduced by.
   * The number of instances that can be created simultaneously.
   * Initialization interval following which the virtual machine will begin to handle load.
   * The number of instances that you can stop simultaneously.
   * Instance shut-down strategy: `Hard` or `Soft`.

      For more information, see [{#T}](../concepts/instance-groups/policies/deploy-policy.md).
1. In the **Scalability** section:
   * Select the [scaling type](../../compute/concepts/instance-groups/scale.md).
   * If you selected the **Fixed** type, specify the size of the group.
   * If you selected **Automatic**, specify:
      * The minimum number of instances per availability zone.
      * Maximum group size.
      * Utilization measurement period: The period for which utilization measurements should be averaged for each instance in the group.
      * Instance warmup period: The period during which the created instance is not taken into account when measuring the average load on the group.
      * Stabilization period: The interval during which the required number of instances in the group can't be reduced.
      * Initial group size: The number of instances created with the group.
   * If you selected **Constant with autoscaling test**, enter group size and autoscaling parameters. For this type, autoscaling works in test mode.
1. If you previously selected **Auto** as your scaling type, under **Metrics**, specify the target CPU load as a percentage.
1. Under **Integration with Load Balancer**:
   * (optional) Click the **Create target group** toggle. [Target groups](../../network-load-balancer/concepts/target-resources.md) are required for the [network load balancer](../../network-load-balancer/concepts/index.md) to perform its function.
      * Enter a name and description for the target group.
1. Under **Health checks**:
   * (optional) Click the **Activate** toggle.
      * Select the check type: **HTTP** or **TCP**.
      * Specify the path for the checks.
      * Specify a port number from the range 1-32767.
      * Specify the response timeout in seconds.
      * Specify the interval, in seconds, for sending health check requests.
      * Set the healthy threshold, which is the number of successful checks required in order to consider the VM ready to receive traffic.
      * Set the unhealthy threshold, which is the number of failed checks after which no traffic will be routed to the VM.
1. Click **Create**.

The instance group appears in the list.

## What's next {#what-is-next}

* Watch [tutorials for creating web services in {{ yandex-cloud }}](../../tutorials/web/index.md).
* Learn [how to work with instance groups](../operations/index.md).
* Read [answers to frequently asked questions](../qa/general.md).
