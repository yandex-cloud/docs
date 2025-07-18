---
title: Как отключить и включить зоны доступности для сетевого балансировщика {{ network-load-balancer-full-name }}
description: Следуя данной инструкции, вы сможете отключить и включить зоны доступности для сетевого балансировщика.
---


# Отключить и включить зоны доступности

{% include [about-zone-disable](../../../_includes/network-load-balancer/about-zone-disable.md) %}

Вы можете отключать и включать зоны доступности по одной или перечислить нужные зоны через запятую. 


## Отключить зоны доступности {#disable-zone}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды выключения зоны для балансировщика:

        ```bash
        yc load-balancer network-load-balancer disable-zones --help
        ```

  1. Получите список всех сетевых балансировщиков в каталоге по умолчанию:

        ```bash
        yc load-balancer network-load-balancer list
        ```

        Результат:

        ```text
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      |          ID          |     NAME    |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      | ds70q425egoe******** | my-balancer | ru-central1 | EXTERNAL |              1 | enpakget56sr********   | ACTIVE |
      |                      |             |             |          |                | enpakf7vhj2l********   |        |
      | fw7fh46bnsge******** | my-nlb2     | ru-central1 | EXTERNAL |              1 | sn5u68knmswe********   | ACTIVE |
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      ```

  1. Отключите одну или несколько зон доступности с помощью команды:

      ```bash
      yc load-balancer network-load-balancer disable-zones \
        <имя_или_идентификатор_балансировщика> \
        --zones=<идентификатор_зоны_1>,[<идентификатор_зоны_2>] \
        --duration=<продолжительность> 
      ```

      Где
      
      * `--zones` — идентификаторы зон доступности.
      * `--duration` — продолжительность блокировки. Значения от 1m до 72h. Если не задано, продолжительность не ограничена. Если зоны указаны списком, все они отключатся на заданный период.

{% endlist %}

{% note info %}

Команду отключения зоны можно выполнять не чаще, чем раз в две минуты.

{% endnote %}


### Примеры {#examples}

#### Отключение двух зон доступности {#two-zones-off}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы отключить две зоны для балансировщика, укажите их списком через запятую:

  ```bash
  yc load-balancer network-load-balancer disable-zones ds70q425egoe******** \
    --zones=ru-central1-b,ru-central1-d
  ```

  Результат:

  ```text
  id: ds70q425egoe********
  ...
  disable_zone_statuses:
    - zone_id: ru-central1-b
    - zone_id: ru-central1-d
  ```

{% endlist %}

#### Отключение зоны доступности на 30 минут {#zone-off-30min}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы отключить одну зону на 30 минут, используйте параметр `--duration`:

  ```bash
  yc load-balancer network-load-balancer disable-zones ds70q425egoe******** \
    --zones=ru-central1-b \
    --duration=30m
  ```

  Результат:

  ```text
  id: ds70q425egoe********
  ...
  disable_zone_statuses:
    - zone_id: ru-central1-b
      disabled_until: "2025-06-06T04:10:02.679608678Z"
  ```

  Можно продлить блокировку зоны, выполнив команду с параметром `--duration` еще раз для нужной зоны.

{% endlist %}


## Включить зоны доступности {#enable-zone}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды включения зоны для балансировщика:

      ```bash
      yc load-balancer network-load-balancer enable-zones --help
      ```

  1. Получите список всех сетевых балансировщиков в каталоге по умолчанию:

      ```bash
      yc load-balancer network-load-balancer list
      ```

      Результат:

      ```text
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      |          ID          |     NAME    |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      | ds70q425egoe******** | my-balancer | ru-central1 | EXTERNAL |              1 | enpakget56sr********   | ACTIVE |
      |                      |             |             |          |                | enpakf7vhj2l********   |        |
      | fw7fh46bnsge******** | my-nlb2     | ru-central1 | EXTERNAL |              1 | sn5u68knmswe********   | ACTIVE |
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      ```

  1. Включите одну или несколько зон доступности:

      ```bash
      yc load-balancer network-load-balancer enable-zones \
        <имя_или_идентификатор_балансировщика> \
        --zones=<идентификатор_зоны_1>,[<идентификатор_зоны_2>]
      ```

     Результат:

      ```text
      id: ds70q425egoe********
      ...
      allow_zonal_shift: false
      disable_zone_statuses:
      ```

{% endlist %}


## Проверить настройки блокировки зон доступности {#check-shift}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы проверить, есть ли отключенные зоны, установлен ли период блокировки, выполните команду:

    ```bash
    yc load-balancer network-load-balancer get \
      <имя_или_идентификатор_балансировщика>
    ```

    Результат:

    ```text
    id: ds70q425egoe********
    ...
    disable_zone_statuses:
      - zone_id: ru-central1-b
      - zone_id: ru-central1-d
        disabled_until: "2025-06-06T04:10:02.679608678Z"
    ```
      
{% endlist %}
