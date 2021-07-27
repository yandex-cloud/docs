---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Create a network load balancer

{% note info %}

Before creating a network load balancer, [create](target-group-create.md) a target group to attach to it.

{% endnote %}

{% list tabs %}

- Management console

  To create a [network load balancer](../concepts/index.md):

  1. Open the **Load Balancer** section in the folder where you want to create a load balancer.

  1. Click **Create load balancer**.

  1. Enter a name.

      {% include [name-format](../../_includes/name-format.md) %}

  1. Under **Listeners**, assign a public IP address to the listener. You can assign an address automatically or select one from the list of reserved addresses. Click **Add listener**.

  1. In the window that opens, enter the listener name and specify the port number (in the range from 1 to 32767) that the load balancer will receive incoming traffic on. Click **Add**.

  1. Turn on **Target groups**.

  1. Select the VMs to be included in the new target group, or select a previously [created](target-group-create.md) target group.

  1. In the **Health check** section, enter the health check name.

      {% include [name-format](../../_includes/name-format.md) %}

  1. Select the check type: **HTTP** or **TCP**.

  1. Specify a port number from the range 1-32767.

  1. If you chose a check via HTTP, specify the URL to perform checks for.

  1. Specify the response timeout in seconds.

  1. Specify the interval, in seconds, for sending health check requests.

  1. Set the performance threshold, which is the number of successful checks required in order to consider the VM ready to receive traffic.

  1. Specify the failure threshold, which is the number of failed checks after which no traffic will be routed to the VM.

  1. Click **Create load balancer**.

- CLI

  If you don't have the Yandex.Cloud command-line interface, [install it](https://cloud.yandex.com/docs/cli/quickstart#install).

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create a network load balancer:

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

  1. Get the list of all load balancers to make sure that the load balancer was created:

     ```
     $ yc load-balancer network-load-balancer list
     ```

- API

  You can create a new network load balancer using the [create](../api-ref/NetworkLoadBalancer/create.md) API method.

{% endlist %}

## Examples {examples}

### Creating a network load balancer without a listener {without-listener}

{% list tabs %}

- CLI

  To create a load balancer without a listener, run the following command in the terminal:

  ```
     $ yc load-balancer network-load-balancer create \
     --region-id ru-central1 \
     --name test-load-balancer-1
  ```

{% endlist %}

### Creating a network load balancer with a listener and attached target group {with-listener-and-target-group}

{% list tabs %}

- CLI

  1. To create a load balancer with a [listener](../concepts/listener.md) and immediately connect a previously [created](target-group-create.md) target group to it, get the list of target groups:

     ```
     $ yc load-balancer target-group list
     +----------------------+-------------------+---------------------+-------------+--------------+
     |          ID          |       NAME        |       CREATED       |  REGION ID  | TARGET COUNT |
     +----------------------+-------------------+---------------------+-------------+--------------+
     | b7roi767je4c574iivrk | test-target-group | 2018-12-03 14:41:04 | ru-central1 |            1 |
     +----------------------+-------------------+---------------------+-------------+--------------+
     ```

  1. Run the following command using the target group ID in the `target-group-id` parameter:

     ```
     $ yc load-balancer network-load-balancer create \
     --region-id ru-central1 \
     --name test-load-balancer-3 \
     --listener name=test-listener,external-ip-version=ipv4,port=80 \
     --target-group target-group-id=b7rjtf12qdeehrj31hri,healthcheck-name=http,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
     ```

     Mind the `healthcheck-interval` and `healthcheck-timeout` parameter format: the values must be in `Ns` format.

{% endlist %}

