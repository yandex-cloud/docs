---
title: Как разрешить и запретить перенос трафика между зонами доступности для сетевого балансировщика {{ network-load-balancer-full-name }}
description: Следуя данной инструкции, вы сможете разрешить и запретить перенос трафика между зонами доступности для сетевого балансировщика.
---


# Разрешить и запретить перенос трафика между зонами доступности

{% include [about-zone-shift](../../../_includes/network-load-balancer/about-zone-shift.md) %}

Также вы можете самостоятельно включать и отключать необходимые зоны доступности и [тестировать перенос трафика](disable-enable-zone.md) из какой-либо зоны доступности. А после проверки разрешить перенос трафика только для определенных балансировщиков.

По умолчанию перенос трафика между зонами доступности не разрешен.


## Разрешить перенос трафика {#allow}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  При [создании](../load-balancer-create.md) или [изменении](../load-balancer-update.md) сетевого балансировщика укажите параметр `--allow-zonal-shift`, например:

    ```bash
    yc load-balancer network-load-balancer update \
      <имя_или_идентификатор_балансировщика> \
      --allow-zonal-shift
    ```

    Результат:

    ```text
    id: ds70q425egoe********
    name: my-balancer
    ...
    allow_zonal_shift: true
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. В конфигурационном файле в описании ресурса `yandex_lb_network_load_balancer` укажите параметр `allow_zonal_shift` со значением `true`:

      ```hcl
      resource "yandex_lb_network_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = true
        ...
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно с помощью команды [CLI](../../../cli/quickstart.md):
      
      ```bash
      yc load-balancer network-load-balancer get \
        <имя_или_идентификатор_балансировщика>
      ```

  Более подробную информацию о параметрах ресурса `yandex_lb_network_load_balancer` см. в [документации провайдера]({{ tf-provider-datasources-link }}/lb_network_load_balancer).

- API {#api}

  Чтобы разрешить перенос трафика при создании сетевого балансировщика, воспользуйтесь методом REST API [create](../../api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) и укажите `"allowZonalShift": "true"` или вызовом gRPC API [NetworkLoadBalancerService/Create](../../api-ref/grpc/NetworkLoadBalancer/create.md) и укажите `"allow_zonal_shift": "true"`.

  Чтобы разрешить перенос трафика при изменении сетевого балансировщика, воспользуйтесь методом REST API [update](../../api-ref/NetworkLoadBalancer/update.md) для ресурса [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) и укажите `"allowZonalShift": "true"` или вызовом gRPC API [NetworkLoadBalancerService/Update](../../api-ref/grpc/NetworkLoadBalancer/update.md) и укажите `"allow_zonal_shift": "true"`.

{% endlist %}


## Запретить перенос трафика {#deny}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  При создании или изменении сетевого балансировщика укажите параметр `--allow-zonal-shift=false`, например:

    ```bash
    yc load-balancer network-load-balancer update \
      <имя_или_идентификатор_балансировщика> \
      --allow-zonal-shift=false
    ```

    Результат:

    ```text
    id: ds70q425egoe********
    name: my-balancer
    ...
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. В конфигурационном файле в описании ресурса `yandex_lb_network_load_balancer` укажите параметр `allow_zonal_shift` со значением `false`:

      ```hcl
      resource "yandex_lb_network_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = false
        ...
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно с помощью команды [CLI](../../../cli/quickstart.md):
      
      ```bash
      yc load-balancer network-load-balancer get \
        <имя_или_идентификатор_балансировщика>
      ```

  Более подробную информацию о параметрах ресурса `yandex_lb_network_load_balancer` см. в [документации провайдера]({{ tf-provider-datasources-link }}/lb_network_load_balancer).

- API {#api}

  Чтобы запретить перенос трафика при создании сетевого балансировщика, воспользуйтесь методом REST API [create](../../api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) и укажите `"allowZonalShift": "false"` или вызовом gRPC API [NetworkLoadBalancerService/Create](../../api-ref/grpc/NetworkLoadBalancer/create.md) и укажите `"allow_zonal_shift": "false"`.

  Чтобы запретить перенос трафика при изменении сетевого балансировщика, воспользуйтесь методом REST API [update](../../api-ref/NetworkLoadBalancer/update.md) для ресурса [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) и укажите `"allowZonalShift": "false"` или вызовом gRPC API [NetworkLoadBalancerService/Update](../../api-ref/grpc/NetworkLoadBalancer/update.md) и укажите `"allow_zonal_shift": "false"`.

{% endlist %}


#### Что дальше {whats-next}

* [{#T}](disable-enable-zone.md)