---
title: "Как настроить эндпоинт-источник {{ MY }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ MY }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-источника {{ MY }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmy-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mmy-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mmy.viewer }}`](../../../../managed-mysql/security/index.md#mmy-viewer) или примитивная [роль `viewer`](../../../../iam/concepts/access-control/roles.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql-source.md) %}

- CLI {#cli}

    * Тип эндпоинта — `mysql-source`.

    {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-source.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `mysql_source`.

    {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-source.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mysql_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            mdb_cluster_id = "<идентификатор_кластера>"
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-source.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql-source.md) %}

- CLI {#cli}

    *  Тип эндпоинта — `mysql-source`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-source.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `mysql_source`.

    {% include [On premise MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-source.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mysql_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            on_premise {
              hosts = ["<список_хостов>"]
              port  = <порт_для_подключения>
            }
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-source.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.object_transfer_settings.title }}** — позволяет выбрать элементы схемы БД, которые будут перенесены в процессе активации или деактивации трансфера.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSourceAdvancedSettings.timezone.title }}** — указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется локальная таймзона сервера.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSourceAdvancedSettings.service_database.title }}** — база данных для технических таблиц (`__tm_keeper`, `__tm_gtid_keeper`). По умолчанию это БД, из которой происходит перенос данных.

- CLI {#cli}

    * `--include-table-regex` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `--exclude-table-regex` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * `--timezone` — часовой пояс базы, указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    * Настройки переноса схемы:
        * `--transfer-before-data` — при активации трансфера.
        * `--transfer-after-data` — при деактивации трансфера.

- {{ TF }} {#tf}

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

- API {#api}

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

Если вы настраиваете трансфер из кластера {{ MY }} в кластер {{ CH }}, учитывайте особенности переноса данных с [типами для хранения даты и времени]({{ my.docs }}/refman/8.0/en/date-and-time-types.html):

* Данные с типом `TIME` переносятся как строки, часовые пояса источника и приемника не учитываются.
* При переносе данных с типом `TIMESTAMP` применяется часовой пояс, указанный в настройках источника {{ MY }} или в [дополнительных настройках эндпоинта](#additional-settings). Подробнее см. в [документации {{ MY }}]({{ my.docs }}/refman/8.0/en/datetime.html).
* Эндпоинт-источник присваивает данным с типом `DATETIME` часовой пояс UTC+0.

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}