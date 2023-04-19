# Stopping and starting a load balancer

You can stop and restart a network load balancer, if required.

## Stop a network load balancer {#stop}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to stop a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to stop, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Stop**.
   1. In the window that opens, click **Stop**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To stop a load balancer that is in the `ACTIVE` status, run this command:

   ```bash
   yc load-balancer network-load-balancer stop <load balancer ID or name>
   ```

   You can get the load balancer ID and name with a [list of network load balancers in the folder](#list).

- API

   Use the [stop](../api-ref/NetworkLoadBalancer/stop.md) API method and provide the load balancer ID in the `networkLoadBalancerId` request parameter.

   You can get the load balancer ID with a [list of network load balancers in the folder](#list).

{% endlist %}

## Start a network load balancer {#start}

You can restart network load balancers that have the `Stopped` status.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to start a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to start, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Start**.
   1. In the window that opens, click **Start**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To start a load balancer that has the `STOPPED` status, run this command:

   ```bash
   yc load-balancer network-load-balancer start <load balancer ID or name>
   ```

   You can get the load balancer ID and name with a [list of network load balancers in the folder](#list).

- API

   Use the [start](../api-ref/NetworkLoadBalancer/start.md) API method and provide the load balancer ID in the `networkLoadBalancerId` request parameter.

   You can get the load balancer ID with a [list of network load balancers in the folder](#list).

{% endlist %}
