---
title: "Как настроить эндпоинт-источник {{ CH }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ CH }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-источника {{ CH }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mch-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mch-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mch-name }}](../../../../managed-clickhouse/).

{% list tabs %}

- Консоль управления

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

- CLI

    * Тип эндпоинта — `clickhouse-source`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse.md) %}

- Terraform

    * Тип эндпоинта — `clickhouse_source`.

    {% include [Managed ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        clickhouse_source {
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

    * Тип эндпоинта — `clickhouse-source`.

    {% include [On premise ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse.md) %}

- Terraform

    * Тип эндпоинта — `clickhouse_source`.

    {% include [On premise ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        clickhouse_source {
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

    * **Список включённых таблиц** — будут передаваться данные только из таблиц этого списка.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * **Список исключённых таблиц** — данные таблиц из этого списка передаваться не будут.

    Для обоих списков поддерживаются выражения вида:

    * `<имя схемы>.<имя таблицы>` — полное имя таблицы;
    * `<имя схемы>.*` — все таблицы в указанной схеме;
    * `<имя таблицы>` — таблица в схеме по умолчанию.

    Оставьте списки пустыми для переноса всех таблиц.

- Terraform

    * `include_tables` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `exclude_tables` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут.

    Для обоих списков поддерживаются выражения вида:

    * `<имя схемы>.<имя таблицы>` — полное имя таблицы;
    * `<имя схемы>.*` — все таблицы в указанной схеме;
    * `<имя таблицы>` — таблица в схеме по умолчанию.

{% endlist %}

## Известные ограничения {#known-limitations}

Если таблицы источника {{ CH }} будут содержать колонки следующих типов, трансфер завершится с ошибкой:

| Тип                 | Пример ошибки                                                     |
|---------------------|-------------------------------------------------------------------|
| `Int128`            | `unhandled type Int128`                                           |
| `Int256`            | `unhandled type Int256`                                           |
| `UInt128`           | `unhandled type UInt128`                                          |
| `UInt256`           | `unhandled type UInt256`                                          |
| `Bool`              | `unhandled type Bool`                                             |
| `Date32`            | `unhandled type Date32`                                           |
| `JSON`              | `unhandled type '<имя поля> <название типа>'`                     |
| `Array(Date)`       | `Can't transfer type 'Array(Date)', column '<имя колонки>'`       |
| `Array(DateTime)`   | `Can't transfer type 'Array(DateTime)', column '<имя колонки>'`   |
| `Array(DateTime64)` | `Can't transfer type 'Array(DateTime64)', column '<имя колонки>'` |
| `Map(,)`            | `unhandled type Map(<название типа>, <название типа>)`            |

### Поддерживаемые виды таблиц
Если кластер {{ CH }} содержит более одного хоста, трансфер поддерживает перенос таблиц и материализованных представлений только с движками на базе `ReplicatedMergeTree` либо `Distributed`. Также, данные таблицы и представления должны присутствовать на всех хостах кластера.

В случае, если в списке включенных таблиц присутствуют таблицы или представления с другими движками, либо они присутствуют не на всех хостах кластера — трансфер завершится с ошибкой: `the following tables have not Distributed or Replicated engines and are not yet supported`.
