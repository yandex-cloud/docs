# Creating an instance group

Create an instance group using [Instance Groups](../concepts/instance-groups/index.md) in the {{ yandex-cloud }} management console.

## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up. If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md).

## Creating an instance group {#create-ig}

You can create an autoscaling instance group or group with a fixed number of VM instances. For more information, see [{#T}](../concepts/instance-groups/scale.md).

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

To create an instance group:
1. In the [management console]({{ link-console-main }}), select the folder you want to create your instance group in.
1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
    * Enter a name and description for your instance group. Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    * Select the [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete VM instances in the instance group, assign the `editor` [role](../../iam/concepts/access-control/roles.md) to the service account. By default, all operations in {{ ig-name }} are performed on behalf of a service account.

      {% include [sa-dependence-brief](../../_includes/instance-groups/sa-dependence-brief.md) %}

1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select the [availability zones](../../overview/concepts/geo-scope.md). Instances of a group may reside in different availability zones.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to configure a basic instance:
   * Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a description for the basic instance.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the public image.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:
     * Select the [disk type](../../compute/concepts/disk.md#disks_types).
     * Specify the disk size.
     * Optionally, click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}** to add more disks.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Select a [platform](../../compute/concepts/vm-platforms.md).
     * Specify the [guaranteed performance](../../compute/concepts/performance-levels.md) and required number of vCPUs, as well as RAM size.
     * Optionally, make the VM instance [preemptible](../../compute/concepts/preemptible-vm.md) by checking the relevant box.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     * Select a [cloud network](../../compute/concepts/vm.md#network) and [subnet](../../compute/concepts/network.md#subnet). If your network has no subnets, create one:
       * Click **{{ ui-key.yacloud.compute.instances.create.button_create-subnetwork-new }}**.
       * Enter a name and a description for the new subnet. Specify availability zone and CIDR.
       * Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.
     * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select an IP address assignment method:
       * `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`: To assign a random IP address from the {{ yandex-cloud }} IP address pool.
       * `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`: Not to assign a public IP address.
     * Optionally, select a [security group](../../vpc/concepts/security-groups.md). If there is no security group, create one:
       * Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.vpc-security-group-select.label_add-security-group }}**.
       * Enter a name and description for the security group. You can add rules for the security group later in **{{ vpc-name }}**.
       * Click **{{ ui-key.yacloud.common.create }}**.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
     * Select the [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one.
     * If you selected a Linux-based public image:
       * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file. You need to create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection on your own.
     * If you selected a Windows-based public image:
       * In the **{{ ui-key.yacloud.common.password }}** field, set a password for the `Administrator` user. A user named `Administrator` is created automatically.
     * Click **{{ ui-key.yacloud.common.add }}**.
     * Enable [serial console](../operations/serial-console/index.md) access, if required.
   * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**, specify:
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}**: Maximum number of instances the group size can be scaled up by.

       {% include [max-expansion-notice](../../_includes/instance-groups/max-expansion-notice.md) %}
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}**: Maximum number of instances the group size can be scaled down by.
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}**: Maximum number of instances that can be created at the same time.
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}**: Period after which the instance will start receiving traffic.
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}**: Maximum number of instances that can be stopped at the same time.
   * **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}**: Instance shut-down strategy, `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}` or `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}`.

      For more information, see [{#T}](../concepts/instance-groups/policies/deploy-policy.md).
1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
   * Select the [scaling type](../../compute/concepts/instance-groups/scale.md).
   * If you selected `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}`, specify the group size.
   * If you selected `{{ ui-key.yacloud.compute.groups.create.value_scale-auto }}`, specify:
     * Minimum number of VM instances per availability zone.
     * Maximum group size.
     * Utilization measurement period: Period used to average utilization measurements for each VM instance in a group.
     * Instance warmup period: Period during which a new VM instance is ignored when measuring the group's average load.
     * Stabilization period: Period during which the target number of VM instances in the group cannot be reduced.
     * Initial group size: Number of VM instances created along with the group.
   * If you selected `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed-test-auto }}`, specify the group size and autoscaling parameters. For this type, autoscaling works in test mode.
1. If you previously selected `{{ ui-key.yacloud.compute.groups.create.value_scale-auto }}` as your scaling type, under **{{ ui-key.yacloud.compute.groups.create.label_custom-metrics }}**, specify the target CPU utilization as a percentage.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_ylb }}**:
   * Optionally, enable **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**. [Target groups](../../network-load-balancer/concepts/target-resources.md) enable the [network load balancer](../../network-load-balancer/concepts/index.md) to distribute traffic effectively.
     * Enter a name and description for the target group.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_health-check }}**:
   * Optionally, enable **{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}**.
     * Select either `HTTP` or `TCP` for the check type.
     * Specify the path for the checks.
     * Specify a port number between 1 and 32767.
     * Specify the response timeout in seconds.
     * Specify the interval, in seconds, for sending health check requests.
     * Specify the healthy threshold, which is the number of successful checks required to consider the VM instance ready to receive traffic.
     * Specify the unhealthy threshold, which is the number of failed checks after which no traffic will be routed to the VM.
1. Click **{{ ui-key.yacloud.common.create }}**.

The instance group will appear in the list.

## What's next {#what-is-next}

* Check out [tutorials for creating web services in {{ yandex-cloud }}](../../tutorials/applied/index.md#web).
* Learn [how to use instance groups](../operations/index.md).
* Read [answers to FAQs](../qa/general.md).