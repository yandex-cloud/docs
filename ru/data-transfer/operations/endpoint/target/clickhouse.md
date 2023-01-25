---
title: "Как настроить эндпоинт-приемник {{ CH }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ CH }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-приемника {{ CH }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mch-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mch-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mch-full-name }}](../../../../managed-clickhouse/).

{% list tabs %}

- Консоль управления

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

- CLI

    * Тип эндпоинта — `clickhouse-target`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse.md) %}

- {{ TF }}

    * Тип эндпоинта — `clickhouse_target`.

    {% include [Managed ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        clickhouse_target {
          security_groups = [ "список идентификаторов групп безопасности" ]
          subnet_id       = "<идентификатор подсети>"
          connection {
            connection_options {
              mdb_cluster_id = "<идентификатор кластера {{ mch-name }}>"
              database       = "<имя переносимой базы данных>"
              user           = "<имя пользователя для подключения>"
              password {
                raw = "<пароль пользователя>"
              }
            }
          }
          <дополнительные настройки эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs %}

- Консоль управления

    {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI

    * Тип эндпоинта — `clickhouse-target`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse.md) %}

- {{ TF }}

    * Тип эндпоинта — `clickhouse_target`.

    {% include [On premise ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        clickhouse_target {
          security_groups = [ "список идентификаторов групп безопасности" ]
          subnet_id       = "<идентификатор подсети>"
          connection {
            connection_options {
              on_premise {
                http_port   = "<порт для подключения по HTTP>"
                native_port = "<порт для подключения к нативному интерфейсу>"
                shards {
                  name  = "<имя шарда>"
                  hosts = [ "список IP-адресов или FQDN хостов шарда" ]
                }
                tls_mode {
                  enabled {
                    ca_certificate = "<сертификат в формате PEM>"
                  }
                }
              }
              database = "<имя переносимой базы данных>"
              user     = "<имя пользователя для подключения>"
              password {
                raw = "<пароль пользователя>"
              }
            }
          }
          <дополнительные настройки эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop-truncate.md) %}

    * **Настройки шардирования** — задайте настройки для [шардирования](../../../../managed-clickhouse/concepts/sharding.md):

        * **Без шардирования** — шардирование не используется.

        * **Шардирование по значению колонки** — имя колонки в таблицах, по которой следует шардировать данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки. Укажите имя колонки для шардирования в соответствующем поле.

            Для шардирования по конкретным значениям колонки укажите их в поле **Сопоставление**. Это поле определяет соответствие значений колонки и индекса шарда (порядковый номер шарда в отсортированном по именам списке шардов) для шардирования по конкретным значениям данных.

        * **Шардирование по ID трансфера** — данные по шардам будут распределяться на основе значения идентификатора трансфера. При этом трансфер игнорирует настройку **Сопоставление** и шардирует данные только по идентификатору трансфера.

           {% note warning %}

           Если не задавать имя колонки для шардирования и не использовать настройку **Шардирование по ID трансфера**, то все данные будут перенесены в один шард.

           {% endnote %}

    * **Переименование таблиц** — при необходимости задайте настройки переименования таблиц при трансфере.

    * **Загружать данные в формате JSON** — для необязательных полей будут использованы значения по умолчанию, если они определены. Включите эту настройку, если трансфер будет подключаться к приемнику через HTTP-порт, а не нативный.

    * **Интервал записи** — укажите задержку, с которой данные должны поступать в кластер-приемник. Увеличьте значение в этом поле, если ClickHouse не успевает делать слияние кусков данных.

- {{ TF }}

    * `clickhouse_cluster_name` — укажите имя кластера, в который будут передаваться данные.

    * `alt_names` — при необходимости укажите правила переименования таблиц базы-источника при переносе в базу-приемник:

        * `from_name` – имя таблицы в источнике.
        * `to_name` – имя таблицы в приемнике.

    * `sharding.column_value_hash.column_name` — имя колонки в таблицах, по которой следует [шардировать](../../../../managed-clickhouse/concepts/sharding.md) данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки.

    * `sharding.transfer_id` — при значении `true` данные по шардам распределяются на основе значения идентификатора трансфера. При этом трансфер игнорирует настройку `sharding.column_value_hash.column_name` и шардирует данные только по идентификатору трансфера.

       {% note warning %}

       Если не задавать имя колонки для шардирования и не использовать настройку `sharding.transfer_id`, то все данные будут перенесены в один шард.

       {% endnote %}

    * `cleanup_policy` — укажите способ очистки данных в базе-приемнике перед переносом:

        * `CLICKHOUSE_CLEANUP_POLICY_DROP` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

           Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

        * `CLICKHOUSE_CLEANUP_POLICY_DISABLED` — не очищать.

           Выберите эту опцию, если будет производиться только репликация без копирования данных.

{% endlist %}
