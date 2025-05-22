---
title: Как разрешить и запретить перенос трафика между зонами доступности в L7-балансировщике в {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете разрешить и запретить перенос трафика между зонами доступности в L7-балансировщике.
---

# Разрешить и запретить перенос трафика между зонами доступности

Когда в одной из [зон доступности](../../../overview/concepts/geo-scope.md) проводится обслуживание или наблюдаются неполадки, технические специалисты {{ yandex-cloud }} могут перенаправить трафик в другие зоны. Это сохранит работоспособность ваших сервисов. При восстановлении зоны, трафик будет вновь направлен в те зоны, которые были настроены для балансировщика.

Вы можете разрешить или запретить такой перенос трафика между зонами доступности. Также можно самостоятельно [протестировать перенос трафика](start-and-cancel-shift.md) из какой-либо зоны доступности. А после проверки разрешить перенос трафика только для определенных балансировщиков.

По умолчанию перенос трафика между зонами доступности не разрешен.

## Разрешить перенос трафика {#allow}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  При [создании](../application-load-balancer-create.md) или [изменении](../application-load-balancer-update.md) L7-балансировщика укажите параметр `--allow-zonal-shift`, например:

  ```bash
  yc application-load-balancer load-balancer update \
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

  1. В конфигурационном файле в описании ресурса `yandex_alb_load_balancer` укажите параметр `allow_zonal_shift` со значением `true`:

      ```hcl
      resource "yandex_alb_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = true
        ...
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` см. в [документации провайдера]({{ tf-provider-datasources-link }}/alb_load_balancer).

- API {#api}

  Чтобы разрешить перенос трафика при создании L7-балансировщика, воспользуйтесь методом REST API [create](../../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) и укажите `"allowZonalShift": "true"` или вызовом gRPC API [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md) и укажите `"allow_zonal_shift": "true"`.

  Чтобы разрешить перенос трафика при изменении L7-балансировщика, воспользуйтесь методом REST API [update](../../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) и укажите `"allowZonalShift": "true"` или вызовом gRPC API [LoadBalancerService/Update](../../api-ref/grpc/LoadBalancer/update.md) и укажите `"allow_zonal_shift": "true"`.

{% endlist %}


## Запретить перенос трафика {#deny}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  При создании или изменении L7-балансировщика укажите параметр `--allow-zonal-shift=false`, например:

  ```bash
  yc application-load-balancer load-balancer update \
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

  1. В конфигурационном файле в описании ресурса `yandex_alb_load_balancer` укажите параметр `allow_zonal_shift` со значением `false`:

      ```hcl
      resource "yandex_alb_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = false
        ...
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` см. в [документации провайдера]({{ tf-provider-datasources-link }}/alb_load_balancer).

- API {#api}

  Чтобы запретить перенос трафика при создании L7-балансировщика, воспользуйтесь методом REST API [create](../../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) и укажите `"allowZonalShift": "false"` или вызовом gRPC API [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md) и укажите `"allow_zonal_shift": "false"`.

  Чтобы запретить перенос трафика при изменении L7-балансировщика, воспользуйтесь методом REST API [update](../../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) и укажите `"allowZonalShift": "false"` или вызовом gRPC API [LoadBalancerService/Update](../../api-ref/grpc/LoadBalancer/update.md) и укажите `"allow_zonal_shift": "false"`.

{% endlist %}


#### Что дальше {whats-next}

* [{#T}](start-and-cancel-shift.md)