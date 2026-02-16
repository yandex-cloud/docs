# Тестирование отказоустойчивости в инфраструктуре {{ yandex-cloud }} на основе {{ alb-full-name }}

Данное руководство описывает практическую часть рекомендаций по тестированию отказоустойчивости, которые содержатся в статье [Рекомендации по отказоустойчивости в {{ yandex-cloud }}](../../architecture/fault-tolerance.md), применительно к инфраструктуре {{ yandex-cloud }}, реализованной на основе [L7-балансировщиков нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) {{ alb-name }}. Предполагается, что принципы построения тестируемой инфраструктуры не противоречат принципам, изложенным в статье.

## Цели тестирования {#goals}

{% include [testing-goals](../_tutorials_includes/testing-zone-failure-for-alb/testing-goals.md) %}

## Подготовка к тестированию {#preparation}

### Среда тестирования {#environment}

{% include [testing-environment](../_tutorials_includes/testing-zone-failure-for-alb/testing-environment.md) %}

### Рекомендации к проведению тестирования {#recommendations}

{% include [testing-requirements](../_tutorials_includes/testing-zone-failure-for-alb/testing-requirements.md) %}

### Инструменты тестирования {#tools}

В данном руководстве рассматривается тестирование отказоустойчивости с помощью инструментов отключения балансировки нагрузки в отдельной [зоне доступности](../../overview/concepts/geo-scope.md) для [{{ alb-name }}](../../application-load-balancer/operations/manage-zone/start-and-cancel-shift.md).

{% include [testing-tools-vpc-sgs](../_tutorials_includes/testing-zone-failure-for-alb/testing-tools-vpc-sgs.md) %}

## Методика проведения тестирования {#method}

### Подготовка {#test-prep}

1. {% include [test-prep1](../_tutorials_includes/testing-zone-failure-for-alb/test-prep1.md) %}
1. {% include [test-prep2](../_tutorials_includes/testing-zone-failure-for-alb/test-prep2.md) %}
1. {% include [test-prep3](../_tutorials_includes/testing-zone-failure-for-alb/test-prep3.md) %}
1. {% include [test-prep4](../_tutorials_includes/testing-zone-failure-for-alb/test-prep4.md) %}

    ```
    yc alb load-balancer list
    ```

### Запуск тестирования {#test-run}

{% include [test-run-part1](../_tutorials_includes/testing-zone-failure-for-alb/test-run-part1.md) %}

```
yc alb load-balancer disable-zones <имя_или_идентификатор_балансировщика> \
  --zones={{ region-id }}-b \
  --duration 30m
```

Примерный результат выполнения команды (обратите внимание на блок `allocation_policy.locations`):

```
...
allocation_policy:
  locations:
    - zone_id: {{ region-id }}-a
      subnet_id: e9bnvnn56fs4********
    - zone_id: {{ region-id }}-b
      subnet_id: e2lqsms4cdl3********
      zonal_shift_active: true
      zonal_traffic_disabled: true
    - zone_id: {{ region-id }}-d
      subnet_id: fl8dmq91iruu********
...
```

{% include [test-run-part2](../_tutorials_includes/testing-zone-failure-for-alb/test-run-part2.md) %}

### Оценка состояния {#test-check}

1. Чтобы получить информацию о состоянии блокировки ресурсов за отдельным балансировщиком нагрузки:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится балансировщик.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}** и выберите нужный балансировщик.
      1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** напротив зоны доступности посмотрите ее статус.

          Если была задана длительность блокировки, рядом с зоной будет указано время, до которого она заблокирована.

    {% endlist %}

1. {% include [test-check](../_tutorials_includes/testing-zone-failure-for-alb/test-check.md) %}

### Завершение тестирования {#test-fin}

1. {% include [test-fin-part1](../_tutorials_includes/testing-zone-failure-for-alb/test-fin-part1.md) %}

   ```
   yc alb load-balancer enable-zones <имя_или_идентификатор_балансировщика> \
     --zones={{ region-id }}-b
   ```
1. {% include [test-fin-part2](../_tutorials_includes/testing-zone-failure-for-alb/test-fin-part2.md) %}

## Заключение {#conclusion}

{% include [conclusion](../_tutorials_includes/testing-zone-failure-for-alb/conclusion.md) %}