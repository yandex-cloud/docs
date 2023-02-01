---
title: "Как настроить эндпоинт-источник {{ MY }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ MY }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-источника {{ MY }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmy-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mmy-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mmy-full-name }}](../../../../managed-mysql/).

{% list tabs %}

- Консоль управления

    {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql-source.md) %}

- CLI

    * Тип эндпоинта — `mysql-source`.

    {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-source.md) %}

- {{ TF }}

    * Тип эндпоинта — `mysql_source`.

    {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-source.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        mysql_source {
          security_groups = [ "список идентификаторов групп безопасности" ]
          connection {
            mdb_cluster_id = "<идентификатор кластера {{ mmy-name }}>"
          }
          database = "<имя переносимой базы данных>"
          user     = "<имя пользователя для подключения>"
          password {
            raw = "<пароль пользователя>"
          }
          <дополнительные настройки эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-source.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs %}

- Консоль управления

    {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql-source.md) %}

- CLI

    *  Тип эндпоинта — `mysql-source`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-source.md) %}

- {{ TF }}

    *  Тип эндпоинта — `mysql_source`.

    {% include [On premise MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-source.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        mysql_source {
          security_groups = [ "список идентификаторов групп безопасности" ]
          connection {
            on_premise {
              hosts = ["<список хостов>"]
              port  = <порт для подключения>
            }
          }
          database = "<имя переносимой базы данных>"
          user     = "<имя пользователя для подключения>"
          password {
            raw = "<пароль пользователя>"
          }
          <дополнительные настройки эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-source.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **Список включённых таблиц** — будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * **Список исключённых таблиц** — данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * **Перенос схемы** — позволяет выбрать элементы схемы БД, которые будут перенесены в процессе активации или деактивации трансфера.

    * **Часовой пояс базы** — указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется локальная таймзона сервера.

    * **БД для служебных таблиц** — база данных для технических таблиц (`__tm_keeper`,` __tm_gtid_keeper`). По умолчанию это БД, из которой происходит перенос данных.

- CLI

    * `--include-table-regex` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `--exclude-table-regex` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * `--timezone` — часовой пояс базы, указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    * Настройки переноса схемы:
        * `--transfer-before-data` — при активации трансфера.
        * `--transfer-after-data` — при деактивации трансфера.

- {{ TF }}

    * `include_table_regex` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `exclude_table_regex` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * `timezone` — часовой пояс базы, указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    * `object_transfer_settings` — настройки переноса схемы:

        * `view` — представления;
        * `routine` — процедуры и функции;
        * `trigger` — триггеры.

        Для каждой сущности может быть задано одно из значений:

        * `BEFORE_DATA` — перенос на этапе активации трансфера;
        * `AFTER_DATA` — перенос на этапе деактивации трансфера;
        * `NEVER` — не переносить.

- API

    * `includeTablesRegex` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `excludeTablesRegex` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * `timezone` — часовой пояс базы, указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    * `objectTransferSettings` — настройки переноса схемы при активации и деактивации трансфера (значения `BEFORE_DATA` и `AFTER_DATA`, соответственно).

{% endlist %}

### Настройки переноса схемы при активации и деактивации трансфера {#schema-migrations-settings}

В процессе работы трансфера схема базы данных переносится с источника на приемник. Перенос выполняется в два этапа:

1. На стадии активации.

    Этап выполняется перед копированием или репликацией для создания схемы на приемнике. На этом этапе вы можете включить перенос представлений, хранимых процедур и функций, триггеров.

1. На стадии деактивации.

    Этот этап выполняется в конце работы трансфера, при его деактивации. Если трансфер постоянно работает в режиме репликации, то финальная стадия переноса будет выполнена только при остановке репликации. На этом этапе вы можете включить перенос представлений, хранимых процедур и функций, триггеров.

    На финальной стадии предполагается, что при деактивации трансфера на источнике нет пишущей нагрузки. Это можно гарантировать переводом в режим <q>только чтение</q> (read-only). На этой стадии схема базы данных на приемнике приводится в состояние, когда она будет консистентна схеме на источнике.

## Известные ограничения {#known-limitations}

Если вы настраиваете трансфер из кластера {{ MY }}, используйте мастер-сервер кластера. Во время своей работы трансфер создает служебные таблицы в базе-источнике. Поэтому нельзя использовать в качестве источника реплику {{ MY }}, так как она доступна только для чтения.