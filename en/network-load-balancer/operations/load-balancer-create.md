# Create a network load balancer

{% note info %}

Before creating a network load balancer, [create](target-group-create.md) a target group to attach to it.

{% endnote %}

{% list tabs %}

- Management console

   To create a [network load balancer](../concepts/index.md).

   1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. Click **Create a network load balancer**.
   1. Enter a name.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Assign a public IP address to the load balancer. You can assign an address automatically or select one from the list of reserved addresses.
   1. Under **Listeners**, click **Add listener**.
   1. In the window that opens, set the listener parameters:

      * **Name**.
      * **Port** in the range of 1 to 32767 that the load balancer will receive incoming traffic on.
      * **Target port** in the range of 1 to 32767 that the load balancer will send traffic to.

   1. Click **Add**.
   1. Under **Target groups,** click **Add target group**.
   1. Select a target group or [create a new one](target-group-create.md):

      * Click **Create target group**.
      * Enter the name of the target group.

         {% include [name-format](../../_includes/name-format.md) %}

      * Select the VMs to add to the target group.
      * Click **Create**.

   1. (optional) Under **Health check**, click **Configure** and in the window that opens:

      * Enter the health check name.

         {% include [name-format](../../_includes/name-format.md) %}

      * Select the check type: **HTTP** or **TCP**.
      * If you chose HTTP, specify the URL to check in the **Path** field.
      * Specify a port number from the range 1-32767.
      * Specify the response timeout in seconds.
      * Specify the interval, in seconds, for sending health check requests.
      * Set the performance threshold, meaning the number of successful checks required in order to consider the VM ready to receive traffic.
      * Specify the failure threshold, which is the number of failed checks after which no traffic will be routed to the VM.
      * Click **Apply**.

   1. Click **Create**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create a network load balancer:

      ```
      yc load-balancer network-load-balancer create --help
      ```

   1. To create a load balancer with a [listener](../concepts/listener.md), run the following command in the terminal:

      ```
      yc load-balancer network-load-balancer create \
        --region-id ru-central1 \
        --name test-load-balancer-2 \
        --listener name=test-listener,external-ip-version=ipv4,port=80
      ```

   1. Get the list of all load balancers to make sure that the load balancer was created:

      ```
      yc load-balancer network-load-balancer list
      ```

- API

   You can create an new load balancer using the [create](../api-ref/NetworkLoadBalancer/create.md) API method.

{% endlist %}

## Examples

### Creating a network load balancer without a listener {without-listener}

{% list tabs %}

- CLI

   To create a load balancer without a listener, run the following command in the terminal:

   ```
   yc load-balancer network-load-balancer create \
     --region-id ru-central1 \
     --name test-load-balancer-1
   ```

{% endlist %}

### Creating a network load balancer with a listener and attached target group {with-listener-and-target-group}

{% list tabs %}

- CLI

   1. To create a load balancer with a [listener](../concepts/listener.md) and immediately connect a previously [created](target-group-create.md) target group to it, get the list of target groups:

      ```
      yc load-balancer target-group list
      ```

      Result:

      ```
      +----------------------+-------------------+---------------------+-------------+--------------+
      |          ID          |       NAME        |       CREATED       |  REGION ID  | TARGET COUNT |
      +----------------------+-------------------+---------------------+-------------+--------------+
      | b7roi767je4c574iivrk | test-target-group | 2018-12-03 14:41:04 | ru-central1 |            1 |
      +----------------------+-------------------+---------------------+-------------+--------------+
      ```

   1. Run the following command using the target group ID in the `target-group-id` parameter:

      ```
      yc load-balancer network-load-balancer create \
        --region-id ru-central1 \
        --name test-load-balancer-3 \
        --listener name=test-listener,external-ip-version=ipv4,port=80 \
        --target-group target-group-id=b7rjtf12qdeehrj31hri,healthcheck-name=http,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
      ```

      Mind the `healthcheck-interval` and `healthcheck-timeout` parameter format: the values must be in `Ns` format.

{% endlist %}