---
title: Как отключить и включить зону доступности и начать перенос трафика в другие зоны на L7-балансировщике {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете отключить и включить зону доступности и проверить перераспределение трафика на L7-балансировщике.
---

# Отключить и включить зону доступности

{% include [about-zonal-shift](../../../_includes/application-load-balancer/about-zonal-shift.md) %}

## Отключить зону доступности {#disable-zones}

{% include [disable-zone-ig-nlb-alb](../../../_includes/instance-groups/disable-zone-ig-nlb-alb.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [L7-балансировщик](../../concepts/application-load-balancer.md).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Выберите L7-балансировщик.
  1. На странице **{{ ui-key.yacloud.common.overview }}** в блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** нажмите кнопку **{{ ui-key.yacloud.alb.section_allocation-settings_button }}**.
  1. Включите блокировку для одной или нескольких зон.
  1. (Опционально) Чтобы задать время автоматического отключения блокировки, активируйте опцию **{{ ui-key.yacloud.components.BalancerAllocationDialog.AllocationForm.form_timezone_0_6LoEf }}** и укажите время от `1m` до `72h`. Если время не указано, зона останется заблокированной до ручного включения.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    Балансировщик начнет перенос трафика из заблокированных зон доступности в незаблокированные.

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
      
         По истечении указанного времени зона автоматически восстановится. Если параметр не указан, зона будет отключена до ручного [включения зоны](#enable-zones).
  
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
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}** и выберите нужный балансировщик.
  1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** напротив зоны доступности посмотрите ее статус.

      Если была задана длительность блокировки, рядом с зоной будет указано время, до которого она заблокирована.

{% endlist %}

## Включить зону доступности {#enable-zones}

{% include [enable-zone-ig-nlb-alb](../../../_includes/instance-groups/enable-zone-ig-nlb-alb.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [L7-балансировщик](../../concepts/application-load-balancer.md).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Выберите L7-балансировщик.
  1. На странице **{{ ui-key.yacloud.common.overview }}** в блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** нажмите кнопку **{{ ui-key.yacloud.alb.section_allocation-settings_button }}**.
  1. Отключите блокировку зон доступности.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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

### См. также {#see-also}

* [Отключить и включить зоны доступности для группы ВМ {{ compute-full-name }}](../../../compute/operations/instance-groups/disable-enable-zone.md)
* [Отключить и включить зоны доступности в {{ network-load-balancer-full-name }}](../../../network-load-balancer/operations/manage-zone/disable-enable-zone.md)