---
title: Как отключить и включить зону доступности для группы ВМ {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете отключить или включить зоны доступности для группы виртуальных машин.
---

# Отключить и включить зоны доступности для группы ВМ {{ compute-full-name }}

{% include [disable-enable-zone-intro](../../../_includes/instance-groups/disable-enable-zone-intro.md) %}

Подробнее о режиме работы при отключении зоны см. на странице [{#T}](../../concepts/instance-groups/disable-enable-zone.md).

## Отключить зону доступности {#disable}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для отключения зоны:

      ```bash
      yc compute instance-group disable-zones --help
      ```

  1. Получите список всех групп ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance-group list
      ```

      Результат:

      ```text
      +----------------------+----------------------+--------+------+
      |          ID          |         NAME         | STATUS | SIZE |
      +----------------------+----------------------+--------+------+
      | amc65sbgfqeq******** | test-group           | ACTIVE |    3 |
      | cl1cvs4firjj******** | catsf2nfq0mh******** | ACTIVE |    1 |
      +----------------------+----------------------+--------+------+
      ```

  1. Отключите для группы одну или несколько зон доступности:

      ```bash
      yc compute instance-group disable-zones \
        --id <идентификатор_группы_ВМ> \
        --zones=<идентификатор_зоны_1>,[<идентификатор_зоны_2>] \
        --duration=<продолжительность> 
      ```

      Где:
      * `--id` — идентификатор группы ВМ.
      * `--zones` — идентификаторы зон доступности, например `{{ region-id }}-a`.
      * `--duration` — продолжительность блокировки. Значения от `1m` до `72h`. Если не задано, продолжительность не ограничена. Если зоны указаны списком, все они отключатся на заданный период.

{% endlist %}

## Включить зону доступности {#enable}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для включения зоны:

      ```bash
      yc compute instance-group enable-zones --help
      ```

  1. Получите список всех групп ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance-group list
      ```

      Результат:

      ```text
      +----------------------+----------------------+--------+------+
      |          ID          |         NAME         | STATUS | SIZE |
      +----------------------+----------------------+--------+------+
      | amc65sbgfqeq******** | test-group           | ACTIVE |    3 |
      | cl1cvs4firjj******** | catsf2nfq0mh******** | ACTIVE |    1 |
      +----------------------+----------------------+--------+------+
      ```

  1. Включите для группы одну или несколько зон доступности:

      ```bash
      yc compute instance-group enable-zones \
        --id <идентификатор_группы_ВМ> \
        --zones=<идентификатор_зоны_1>,[<идентификатор_зоны_2>]
      ```

      Где:
      * `--id` — идентификатор группы ВМ.
      * `--zones` — идентификаторы зон доступности, например `{{ region-id }}-a`.

{% endlist %}

## Проверить статус зоны доступности и время до включения {#check}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду, указав идентификатор группы ВМ:

  ```bash
  yc compute instance-group get \
    --id <идентификатор_группы_ВМ>
  ```

  Результат:

  ```text
  id: amc65sbgfqeq********
  ...
  disable_zone_statuses:
    - zone_id: {{ region-id }}-a
    - zone_id: {{ region-id }}-b
      disabled_until: "2025-06-06T04:10:02.679608678Z"
  ```

  Где `disabled_until` — время автоматического включения зоны доступности.

{% endlist %}

### См. также {#see-also}

* [{#T}](../../concepts/instance-groups/disable-enable-zone.md)
* [Отключить и включить зоны доступности в {{ network-load-balancer-full-name }}](../../../network-load-balancer/operations/manage-zone/disable-enable-zone.md)
* [Отключить и включить зоны доступности в {{ alb-full-name }}](../../../application-load-balancer/operations/manage-zone/start-and-cancel-shift.md)
* [{#T}](../../concepts/instance-groups/zonal-inc/overview.md)