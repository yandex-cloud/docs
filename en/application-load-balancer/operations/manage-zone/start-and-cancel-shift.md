---
title: How to enable and disable traffic transfer from an availability zone in an L7 load balancer to {{ alb-full-name }}
description: Follow this guide to enable and disable traffic transfer from an availability zone in an L7 load balancer.
---

# Enabling and disabling traffic transfer from an availability zone

{% include [about-zonal-shift](../../../_includes/application-load-balancer/about-zonal-shift.md) %}

## Enabling traffic transfer {#start}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the command to enable traffic transfer from an availability zone:

      ```bash
      yc application-load-balancer load-balancer start-zonal-shift --help
      ```

  1. Get a list of all L7 load balancers in the default folder:

      ```bash
      yc application-load-balancer load-balancer list
      ```

      Result:

      ```text
      +----------------------+-----------------------+-------------+----------------+---------+
      |          ID          |         NAME          |  REGION ID  | LISTENER COUNT | STATUS  |
      +----------------------+-----------------------+-------------+----------------+---------+
      | ds70q425egoe******** |      my-balancer      | {{ region-id }} |              1 |  ACTIVE |
      | f3da23i86n2v******** |      new-balancer     | {{ region-id }} |              1 |  ACTIVE |
      +----------------------+-----------------------+-------------+----------------+---------+
      ```

  1. Enable traffic transfer:

      ```bash
      yc application-load-balancer load-balancer start-zonal-shift \
        <load_balancer_name_or_ID> \
        --zone <availability_zone>
      ```

      Result:

      ```text
      id: ds70q425egoe********
      name: my-balancer
      ...
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-b
            subnet_id: e2lptlobccu6********
          - zone_id: {{ region-id }}-a
            subnet_id: e9bo5ir5prfi********
            zonal_shift_active: true
      ...
      ```

- API {#api}

  To enable traffic transfer, use the [startZonalShift](../../api-ref/LoadBalancer/startZonalShift.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/StartZonalShift](../../api-ref/grpc/LoadBalancer/startZonalShift.md) gRPC API call.

{% endlist %}


## Disabling traffic transfer {#cancel}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the command to disable traffic transfer from an availability zone:

      ```bash
      yc application-load-balancer load-balancer cancel-zonal-shift --help
      ```

  1. Get a list of all L7 load balancers in the default folder:

      ```bash
      yc application-load-balancer load-balancer list
      ```

      Result:

      ```text
      +----------------------+-----------------------+-------------+----------------+---------+
      |          ID          |         NAME          |  REGION ID  | LISTENER COUNT | STATUS  |
      +----------------------+-----------------------+-------------+----------------+---------+
      | ds70q425egoe******** |      my-balancer      | {{ region-id }} |              1 |  ACTIVE |
      | f3da23i86n2v******** |      new-balancer     | {{ region-id }} |              1 |  ACTIVE |
      +----------------------+-----------------------+-------------+----------------+---------+
      ```

  1. Disable traffic transfer:

      ```bash
      yc application-load-balancer load-balancer cancel-zonal-shift \
        <load_balancer_name_or_ID> \
        --zone <availability_zone>
      ```

      Result:

      ```text
      id: ds70q425egoe********
      name: my-balancer
      ...
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-b
            subnet_id: e2lptlobccu6********
          - zone_id: {{ region-id }}-a
            subnet_id: e9bo5ir5prfi********
      ...
      ```

- API {#api}

  To disable traffic transfer, use the [cancelZonalShift](../../api-ref/LoadBalancer/cancelZonalShift.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/CancelZonalShift](../../api-ref/grpc/LoadBalancer/cancelZonalShift.md) gRPC API call.

{% endlist %}