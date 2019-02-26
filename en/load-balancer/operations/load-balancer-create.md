# Create a network load balancer

> [!NOTE]

Before creating a load balancer, [create](target-group-create.md) a target group to attach to it.

---

**[!TAB Management console]**

To create a [network load balancer](../concepts/index.md):

1. Open the **Load Balancer** section in the folder where you want to create a load balancer.

1. Click **Create load balancer**.

1. Enter a name.

    [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Turn on **Target groups**

1. Choose the previously [created](target-group-create.md) target group.

1. In the **Health check** section, enter the health check name.

    [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Select the check type: **TCP** or **HTTP**.

1. Specify a port number from the range 1-32767.

1. If you chose a check via HTTP, specify the URL to perform checks for.

1. Specify the response timeout in seconds.

1. Specify the interval, in seconds, for sending health check requests.

1. Set the performance threshold, i.e., the number of successful checks required in order to consider the VM ready to receive traffic.

1. Specify the failure threshold, i.e., the number of failed checks after which no traffic will be routed to the VM.

1. Click **Add listener**.

1. In the window that opens, specify the port number (in the range from 1 to 32767) that the load balancer will receive incoming traffic on. The specified port number must match the port numbers that the VMs receive traffic on.

1. Click **Add**.

1. Click **Create load balancer**.

**[!TAB API]**

You can create a new load balancer using the [create](../api-ref/NetworkLoadBalancer/create.md) API method.

---

