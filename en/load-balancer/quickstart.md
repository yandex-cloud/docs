# Getting started with {{ network-load-balancer-short-name }}

[Network load balancers](concepts/index.md) evenly distribute workload across cloud resources and monitor their status. This improves the availability and fault tolerance of your applications and cloud network infrastructure.

Create a network load balancer with a [listener](concepts/listener.md), attach a [group of target resources](concepts/target-resources), and set up [health checks](concepts/health-check.md) using {{ network-load-balancer-name }}.

## Before you start {#before-you-begin}

1. Log in to or register in the [management console](https://console.cloud.yandex.com). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page](https://console.cloud.yandex.com/billing), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder yet, [create one](../resource-manager/operations/folder/create.md).
1. [Create](../compute/quickstart/quick-create-linux.md) multiple VMs in advance to include them in the target group attached to the network load balancer. For testing, you can use inexpensive [preemptible VMs](../compute/concepts/preemptible-vm.md).

## Create a target group {#create-target-group}

[A target group](concepts/target-resources.md) consists of cloud resources that the network load balancer distributes traffic across.

To create a target group:

1. Open the **Load Balancer** section in the folder where you want to create a target group.
1. Open the **Target group** tab.
1. Click **Create target group**.
1. Enter a name for the target group, like `test-target-group`.
1. Select the VMs to add to the target group.
1. Click **Create target group**.

## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to create a listener that the load balancer will use to receive traffic. You also need to set up health checks for resources in the attached target group.

To create a network load balancer:

1. Open the **Load balancers** tab.
1. Click **Create load balancer**.
1. Enter a name for the load balancer, like `test-load-balancer`.
1. In the **Public IP** field, choose a method for assigning an IP address:
    - **Auto**: Assign a random IP address from the Yandex.Cloud IP pool.
    - **List**: Select a public IP address from the list of previously reserved static addresses. Learn more in [{#T}](../vpc/operations/set-static-ip.md).
1. (optional) Enable [DDoS protection](../vpc/ddos-protection/).
1. Click **Add listener**.
    - In the window that opens, enter a name for the listener, like `listener-1`.
    - Specify the port number (from 1 to 32767) that the listener receives traffic on. This port must match the port that the VMs receive traffic on.
    - Click **Add**.
1. Turn on **Target groups**.
    - Select the target group that you created.
    - Under **Health check**, enter a name for the health check, like `health-check-1`.
    - Select the check type: **TCP** or **HTTP**.
    - Specify a port number from the range 1-32767.
    - If you chose HTTP, specify the URL to check. You can leave the default path: `/`.
    - Specify the response timeout in seconds.
    - Specify the interval, in seconds, for sending health check requests. The interval must be at least 1 second longer than the timeout.
    - Set the performance threshold, which is the number of successful checks required in order to consider the VM ready to receive traffic.
    - Specify the failure threshold, which is the number of failed checks after which no traffic will be routed to the VM.
1. Click **Create load balancer**.

## Perform resource health checks {#health-check}

To check the [status of the network load balancer](concepts/index.md#lb-statuses) and resources in the attached target group:

1. Open the page of the created network load balancer.
1. Make sure the load balancer status is `ACTIVE`, which means it's ready to transmit traffic to the targets.
1. Look at the **Target group** section. If the VMs are running and ready to receive traffic, their status must be `HEALTHY`.
1. Open the {{ compute-name }} page and [stop](../compute/operations/vm-control/vm-stop-and-start.md#stop) one of the VMs in the target group.
1. Go back to the load balancer page and make sure that the stopped VM status is `UNHEALTHY`. This means that the target from the group failed the health check and isn't ready to receive traffic.

## Delete a network load balancer and the resources created {#delete-resources}

If you no longer need a load balancer, [delete it](operations/load-balancer-delete.md).

Then [delete the target group](operations/target-group-delete.md) and [VMs](../compute/operations/vm-control/vm-delete.md).

## What's next {#what-is-next}

* Learn more about how [network load balancers](concepts/index.md) work.
* See our [recommendations](best-practices.md) for working with load balancers.

