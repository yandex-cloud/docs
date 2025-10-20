---
title: How to allow/deny auto-disabling an L7 load balancer's availability zone in {{ alb-full-name }}
description: Follow this guide to allow or deny zonal shift between availability zones in an L7 load balancer.
---

# Allowing and denying availability zone shutdown

If an [availability zone](../../../overview/concepts/geo-scope.md) is under maintenance or shows signs of failure, {{ yandex-cloud }} technicians may temporarily shut down that zone. In which case the load balancer will automatically redistribute traffic among the remaining zones. As soon as the zone is back on track, it gets re-enabled, and uniform traffic distribution is resumed.

You can allow or deny auto-disabling an availability zone. However, you cannot select a particular zone to disable. Before allowing the automatic mode, you can try [disabling different availability zones](start-and-cancel-shift.md).

By default, availability zone shutdown is not allowed.

## Allowing availability zone shutdown {#allow}

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

  To allow zonal shift when creating an L7 load balancer, use the [create](../../api-ref/LoadBalancer/create.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource and set `"allowZonalShift": "true"`, or use the [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md) gRPC API call and set `"allow_zonal_shift": "true"`.

  To allow zonal shift when updating an L7 load balancer, use the [update](../../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource and specify `"allowZonalShift": "true"`, or use the [LoadBalancerService/Update](../../api-ref/grpc/LoadBalancer/update.md) gRPC API call with `"allow_zonal_shift": "true"`.

{% endlist %}


## Denying availability zone shutdown {#deny}

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

  To deny zonal shift when creating an L7 load balancer, use the [create](../../api-ref/LoadBalancer/create.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource and set `"allowZonalShift": "false"`, or use the [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md) gRPC API call and set `"allow_zonal_shift": "false"`.

  To deny zonal shift when updating an L7 load balancer, use the [update](../../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource and specify `"allowZonalShift": "false"`, or use the [LoadBalancerService/Update](../../api-ref/grpc/LoadBalancer/update.md) gRPC API call with `"allow_zonal_shift": "false"`.

{% endlist %}


#### What's next {whats-next}

* [{#T}](start-and-cancel-shift.md)