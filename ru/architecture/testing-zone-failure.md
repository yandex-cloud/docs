---
title: Тестирование отказоустойчивости в {{ yandex-cloud }} на основе {{ network-load-balancer-full-name }}
description: Руководство по проведению учений по отказу одной зоны доступности в облаке в инфраструктуре на основе {{ network-load-balancer-full-name }}
keywords:
  - тестирование
  - отказ зоны доступности
  - chaos engineering
  - отказоустойчивость
  - нагрузочное тестирование
---

# Тестирование отказоустойчивости в инфраструктуре {{ yandex-cloud }} на основе {{ network-load-balancer-full-name }}

Данное руководство описывает практическую часть рекомендаций по тестированию отказоустойчивости, которые содержатся в статье [Рекомендации по отказоустойчивости в {{ yandex-cloud }}](./fault-tolerance.md), применительно к инфраструктуре {{ yandex-cloud }}, реализованной на основе [сетевых балансировщиков нагрузки](../network-load-balancer/concepts/index.md) {{ network-load-balancer-full-name }}. Предполагается, что принципы построения тестируемой инфраструктуры не противоречат принципам, изложенным в статье.

## Цели тестирования {#goals}

{% include [testing-goals](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/testing-goals.md) %}

## Подготовка к тестированию {#preparation}

### Среда тестирования {#environment}

{% include [testing-environment](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/testing-environment.md) %}

### Рекомендации к проведению тестирования {#recommendations}

{% include [testing-requirements](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/testing-requirements.md) %}

### Инструменты тестирования {#tools}

В данном руководстве рассматривается тестирование отказоустойчивости с помощью инструментов отключения балансировки нагрузки в отдельной [зоне доступности](../overview/concepts/geo-scope.md) для [{{ network-load-balancer-name }}](../network-load-balancer/operations/manage-zone/disable-enable-zone.md). 

{% include [testing-tools-vpc-sgs](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/testing-tools-vpc-sgs.md) %}

## Методика проведения тестирования {#method}

### Подготовка {#test-prep}

1. {% include [test-prep1](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-prep1.md) %}
1. {% include [test-prep2](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-prep2.md) %}
1. {% include [test-prep3](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-prep3.md) %}
1. {% include [test-prep4](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-prep4.md) %}

    ```
    yc load-balancer nlb list
    ```

### Запуск тестирования {#test-run}

{% include [test-run-part1](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-run-part1.md) %}

```
yc load-balancer nlb disable-zones <имя_или_идентификатор_балансировщика> \
  --zones={{ region-id }}-b \
  --duration 30m
```

Примерный результат выполнения команды (обратите внимание на блок `disable_zone_statuses`):

```
id: enpmq********
...
disable_zone_statuses:
  - zone_id: {{ region-id }}-b
    disabled_until: "2025-07-17T15:30:18.176751322Z"
```

{% include [test-run-part2](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-run-part2.md) %}

### Оценка состояния {#test-check}

1. Чтобы получить информацию о состоянии блокировки ресурсов за отдельным балансировщиком нагрузки, выполните команду:

   ```
   yc load-balancer nlb get <имя_или_идентификатор_балансировщика>
   ```

   Примерный результат выполнения команды:

   ```
    id: enpmq********
    folder_id: b1g********
    created_at: "2025-07-17T13:42:24Z"
    name: ...
    region_id: {{ region-id }}
    status: ACTIVE
    type: EXTERNAL
    listeners:
      - name: ...
        ...
    attached_target_groups:
      - target_group_id: enpn********
        health_checks:
          - name: ...
            ...
    disable_zone_statuses:
      - zone_id: {{ region-id }}-b
        disabled_until: "2025-07-17T15:30:18.176751322Z"
   ```
1. {% include [test-check](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-check.md) %}
 
### Завершение тестирования {#test-fin}

1. {% include [test-fin-part1](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-fin-part1.md) %}

   ```
   yc load-balancer nlb enable-zones <имя_или_идентификатор_балансировщика> \
     --zones={{ region-id }}-b
   ```
1. {% include [test-fin-part2](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-fin-part2.md) %}

## Заключение {#conclusion}

{% include [conclusion](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/conclusion.md) %}