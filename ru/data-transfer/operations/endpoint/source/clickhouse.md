# Настройка эндпоинта-источника {{ CH }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mch-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mch-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mch-name }}](../../../../managed-clickhouse/).

{% list tabs %}

- Консоль управления

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

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

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs %}

- Консоль управления

    {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- Terraform

    * Тип эндпоинта — `clickhouse_source`.

    {% include [On premise ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

    Пример структуры конфигурационного файла:

    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        clickhouse_source {
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

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **Включенные таблицы** — будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.
    * **Исключенные таблицы** — данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    Для обоих списков поддерживаются выражения вида:

    * `<имя схемы>.<имя таблицы>` — полное имя таблицы;
    * `<имя схемы>.*` — все таблицы в указанной схеме;
    * `<имя таблицы>` — таблица в схеме по умолчанию.

- Terraform

    * `include_tables` — список включенных таблиц. Будут передаваться данные только таблиц из этого списка. Задается с помощью регулярных выражений.

    * `exclude_tables` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

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

