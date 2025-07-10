---
title: How to allow or deny zonal shift for a {{ network-load-balancer-full-name }}
description: Follow this guide to allow or deny zonal shift for a network load balancer.
---


# Allowing or denying zonal shift

{% include [about-zone-shift](../../../_includes/network-load-balancer/about-zone-shift.md) %}

You can also manually enable or disable specific availability zones and [test zonal shift](disable-enable-zone.md) from any of them. After the test, you can allow zonal shift only for specific load balancers.

By default, zonal shift is not allowed.


## Allowing zonal shift {#allow}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  When [creating](../load-balancer-create.md) or [updating](../load-balancer-update.md) a network load balancer, set the `--allow-zonal-shift` parameter, for example:

    ```bash
    yc load-balancer network-load-balancer update \
      <load_balancer_name_or_ID> \
      --allow-zonal-shift
    ```

    Result:

    ```text
    id: ds70q425egoe********
    name: my-balancer
    ...
    allow_zonal_shift: true
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, specify the `allow_zonal_shift` parameter set to `true` in the `yandex_lb_network_load_balancer` resource description:

      ```hcl
      resource "yandex_lb_network_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = true
        ...
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will update all required resources. You can check the resource update using this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc load-balancer network-load-balancer get \
        <load_balancer_name_or_ID>
      ```

  For more information about `yandex_lb_network_load_balancer` properties, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/lb_network_load_balancer).

- API {#api}

  To allow zonal shift when creating a network load balancer, use the [create](../../api-ref/NetworkLoadBalancer/create.md) REST API method for the [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) resource and set `"allowZonalShift": "true"`, or use the [NetworkLoadBalancerService/Create](../../api-ref/grpc/NetworkLoadBalancer/create.md) gRPC API call and set `"allow_zonal_shift": "true"`.

  To allow zonal shift when updating a network load balancer, use the [update](../../api-ref/NetworkLoadBalancer/update.md) REST API method for the [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) resource and set `"allowZonalShift": "true"`, or use the [NetworkLoadBalancerService/Update](../../api-ref/grpc/NetworkLoadBalancer/update.md) gRPC API call and set `"allow_zonal_shift": "true"`.

{% endlist %}


## Denying zonal shift {#deny}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  When creating or updating a network load balancer, set `--allow-zonal-shift=false`, for example:

    ```bash
    yc load-balancer network-load-balancer update \
      <load_balancer_name_or_ID> \
      --allow-zonal-shift=false
    ```

    Result:

    ```text
    id: ds70q425egoe********
    name: my-balancer
    ...
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, specify the `allow_zonal_shift` parameter set to `false` in the `yandex_lb_network_load_balancer` resource description:

      ```hcl
      resource "yandex_lb_network_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = false
        ...
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will update all required resources. You can check the resource update using this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc load-balancer network-load-balancer get \
        <load_balancer_name_or_ID>
      ```

  For more information about `yandex_lb_network_load_balancer` properties, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/lb_network_load_balancer).

- API {#api}

  To deny zonal shift when creating a network load balancer, use the [create](../../api-ref/NetworkLoadBalancer/create.md) REST API method for the [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) resource and set `"allowZonalShift": "false"`, or use the [NetworkLoadBalancerService/Create](../../api-ref/grpc/NetworkLoadBalancer/create.md) gRPC API call and set `"allow_zonal_shift": "false"`.

  To deny zonal shift when updating a network load balancer, use the [update](../../api-ref/NetworkLoadBalancer/update.md) REST API method for the [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) resource and set `"allowZonalShift": "false"`, or use the [NetworkLoadBalancerService/Update](../../api-ref/grpc/NetworkLoadBalancer/update.md) gRPC API call and set `"allow_zonal_shift": "false"`.

{% endlist %}


#### What's next {whats-next}

* [{#T}](disable-enable-zone.md)