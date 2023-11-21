# Stopping and starting a load balancer

You can stop and restart a network load balancer, if required.

## Stop a network load balancer {#stop}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to stop a load balancer.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the line of the load balancer to stop, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_stop }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_stop }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To stop a load balancer that is in the `ACTIVE` status, run this command:

   ```bash
   yc load-balancer network-load-balancer stop <load balancer ID or name>
   ```

   You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

- API

   To stop a network load balancer, use the [stop](../api-ref/NetworkLoadBalancer/stop.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Stop](../api-ref/grpc/network_load_balancer_service.md#Stop) gRPC API call.

   You can get the load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}

## Start a network load balancer {#start}

You can restart network load balancers that have the `Stopped` status.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to start a load balancer.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the line of the load balancer to start, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_start }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_start }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To start a load balancer that has the `STOPPED` status, run this command:

   ```bash
   yc load-balancer network-load-balancer start <load balancer ID or name>
   ```

   You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

- API

   To start a network load balancer, use the [start](../api-ref/NetworkLoadBalancer/start.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Start](../api-ref/grpc/network_load_balancer_service.md#Start) gRPC API call.

   You can get the load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}
