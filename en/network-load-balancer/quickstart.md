# Getting started with {{ network-load-balancer-short-name }}

[Network load balancers](concepts/index.md) evenly distribute workload across cloud resources and monitor their status. This improves the availability and fault tolerance of your applications and cloud network infrastructure.

Create a network load balancer with a [listener](concepts/listener.md), attach a [group of target resources](concepts/target-resources), and set up [health checks](concepts/health-check.md) using {{ network-load-balancer-name }}.

## Getting started {#before-you-begin}

1. Log in or sign up to the [management console]({{ link-console-main }}). If you are not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md).
1. [Create](../compute/quickstart/quick-create-linux.md) multiple VMs in advance to include them in the target group attached to the network load balancer. For testing, you can use inexpensive [preemptible VMs](../compute/concepts/preemptible-vm.md).

## Create a target group {#create-target-group}

A [target group](concepts/target-resources.md) consists of cloud resources that the network load balancer distributes traffic across.

To create a target group:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a target group.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. In the left-hand panel, select ![image](../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
1. Click **{{ ui-key.yacloud.load-balancer.target-group.button_create }}**.
1. Enter a name for the target group: `test-target-group`.
1. Select the VMs to add to the target group.
1. Click **{{ ui-key.yacloud.common.create }}**.


## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to create a listener that the load balancer will use to receive traffic. You also need to set up health checks for resources in the attached target group.

To create a network load balancer:

1. In the [management console]({{ link-console-main }}), select the folder to create a load balancer in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
1. Enter a name for the load balancer, such as `test-load-balancer`.
1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** field, choose a method for assigning an IP address:

   * **{{ ui-key.yacloud.common.label_auto }}**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
   * **{{ ui-key.yacloud.common.label_list }}**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../vpc/operations/set-static-ip.md).

1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
1. In the window that opens, set the listener parameters:

   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** in the range of `1` to `32767` that the load balancer will receive incoming traffic on.
   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** in the range of `1` to `32767` that the load balancer will send traffic to.

1. Click **{{ ui-key.yacloud.common.add }}**.
1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
1. Select a target group or [create a new one](operations/target-group-create.md):

   * Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
   * Enter the name of the target group. The naming requirements are as follows:

      {% include [name-format](../_includes/name-format.md) %}

   * Select the VMs to add to the target group.
   * Click **{{ ui-key.yacloud.common.create }}**.

1. (Optional) Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}** and in the window that opens:

   * Enter the health check name. The naming requirements are as follows:

      {% include [name-format](../_includes/name-format.md) %}

   * Select the check type: `{{ ui-key.yacloud.common.label_http }}` or `{{ ui-key.yacloud.common.label_tcp }}`.
   * If you chose HTTP, specify the URL to check in the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** field.
   * Enter a port number ranging from `1` to `32767`.
   * Specify the response timeout in seconds.
   * Specify the interval, in seconds, for sending health check requests.
   * Set the performance threshold, meaning the number of successful checks required in order to consider the VM ready to receive traffic.
   * Specify the failure threshold, which is the number of failed checks after which no traffic will be routed to the VM.
   * Click **{{ ui-key.yacloud.common.apply }}**.

1. Click **{{ ui-key.yacloud.common.create }}**.


## Perform resource health checks {#health-check}

To check the [status of the network load balancer](concepts/index.md#lb-statuses) and resources in the attached target group:

1. In the [management console]({{ link-console-main }}), select the folder to create a load balancer in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. Locate the created load balancer in the list.
1. Make sure the load balancer status is `Active`, which means it is ready to transmit traffic to the target resources.
1. Click the name of the load balancer.
1. Look at **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_attached-target-groups }}**. If the VMs are running and ready to receive traffic, their status must be `HEALTHY`.
1. Open the {{ compute-name }} page and [stop](../compute/operations/vm-control/vm-stop-and-start.md#stop) one of the VMs in the target group.
1. Go back to the load balancer page and make sure that the stopped VM status is `UNHEALTHY`. This means that the target from the group failed the health check and is not ready to receive traffic.


## Delete a load balancer and the resources created {#delete-resources}

If you no longer need a load balancer, [delete it](operations/load-balancer-delete.md).

Then [delete the target group](operations/target-group-delete.md) and [VMs](../compute/operations/vm-control/vm-delete.md).


## What's next {#what-is-next}

* Learn more about how [network load balancers](concepts/index.md) work.
* See our [recommendations](concepts/best-practices.md) on deploying a network load balancer.
