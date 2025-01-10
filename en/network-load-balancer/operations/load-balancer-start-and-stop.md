# Stopping and starting a load balancer

You can stop and restart a network load balancer, if required.

## Stop a network load balancer {#stop}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you need to stop a load balancer.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. In the line of the load balancer you need to stop, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Stop**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To stop a load balancer in the `ACTIVE` status, run this command:

  ```bash
  yc load-balancer network-load-balancer stop <load_balancer_name_or_ID>
  ```

  You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

- API {#api}

  To stop a network load balancer, use the [stop](../api-ref/NetworkLoadBalancer/stop.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Stop](../api-ref/grpc/NetworkLoadBalancer/stop.md) gRPC API call.

  You can get the load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}

## Start a network load balancer {#start}

You can restart a network load balancer in the `Stopped` status.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you need to start a load balancer.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. In the line of the load balancer you need to start, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Start**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To start a load balancer in the `STOPPED` status, run this command:

  ```bash
  yc load-balancer network-load-balancer start <load_balancer_name_or_ID>
  ```

  You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

- API {#api}

  To start a network load balancer, use the [start](../api-ref/NetworkLoadBalancer/start.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Start](../api-ref/grpc/NetworkLoadBalancer/start.md) gRPC API call.

  You can get the load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}
