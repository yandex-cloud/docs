---
title: Как включить и отключить перенос трафика из зоны доступности в L7-балансировщике в {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете включить и отключить перенос трафика из зоны доступности в L7-балансировщике.
---

# Включить и отключить перенос трафика из зоны доступности

{% include [about-zonal-shift](../../../_includes/application-load-balancer/about-zonal-shift.md) %}

## Включить перенос трафика {#start}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для включения переноса трафика из зоны доступности:

      ```bash
      yc application-load-balancer load-balancer start-zonal-shift --help
      ```

  1. Получите список всех L7-балансировщиков в каталоге по умолчанию:

      ```bash
      yc application-load-balancer load-balancer list
      ```

      Результат:

      ```text
      +----------------------+-----------------------+-------------+----------------+---------+
      |          ID          |         NAME          |  REGION ID  | LISTENER COUNT | STATUS  |
      +----------------------+-----------------------+-------------+----------------+---------+
      | ds70q425egoe******** |      my-balancer      | {{ region-id }} |              1 |  ACTIVE |
      | f3da23i86n2v******** |      new-balancer     | {{ region-id }} |              1 |  ACTIVE |
      +----------------------+-----------------------+-------------+----------------+---------+
      ```

  1. Включите перенос трафика:

      ```bash
      yc application-load-balancer load-balancer start-zonal-shift \
        <имя_или_идентификатор_балансировщика> \
        --zone <зона_доступности>
      ```

      Результат:

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

  Чтобы включить перенос трафика, воспользуйтесь методом REST API [startZonalShift](../../api-ref/LoadBalancer/startZonalShift.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/StartZonalShift](../../api-ref/grpc/LoadBalancer/startZonalShift.md).

{% endlist %}


## Отключить перенос трафика {#cancel}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для отключения переноса трафика из зоны доступности:

      ```bash
      yc application-load-balancer load-balancer cancel-zonal-shift --help
      ```

  1. Получите список всех L7-балансировщиков в каталоге по умолчанию:

      ```bash
      yc application-load-balancer load-balancer list
      ```

      Результат:

      ```text
      +----------------------+-----------------------+-------------+----------------+---------+
      |          ID          |         NAME          |  REGION ID  | LISTENER COUNT | STATUS  |
      +----------------------+-----------------------+-------------+----------------+---------+
      | ds70q425egoe******** |      my-balancer      | {{ region-id }} |              1 |  ACTIVE |
      | f3da23i86n2v******** |      new-balancer     | {{ region-id }} |              1 |  ACTIVE |
      +----------------------+-----------------------+-------------+----------------+---------+
      ```

  1. Отключите перенос трафика:

      ```bash
      yc application-load-balancer load-balancer cancel-zonal-shift \
        <имя_или_идентификатор_балансировщика> \
        --zone <зона_доступности>
      ```

      Результат:

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

  Чтобы отключить перенос трафика, воспользуйтесь методом REST API [cancelZonalShift](../../api-ref/LoadBalancer/cancelZonalShift.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/CancelZonalShift](../../api-ref/grpc/LoadBalancer/cancelZonalShift.md).

{% endlist %}