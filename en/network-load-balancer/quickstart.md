# Getting started with {{ network-load-balancer-short-name }}

[Network load balancers](concepts/index.md) evenly distribute workload across cloud resources and monitor their status. This improves the availability and fault tolerance of your applications and cloud network infrastructure.

Create a network load balancer with a [listener](concepts/listener.md), attach a [group of target resources](concepts/target-resources), and set up [health checks](concepts/health-check.md) using {{ network-load-balancer-name }}.

## Getting started {#before-you-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you do not yet have an account, go to the management console and follow the instructions.
1. On the [**Billing**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have any folders yet, [create one](../resource-manager/operations/folder/create.md).
1. [Create](../compute/quickstart/quick-create-linux.md) multiple VMs in advance to include them in the target group attached to the network load balancer. For testing, you can use inexpensive [preemptible VMs](../compute/concepts/preemptible-vm.md).

## Create a target group {#create-target-group}

A [target group](concepts/target-resources.md) consists of cloud resources that the network load balancer distributes traffic across.

To create a target group:

1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a target group.
1. In the list of services, select **{{ network-load-balancer-name }}**.
1. On the left-hand panel, select ![image](../_assets/trgroups.svg) **Target groups**.
1. Click **Create target group**.
1. Enter a name for the target group: `test-target-group`.
1. Select the VMs to add to the target group.
1. Click **Create**.


## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to create a listener that the load balancer will use to receive traffic. You also need to set up health checks for resources in the attached target group.

To create a network load balancer:

1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
1. In the list of services, select **{{ network-load-balancer-name }}**.
1. Click **Create a network load balancer**.
1. Enter a name for the load balancer, like `test-load-balancer`.
1. In the **Public IP** field, choose a method for assigning an IP address:

   * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
   * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../vpc/operations/set-static-ip.md).

1. Under **Listeners**, click **Add listener**.
1. In the window that opens, set the listener parameters:

   * **Name**.
   * **Port** in the range of 1 to 32767 that the load balancer will receive incoming traffic on.
   * **Target port** in the range of 1 to 32767 that the load balancer will send traffic to.

1. Click **Add**.
1. Under **Target groups,** click **Add target group**.
1. Select a target group or [create a new one](operations/target-group-create.md):

   * Click **Create target group**.
   * Enter the name of the target group.

      {% include [name-format](../_includes/name-format.md) %}

   * Select the VMs to add to the target group.
   * Click **Create**.

1. (Optional) Under **Health check**, click **Configure** and in the window that opens:

   * Enter the health check name.

      {% include [name-format](../_includes/name-format.md) %}

   * Select the check type: **HTTP** or **TCP**.
   * If you chose HTTP, specify the URL to check in the **Path** field.
   * Specify a port number from the range 1-32767.
   * Specify the response timeout in seconds.
   * Specify the interval, in seconds, for sending health check requests.
   * Set the performance threshold, meaning the number of successful checks required in order to consider the VM ready to receive traffic.
   * Specify the failure threshold, which is the number of failed checks after which no traffic will be routed to the VM.
   * Click **Apply**.

1. Click **Create**.


## Perform resource health checks {#health-check}

To check the [status of the network load balancer](concepts/index.md#lb-statuses) and resources in the attached target group:

1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
1. In the list of services, select **{{ network-load-balancer-name }}**.
1. Locate the created load balancer in the list.
1. Make sure the load balancer status is `Active`, which means it's ready to transmit traffic to the target resources.
1. Click on the name of the load balancer.
1. Look at **Target group**. If the VMs are running and ready to receive traffic, their status must be `HEALTHY`.
1. Open the {{ compute-name }} page and [stop](../compute/operations/vm-control/vm-stop-and-start.md#stop) one of the VMs in the target group.
1. Go back to the load balancer page and make sure that the stopped VM status is `UNHEALTHY`. This means that the target from the group failed the health check and isn't ready to receive traffic.


## Delete a load balancer and the resources created {#delete-resources}

If you no longer need a load balancer, [delete it](operations/load-balancer-delete.md).

Then [delete the target group](operations/target-group-delete.md) and [VMs](../compute/operations/vm-control/vm-delete.md).


## What's next {#what-is-next}

* Learn more about how [network load balancers](concepts/index.md) work.
* See our [recommendations](concepts/best-practices.md) on deploying a network load balancer.
