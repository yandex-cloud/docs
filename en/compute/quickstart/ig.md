# Creating an instance group

Create an instance group using the [Instance Groups](../concepts/instance-groups/index.md) component in the {{ yandex-cloud }} management console.

## Getting started {#before-you-begin}

1. Log in or sign up to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it is in `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md).

## Create an instance group {#create-ig}

You can create an automatically scaled group or a group with a fixed number of instances. For more information, see [{#T}](../concepts/instance-groups/scale.md).

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

To create an instance group:
1. In the [management console]({{ link-console-main }}), select the folder to create your instance group in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
    * Enter a name and description of the instance group. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete VM instances in the instance group, assign the `editor` [role](../../iam/concepts/access-control/roles.md) to the service account. By default, all operations in {{ ig-name }} are performed on behalf of a service account.

      {% include [sa-dependence-brief](../../_includes/instance-groups/sa-dependence-brief.md) %}

1. In the **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** section, select the desired [availability zones](../../overview/concepts/geo-scope.md). Instances of a group may reside in different availability zones.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to configure a basic instance:
   * Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a description for the base instance.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select a public image.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:
     * Select the [disk type](../../compute/concepts/disk.md#disks_types).
     * Specify the disk size.
     * (Optional) Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}** to add more disks.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Choose a [platform](../../compute/concepts/vm-platforms.md).
     * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and required number of vCPUs, as well as RAM size.
     * (Optional) Specify that the VM must be [preemptible](../../compute/concepts/preemptible-vm.md).
   * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     * Select a [cloud network](../../compute/concepts/vm.md#network) and [subnet](../../compute/concepts/network.md#subnet). If there is no subnet, create one:
       * Click **{{ ui-key.yacloud.compute.instances.create.button_create-subnetwork-new }}**.
       * Enter a name and a description for the new subnet. Specify an availability zone and a CIDR.
       * Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.
     * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, choose a method for assigning an IP address:
       * `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP address pool.
       * `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`: Not to assign a public IP address.
     * (Optional) Select a [security group](../../vpc/concepts/security-groups.md). If there is no security group, create one:
       * Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.vpc-security-group-select.label_add-security-group }}**.
       * Enter a name and description for the security group. You will be able to add rules to the security group at a later stage using **{{ vpc-name }}**.
       * Click **{{ ui-key.yacloud.common.create }}**.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
     * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one.
     * If you selected a Linux-based public image:
       * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
     * If you selected a Windows-based public image:
       * In the **{{ ui-key.yacloud.common.password }}** field, set a password for the `Administrator` user. A user named `Administrator` is created automatically.
     * Click **{{ ui-key.yacloud.common.add }}**.
     * If required, grant access to the [serial console](../operations/serial-console/index.md).
   * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**, specify:
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}**: Number of instances by which you can exceed the group size.

       {% include [max-expansion-notice](../../_includes/instance-groups/max-expansion-notice.md) %}
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}**: Number of instances by which you can reduce the group size.
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}**: Number of instances that can be created simultaneously.
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}**: Initialization interval after which the instance will begin to receive load.
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}**: Number of instances you can stop simultaneously.
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}**: Instance shut-down strategy, `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}` or `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}`.

      For more information, see [{#T}](../concepts/instance-groups/policies/deploy-policy.md).
1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
   * Select the [scaling type](../../compute/concepts/instance-groups/scale.md).
   * If you selected the `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}` type, specify the size of the group.
   * If you selected `{{ ui-key.yacloud.compute.groups.create.value_scale-auto }}`, specify:
     * The minimum number of instances per availability zone.
     * Maximum group size.
     * Utilization measurement period: The period for which utilization measurements should be averaged for each instance in the group.
     * Instance warmup period: The period during which the created instance is not taken into account when measuring the average load on the group.
     * Stabilization period: The interval during which the required number of instances in the group can't be reduced.
     * Initial group size: The number of instances created with the group.
   * If you selected `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed-test-auto }}`, enter group size and autoscaling parameters. For this type, autoscaling works in test mode.
1. If you previously selected `{{ ui-key.yacloud.compute.groups.create.value_scale-auto }}` as your scaling type, under **{{ ui-key.yacloud.compute.groups.create.label_custom-metrics }}**, specify the target CPU load as a percentage.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_ylb }}**:
   * (Optional) Click the **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** toggle. [Target groups](../../network-load-balancer/concepts/target-resources.md) are required for the [network load balancer](../../network-load-balancer/concepts/index.md) to perform its function.
     * Enter a name and description for the target group.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_health-check }}**:
   * (Optional) Click the **{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}** toggle.
     * Select the check type: `HTTP` or `TCP`.
     * Specify the path for the checks.
     * Specify a port number from the range 1-32767.
     * Specify the response timeout in seconds.
     * Specify the interval, in seconds, for sending health check requests.
     * Specify the healthy threshold: number of successful checks required to consider the VM ready to receive traffic.
     * Specify the unhealthy threshold: number of failed checks after which no traffic will be routed to the VM.
1. Click **{{ ui-key.yacloud.common.create }}**.

The instance group will appear in the list.

## What's next {#what-is-next}

* Watch [tutorials for creating web services in {{ yandex-cloud }}](../../tutorials/applied/index.md#web).
* Learn [how to work with instance groups](../operations/index.md).
* Read [answers to frequently asked questions](../qa/general.md).