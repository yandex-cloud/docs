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
1. [Navigate]({{ link-console-main }}/link/network-load-balancer/) to **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. In the left-hand panel, select ![image](../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
1. Click **{{ ui-key.yacloud.load-balancer.target-group.button_create }}**.
1. Enter `test-target-group` as the target group name.
1. Select the VMs to add to the target group.
1. Click **{{ ui-key.yacloud.common.create }}**.


## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to set up a listener to handle incoming traffic and configure health checks for the targets in the attached target group.

To create a network load balancer:
  
1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
1. [Navigate]({{ link-console-main }}/link/network-load-balancer/) to **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
1. Name the load balancer, e.g., `test-load-balancer`.
1. Select the load balancer's **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_network-load-balancer-type }}**: `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_external }}`.
1. {% include [select-external-ip](../_includes/network-load-balancer/select-external-ip.md) %}
1. {% include [add-listener](../_includes/network-load-balancer/add-listener.md) %}
1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, select the [previously](#create-target-group) created target group.
1. {% include [configure-health-check](../_includes/network-load-balancer/configure-health-check.md) %}
1. Click **{{ ui-key.yacloud.common.create }}**.


## Check the resource status {#health-check}

To check the [status of the network load balancer](concepts/index.md#lb-statuses) and targets in the attached target group:

1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
1. [Navigate]({{ link-console-main }}/link/network-load-balancer/) to **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
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
