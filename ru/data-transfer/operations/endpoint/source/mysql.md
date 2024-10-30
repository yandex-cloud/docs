---
title: Как настроить эндпоинт-источник {{ MY }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ MY }} в {{ data-transfer-full-name }}.
---
# Передача данных из эндпоинта-источника {{ MY }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы {{ MY }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ MY }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ MY }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Миграция кластера {{ MY }}](../../../tutorials/managed-mysql-to-mysql.md);
    * [Миграция со сменой хранилища: {{ MY }} в {{ ydb-short-name }}](../../../tutorials/managed-mysql-to-ydb.md);
    * [Миграция со сменой хранилища: {{ MY }} в {{ PG }}](../../../tutorials/mmy-to-mpg.md);
    * [Миграция со сменой хранилища: {{ MY }} в {{ GP }}](../../../tutorials/mmy-to-mgp.md).

1. {% include [cdc](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}

    * [Захват изменений из {{ MY }} и поставка в {{ DS }}](../../../tutorials/mmy-to-yds.md);
    * [Захват изменений из {{ MY }} и поставка в {{ KF }}](../../../tutorials/cdc-mmy.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Загрузка данных из {{ MY }} в витрину {{ CH }}](../../../tutorials/mysql-to-clickhouse.md).

1. {% include [storage](../../../../_includes/data-transfer/scenario-captions/storage.md) %}

    * [Загрузка данных {{ MY }} в масштабируемое хранилище {{ objstorage-name }}](../../../tutorials/mmy-objs-migration.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/mysql-prepare.md) %}

## Настройка эндпоинта-источника {{ MY }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmy-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ mmy-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mmy.viewer }}`](../../../../managed-mysql/security/index.md#mmy-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

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

### Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql-source.md) %}

- CLI {#cli}

    * Тип эндпоинта — `mysql-source`.

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

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.table_filter.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

            {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

        Регулярные выражения для включенных и исключенных таблиц должны соответствовать правилам именования идентификаторов в {{ MY }}. Подробнее читайте в [документации {{ MY }}]({{ my.docs }}/refman/8.0/en/identifiers.html). Экранирование двойных кавычек не требуется.

        {% note warning %}

        Если имя включаемой или исключаемой таблицы совпадает с именем базы данных, для корректной работы фильтра укажите таблицу в формате `<имя_БД>.<имя_таблицы>`.

        {% endnote %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.object_transfer_settings.title }}** — позволяет выбрать элементы схемы БД, которые будут перенесены в процессе активации или деактивации трансфера.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.advanced_settings.title }}**:

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

#### Настройки переноса схемы при активации и деактивации трансфера {#schema-migrations-settings}

В процессе работы трансфера схема базы данных переносится с источника на приемник. Перенос выполняется в два этапа:

1. На стадии активации.

    Этап выполняется перед копированием или репликацией для создания схемы на приемнике. На этом этапе вы можете включить перенос представлений, хранимых процедур и функций, триггеров.

1. На стадии деактивации.

    Этот этап выполняется в конце работы трансфера, при его деактивации. Если трансфер постоянно работает в режиме репликации, то финальная стадия переноса будет выполнена только при остановке репликации. На этом этапе вы можете включить перенос представлений, хранимых процедур и функций, триггеров.

    На финальной стадии предполагается, что при деактивации трансфера на источнике нет пишущей нагрузки. Это можно гарантировать переводом в режим «только чтение» (read-only). На этой стадии схема базы данных на приемнике приводится в состояние, когда она будет консистентна схеме на источнике.

### Известные ограничения {#known-limitations}

Если вы настраиваете трансфер из кластера {{ MY }} в кластер {{ CH }}, учитывайте особенности переноса данных с [типами для хранения даты и времени]({{ my.docs }}/refman/8.0/en/date-and-time-types.html):

* Данные с типом `TIME` переносятся как строки, часовые пояса источника и приемника не учитываются.
* При переносе данных с типом `TIMESTAMP` применяется часовой пояс, указанный в настройках источника {{ MY }} или в [дополнительных настройках эндпоинта](#additional-settings). Подробнее см. в [документации {{ MY }}]({{ my.docs }}/refman/8.0/en/datetime.html).
* Эндпоинт-источник присваивает данным с типом `DATETIME` часовой пояс UTC+0.

Для трансфера из {{ MY }} в базу данных другого вида не поддерживается перенос полей с типом `DECIMAL`, чтобы избежать потери точности данных. Для трансфера из {{ MY }} в {{ MY }} такого ограничения нет.

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ MY }}](../target/mysql.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ ES }}](../target/elasticsearch.md);
* [{{ OS }}](../target/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Действия с базой данных во время трансфера {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/mysql-work-with-db.md) %}

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ MY }}:

* [Размер лога одной транзакции превышает 4 ГБ](#binlog-size)
* [Не добавляются новые таблицы](#no-new-tables)
* [Ошибка при трансфере из AWS RDS for {{ MY }}](#aws-binlog-time)
* [Ошибка трансфера при переносе таблиц без первичных ключей](#primary-keys)
* [Ошибка обращения к бинарному логу](#binlog-bytes)
* [Ошибка удаления таблицы при политике очистки Drop](#drop-table-error)
* [Сдвиг времени в типе данных DATETIME при трансфере в {{ CH }}](#timeshift)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [binlog-size](../../../../_includes/data-transfer/troubles/mysql/binlog-size.md) %}

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [aws-binlog-time](../../../../_includes/data-transfer/troubles/mysql/aws-binlog-time.md) %}

{% include [primary-keys](../../../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [binlog-bytes](../../../../_includes/data-transfer/troubles/mysql/binlog-bytes.md) %}

{% include [drop-table-error](../../../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [timezone-shift](../../../../_includes/data-transfer/troubles/mysql/timezone-shift.md) %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
