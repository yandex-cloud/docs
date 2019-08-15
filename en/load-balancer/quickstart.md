# Getting started with {{ load-balancer-short-name }}

Network load balancers evenly distribute workload across cloud resources and monitor their status. This improves the availability and fault tolerance of your applications and cloud network infrastructure.

Create a [network load balancer](concepts/index.md) with a [listener](concepts/listener.md), attach a [group of target resources](concepts/target-resources), and set up [health checks](concepts/health-check.md) using {{ load-balancer-name }}.

## Before you start {#before-begin}

1. Log in to or register in the [management console](https://console.cloud.yandex.ru). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page](https://console.cloud.yandex.ru/billing), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder yet, [create one](../resource-manager/operations/folder/create.md).
1. [Create](../compute/quickstart/quick-create-linux.md) multiple VMs in advance to include them in the target group attached to the load balancer. For testing, you can use inexpensive [preemptible VMs](../compute/concepts/preemptible-vm.md).

## Create a target group {#create-target-group}

A target group consists of cloud resources that the network load balancer distributes traffic across.

Create a [target group](concepts/target-resources.md):

1. Open the **Load Balancer** section in the folder where you want to create the target group.

1. Open the **Target group** tab.

1. Click **Create target group**.

1. Enter a name for the target group, like `test-target-group`. Naming requirements:

    {% include [name-format](../_includes/name-format.md) %}

1. Select the VMs to add to the target group.

1. Click **Create target group**.

## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to create a listener that the load balancer will use to receive traffic. You also need to set up health checks for resources in the attached target group.

To create a network load balancer:

1. Open the **Load balancers** tab.

1. Click **Create load balancer**.

1. Enter a name for the load balancer, like `test-load-balancer`. Naming requirements:

    {% include [name-format](../_includes/name-format.md) %}

1. Click **Add listener**.

  1. In the window that opens, enter a name for the listener, like `listener-1`.

  1. Specify the port number (from 1 to 32767) that the load balancer will receive traffic on. This port must match the port that the VMs receive traffic on.

  1. Click **Add**.

1. Turn on **Target groups**.

  1. Select the target group that you created.

  1. Under **Health check**, enter a name for the health check, like `health-check-1`.

      {% include [name-format](../_includes/name-format.md) %}

  1. Select the check type: **TCP** or **HTTP**.

  1. Specify a port number from the range 1-32767.

  1. If you chose HTTP, specify the URL to check. You can leave the default path: `/`.

  1. Specify the response timeout in seconds.

  1. Specify the interval, in seconds, for sending health check requests.

  1. Set the performance threshold, which is the number of successful checks required in order to consider the VM ready to receive traffic.

  1. Specify the failure threshold, which is the number of failed checks after which no traffic will be routed to the VM.

  1. Click **Create load balancer**.

## Perform resource health checks {#health-check}

Look at the [status of the network load balancer](concepts/index.md#lb-statuses) and resources in the attached target group:

1. Open the page of the created network load balancer.
1. Make sure the load balancer status is `ACTIVE`, which means it's ready to transmit traffic to the targets.
1. Look at the **Target group** section. If the VMs are running and ready to receive traffic, their status must be `HEALTHY`.
1. Open the {{ compute-name }} page and [stop](../compute/operations/vm-control/vm-stop-and-start.md#stop) one of the VMs in the target group.
1. Go back to the page of your load balancer and make sure that the stopped VM status is `UNHEALTHY`. This means that the target from the group has failed a health check and isn't ready to receive traffic.

## Delete a load balancer and the resources created {#delete-resources}

If you no longer need a load balancer, [delete it](operations/load-balancer-delete.md).

Then [delete the target group](operations/target-group-delete.md) and [VMs](../compute/operations/vm-control/vm-delete.md).

## What's next {#whats-next}

* Learn more about how [network load balancers](concepts/index.md) work.
* See our [recommendations](best-practices.md) for working with load balancers.

