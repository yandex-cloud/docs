# Create a network load balancer

> [!NOTE]
>
> Before creating a load balancer, [create](target-group-create.md) a target group to attach to it.

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

**[!TAB CLI]**

If you don't have the Yandex.Cloud command line interface yet, [install it](https://cloud.yandex.ru/docs/cli/quickstart#install).

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

1. See the description of the CLI's create network load balancer command:

   ```
   $ yc load-balancer network-load-balancer create --help
   ```

1. To create a load balancer with a [listener](../concepts/listener.md), run the following command in the terminal:

      ```
      $ yc load-balancer network-load-balancer create \
      --region-id ru-central1 \
      --name test-load-balancer-2 \
      --listener name=test-listener,external-ip-version=ipv4,port=80
      ```

1. Get a list of all load balancers to make sure the load balancer has been created:

   ```
   $ yc load-balancer network-load-balancer list
   ```

**[!TAB API]**

You can create a new load balancer using the [create](../api-ref/NetworkLoadBalancer/create.md) API method.

---

## Examples

### Creating a load balancer without a listener

---

**[!TAB CLI]**

To create a load balancer without a listener, run the following command in the terminal:

   ```
   $ yc load-balancer network-load-balancer create \
   --region-id ru-central1 \
   --name test-load-balancer-1
   ```

---

### Adding a listener to a load balancer

---
**[!TAB CLI]**

To add a listener to a load balancer, run the following command in the terminal:

   ```
   $ yc load-balancer network-load-balancer add-listener b7r97ah2jn5rmo6k1dsk \
   --listener name=test-listener,port=80,external-ip-version=ipv4
   ```
---

### Creating a load balancer with a listener and an attached target group

---

**[!TAB CLI]**

1. To create a load balancer with a [listener](../concepts/listener.md) and immediately attach a previously [created](target-group-create.md) target group, get a list of target groups:

   ```
   $ yc load-balancer target-group list
   +----------------------+-------------------+---------------------+-------------+--------------+
   |          ID          |       NAME        |       CREATED       |  REGION ID  | TARGET COUNT |
   +----------------------+-------------------+---------------------+-------------+--------------+
   | b7roi767je4c574iivrk | test-target-group | 2018-12-03 14:41:04 | ru-central1 |            1 |
   +----------------------+-------------------+---------------------+-------------+--------------+
   ```

1. Run the following command using the ID of the required target group in the `target-group-id` parameter:

   ```
   $ yc load-balancer network-load-balancer create \
   --region-id ru-central1 \
   --name test-load-balancer-3 \
   --listener name=test-listener,external-ip-version=ipv4,port=80 \
   --target-group target-group-id=b7rjtf12qdeehrj31hri,healthcheck-name=http,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
   ```

   Pay attention to the format of the `healthcheck-interval` and `healthcheck-timeout` parameters: their values must be specified in `Ns` format.

---

