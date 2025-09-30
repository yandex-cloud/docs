---
title: Как отключить и включить зону доступности и начать перенос трафика в другие зоны на L7-балансировщике {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете отключить и включить зону доступности и проверить перераспределение трафика на L7-балансировщике.
---

# Отключить и включить зону доступности

{% include [about-zonal-shift](../../../_includes/application-load-balancer/about-zonal-shift.md) %}

## Отключить зону доступности {#disable-zones}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды:

      ```bash
      yc application-load-balancer load-balancer disable-zones --help
      ```

  1. Чтобы начать перераспределение трафика, отключите зону и укажите время блокировки:

      ```bash
      yc application-load-balancer load-balancer disable-zones \
        <имя_или_идентификатор_балансировщика> \
        --zones <зоны_доступности>
        --duration <время_отключения>
      ```

      Где:

      * `<имя_или_идентификатор_балансировщика>` — имя или идентификатор балансировщика.
      * `--zones` — зоны доступности через запятую, которые нужно отключить.
      * `--duration` — время от `1m` до `72h`, на которое будет отключена зона.
      
         По истечении указанного времени зона автоматически вернется в исходное состояние (включена) для CLI и API. Эти настройки будут применены без вашего участия.
         
         Если параметр не указан, зона будет отключена до ручного [включения зоны](#enable-zones).
  
      Пример:

      ```bash
      yc application-load-balancer load-balancer disable-zones \
        my-balancer \
        --zones {{ region-id }}-a \
        --duration 1h
      ```

      Результат:

      ```text
      id: ds70q425egoe********
      name: my-balancer
      ...
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e2lptlobccu6********
            zonal_shift_active: true
            zonal_traffic_disabled: true
          - zone_id: {{ region-id }}-b
            subnet_id: e9bo5ir5prfi********
      ...
      ```

- API {#api}

  Чтобы отключить зону доступности, воспользуйтесь методом REST API [DisableZones](../../api-ref/LoadBalancer/disableZones.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/DisableZones](../../api-ref/grpc/LoadBalancer/disableZones.md).

{% endlist %}

## Посмотреть время включения зоны доступности {#view-zone-status}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится балансировщик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}** и далее нужный балансировщик.
  1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** напротив зоны доступности посмотрите ее статус.

      Если была задана длительность блокировки, рядом с зоной будет указано время, до которого она заблокирована.

{% endlist %}

## Включить зону доступности {#enable-zones}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для включения зоны доступности:

      ```bash
      yc application-load-balancer load-balancer enable-zones --help
      ```

  1. Включите зону доступности:

      ```bash
      yc application-load-balancer load-balancer enable-zones \
        <имя_или_идентификатор_балансировщика> \
        --zones <зоны_доступности>
      ```

      Пример:

      ```bash
      yc application-load-balancer load-balancer enable-zones \
        my-balancer \
        --zones {{ region-id }}-a
      ```
      
      Результат:

      ```text
      id: ds70q425egoe********
      name: my-balancer
      ...
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9bo5ir5prfi********
          - zone_id: {{ region-id }}-b
            subnet_id: e2lptlobccu6******** 
      ...
      ```

- API {#api}

  Чтобы включить зону доступности, воспользуйтесь методом REST API [EnableZones](../../api-ref/LoadBalancer/enableZones.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/EnableZones](../../api-ref/grpc/LoadBalancer/enableZones.md).

{% endlist %}

{% note info %}

Ранее для включения и отключения зоны доступности использовались команды CLI `start-zonal-shift`, `cancel-zonal-shift` и методы API `StartZonalShift`, `CancelZonalShift`. Сейчас они устарели и будут удалены в ближайшее время.

{% endnote %}