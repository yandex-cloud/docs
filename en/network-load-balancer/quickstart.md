# Getting started with {{ network-load-balancer-short-name }}

[Network load balancers](concepts/index.md) evenly distribute traffic evenly across cloud resources and monitor their health status. This enhances the availability and fault tolerance of your apps and cloud network infrastructure.

Create a network load balancer with a [listener](concepts/listener.md), attach a [target group](concepts/target-resources), and set up [health checks](concepts/health-check.md) using {{ network-load-balancer-name }}.

## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up. If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a linked [billing account](../billing/concepts/billing-account.md) with the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md).
1. [Create](../compute/quickstart/quick-create-linux.md) multiple VMs in advance to include them in the target group attached to your network load balancer. For testing, consider using low-cost [preemptible VMs](../compute/concepts/preemptible-vm.md).

## Create a target group {#create-target-group}

A [target group](concepts/target-resources.md) consists of cloud resources that receive traffic from the network load balancer. 

To create a target group:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a target group.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. In the left-hand panel, select ![image](../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
1. Click **{{ ui-key.yacloud.load-balancer.target-group.button_create }}**.
1. Enter `test-target-group` as the target group name.
1. Select the VMs to add to the target group.
1. Click **{{ ui-key.yacloud.common.create }}**.


## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to set up a listener to handle incoming traffic and configure health checks for the targets in the attached target group.

To create a network load balancer:
  
1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
1. Name the load balancer, e.g., `test-load-balancer`.
1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** field, select an IP address assignment method:

   * **{{ ui-key.yacloud.common.label_auto }}**: To assign a random IP address from the {{ yandex-cloud }} IP address pool.
   * **{{ ui-key.yacloud.common.label_list }}**: To select a public IP address from the list of previously reserved static IP addresses. For more information, see [{#T}](../vpc/operations/set-static-ip.md).

1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
1. In the window that opens, specify these listener settings:

   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** (ranging from `1` to `32767`) on which the load balancer will listen to incoming traffic.
   * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** (ranging from `1` to `32767`) to which the load balancer will direct traffic.

1. Click **{{ ui-key.yacloud.common.add }}**.
1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
1. Select a target group or [create a new one](operations/target-group-create.md):
  
   * Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
   * Enter a name for the target group. Follow these naming requirements:

     {% include [name-format](../_includes/name-format.md) %}
  
   * Select the VMs to add to the target group.
   * Click **{{ ui-key.yacloud.common.create }}**.

1. Optionally, under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}** and in the window that opens:
  
   * Enter a name for the health check. Follow these naming requirements:

     {% include [name-format](../_includes/name-format.md) %}
  
   * Select either `{{ ui-key.yacloud.common.label_http }}` or `{{ ui-key.yacloud.common.label_tcp }}` for the check type.
   * If you selected HTTP, specify the URL for health checks in the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** field.
   * Specify a port number between `1` and `32767`.
   * Specify the response timeout in seconds.
   * Specify the interval in seconds for sending health check requests.
   * Specify the healthy threshold, i.e., the number of successful checks required to consider the VM ready to receive traffic.
   * Specify the unhealthy threshold, i.e., the number of failed checks before traffic is no longer routed to the VM.
   * Click **{{ ui-key.yacloud.common.apply }}**.
  
1. Click **{{ ui-key.yacloud.common.create }}**.


## Check the resource status {#health-check}

To check the [status of the network load balancer](concepts/index.md#lb-statuses) and targets in the attached target group:

1. In the [management console]({{ link-console-main }}), select the folder with the load balancer.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. In the list, find the load balancer you created.
1. Make sure the load balancer's status is `Active`, which means it is ready to distribute traffic across the targets.
1. Click the load balancer name.
1. Check **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_attached-target-groups }}**. If the VMs are running and ready to receive traffic, their status must be `HEALTHY`.
1. Open the {{ compute-name }} page and [stop](../compute/operations/vm-control/vm-stop-and-start.md#stop) one of the VMs in the target group.
1. Go back to the load balancer page and make sure the stopped VM's status is now `UNHEALTHY`. This means the target in the group failed the health check and is not ready to receive traffic.


## Delete the load balancer and the resources you created {#delete-resources}

If you no longer need the load balancer, [delete it](operations/load-balancer-delete.md).

Then, [delete the target group](operations/target-group-delete.md) and [VMs](../compute/operations/vm-control/vm-delete.md).


## What's next {#what-is-next}

* Learn more about how network load balancers work [here](concepts/index.md).
* See our [best practices](concepts/best-practices.md) for deploying a network load balancer.
