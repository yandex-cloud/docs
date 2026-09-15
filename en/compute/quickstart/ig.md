# Creating an instance group

Create an instance group using [Instance Groups](../concepts/instance-groups/index.md) in the {{ yandex-cloud }} management console.

## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up. If you have not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md).

## Creating an instance group {#create-ig}

You can create an autoscaling instance group or group with a fixed number of VM instances. For more information, see [{#T}](../concepts/instance-groups/scale.md).

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

To create an instance group:
1. In the [management console]({{ link-console-main }}), select the folder you want to create your instance group in.
1. [Navigate]({{ link-console-main }}/link/compute) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
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

    * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the public image the group's instances will operate based on.
    * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:

        * Select the [disk type](../../compute/concepts/disk.md#disks-types).
        * Specify the disk size.
        * Optionally, click **{{ ui-key.yacloud.common.add }}** to add more disks or file storages.
    * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select one of the preset instance configurations or navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab to create a custom configuration.
    * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

        * Select a [cloud network](../../compute/concepts/vm.md#network) and [subnet](../../compute/concepts/network.md#subnet). If your network has no subnets, create one:

            * Expand the dropdown list and click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.compute.instances.create.button_create-subnetwork-new }}**.
            * Enter a name and a description for the new subnet. Specify availability zone and CIDR.
            * Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.
        * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select the IP address assignment method:

            * `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`: To assign a random IP address from the {{ yandex-cloud }} IP address pool.
            * `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`: Do not assign a public IP address.
        * Optionally, select a [security group](../../vpc/concepts/security-groups.md). If there is no security group, create one:

            * Expand the dropdown list and click **{{ ui-key.yacloud.component.network-subnet-select.button_create-security-group }}**.
            * Enter a name and description for the security group.
            * Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.vpc.network.security-groups.content-section.button_add-rule }}** to create the required [rules](../../vpc/concepts/security-groups.md#security-groups-structure) in the security group.
            * Click **{{ ui-key.yacloud.common.create }}**.
    * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

        * Select **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}** to [connect](../../compute/operations/vm-connect/os-login.md) and manage access to your instances using [{{ oslogin }}](../../organization/concepts/os-login.md) in {{ org-full-name }}.

            With {{ oslogin }}, you can connect to VMs using SSH keys and SSH certificates via a standard SSH client or the [{{ yandex-cloud }} CLI](../../cli/quickstart.md). {{ oslogin }} enables rotating the SSH keys used to access VMs, providing the most [secure](../../security/domains/iaas-checklist.md#vm-security) access option.
        * If you prefer not to use {{ oslogin }}, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the following VM access data:

            * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username.

                {% note alert %}

                Do not use `root` or other [OS-reserved usernames](https://github.com/canonical/subiquity/blob/main/reserved-usernames). For operations requiring root privileges, use the `sudo` command.

                {% endnote %}

            * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

        {% include [vm-connect-linux](../../_includes/vm-connect-linux.md) %}

    * Optionally, expand the **{{ ui-key.yacloud.compute.instances.create.section_additional }}** section and do the following in the fields that appear:

        * Select the [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one.
        * Optionally, enable access to the [serial console](../concepts/serial-console.md).
    * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**, specify the following:

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
1. Optionally, under **{{ ui-key.yacloud.compute.groups.create.section_ylb }}**, enable **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** and enter the target group name and description.

    [Target groups](../../network-load-balancer/concepts/target-resources.md) enable the [network load balancer](../../network-load-balancer/concepts/index.md) to distribute traffic effectively.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_health-check }}**:

    * Optionally, enable **{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}**.

        * Select either `HTTP` or `TCP` for the check type.
        * Specify the path for the checks.
        * Specify a port from the range from 1 to 32767.
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
