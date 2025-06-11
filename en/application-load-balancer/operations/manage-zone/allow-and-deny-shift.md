---
title: How to allow or deny traffic transfer between availability zones in an L7 load balancer within {{ alb-full-name }}
description: Follow this guide to allow and deny traffic transfer between availability zones in an L7 load balancer.
---

# Allowing or denying traffic transfer between availability zones

If an [availability zone](../../../overview/concepts/geo-scope.md) is under maintenance or fails, {{ yandex-cloud }} technicians may redirect traffic to other zones. This will ensure your services stay operational. Once the zone is recovered, traffic will be routed back to the zones configured for the load balancer.

You can allow or deny such traffic transfer between availability zones. You can also [test traffic transfer](start-and-cancel-shift.md) from any availability zone yourself and allow traffic transfer only for specific load balancers.

By default, traffic transfer between availability zones is not allowed.

## Allowing traffic transfer {#allow}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  When [creating](../application-load-balancer-create.md) or [updating](../application-load-balancer-update.md) an L7 load balancer, specify the `--allow-zonal-shift` parameter, e.g.:

  ```bash
  yc application-load-balancer load-balancer update \
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

  1. In the configuration file, specify the `allow_zonal_shift` parameter set to `true` in the `yandex_alb_load_balancer` resource description:

      ```hcl
      resource "yandex_alb_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = true
        ...
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will change all required resources. You can check the resources for updates in the [management console]({{ link-console-main }}).

  For more information about `yandex_alb_load_balancer` properties, see [this {{ TF }} article]({{ tf-provider-datasources-link }}/alb_load_balancer).

- API {#api}

  To allow traffic transfer when creating an L7 load balancer, use the [create](../../api-ref/LoadBalancer/create.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource and specify `"allowZonalShift": "true"`, or use the [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md) gRPC API call with `"allow_zonal_shift": "true"`.

  To allow traffic transfer when updating an L7 load balancer, use the [update](../../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource and specify `"allowZonalShift": "true"`, or use the [LoadBalancerService/Update](../../api-ref/grpc/LoadBalancer/update.md) gRPC API call with `"allow_zonal_shift": "true"`.

{% endlist %}


## Denying traffic transfer {#deny}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  When creating or updating an L7 load balancer, specify the `--allow-zonal-shift=false` parameter, e.g.:

  ```bash
  yc application-load-balancer load-balancer update \
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

  1. In the configuration file, specify the `allow_zonal_shift` parameter set to `false` in the `yandex_alb_load_balancer` resource description:

      ```hcl
      resource "yandex_alb_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = false
        ...
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will change all required resources. You can check the resources for updates in the [management console]({{ link-console-main }}).

  For more information about `yandex_alb_load_balancer` properties, see [this {{ TF }} article]({{ tf-provider-datasources-link }}/alb_load_balancer).

- API {#api}

  To deny traffic transfer when creating an L7 load balancer, use the [create](../../api-ref/LoadBalancer/create.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource and specify `"allowZonalShift": "false"`, or use the [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md) gRPC API call with `"allow_zonal_shift": "false"`.

  To deny traffic transfer when updating an L7 load balancer, use the [update](../../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource and specify `"allowZonalShift": "false"`, or use the [LoadBalancerService/Update](../../api-ref/grpc/LoadBalancer/update.md) gRPC API call with `"allow_zonal_shift": "false"`.

{% endlist %}


#### What's next {whats-next}

* [{#T}](start-and-cancel-shift.md)