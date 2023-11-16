---
title: "Как настроить эндпоинт-источник {{ PG }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ PG }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-источника {{ PG }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mpg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

Перед началом работы ознакомьтесь с [особенностями работы сервиса с источниками и приемниками {{ PG }}](../../../concepts/work-with-endpoints.md#postgresql).

## Кластер {{ mpg-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mpg.viewer }}`](../../../../managed-postgresql/security/index.md#mpg-viewer) или примитивная [роль `viewer`](../../../../iam/concepts/access-control/roles.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs %}

- Консоль управления

    {% include [Managed PostgreSQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-postgresql.md) %}

- CLI

    * Тип эндпоинта — `postgres-source`.

    {% include [Managed PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-postgresql.md) %}

- {{ TF }}

    * Тип эндпоинта — `postgres_source`.

    {% include [Managed PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-postgresql.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        postgres_source {
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

- API

    {% include [Managed PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-postgresql.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs %}

- Консоль управления

    {% include [On premise PostgreSQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-postgresql.md) %}

- CLI

    * Тип эндпоинта — `postgres-source`.

    {% include [On premise PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-postgresql.md) %}

- {{ TF }}

    * Тип эндпоинта — `postgres_source`.

    {% include [On premise PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-postgresql.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        postgres_source {
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

- API

    {% include [On premise PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-postgresql.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут.

      Списки включают имя [схемы]({{pg-docs}}/ddl-schemas.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

        * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
        * `<имя_схемы>.*` — все таблицы в указанной схеме.

      {% include [transfer custom types PGSQL](../../../../_includes/data-transfer/custom-types-pgsql.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.object_transfer_settings.title }}** — при необходимости выберите элементы схемы БД, которые будут перенесены в процессе активации или деактивации трансфера.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.slot_byte_lag_limit.title }}** — максимальный размер Write-Ahead Log, удерживаемого слотом репликации. При превышении этого ограничения репликация останавливается и слот репликации удаляется. Значение по умолчанию — 50 ГБ. Данная настройка не обеспечивает защиту от переполнения диска на базе данных источника. Ее возможно использовать только для версии {{ PG }} ниже 13, а рекомендованный способ — это [мониторинг значения слота WAL-лога](../../prepare.md#source-pg) на базе данных источника.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.service_schema.title }}** — укажите имя схемы для хранения служебных таблиц (`__consumer_keeper`, `__data_transfer_mole_finder`).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.collapse_inherit_table.title }}** — выберите для объединения содержимого таблиц. Подробнее см. в разделе [Особенности работы сервиса с источниками и приемниками](../../../concepts/index.md#postgresql).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.snapshot_table_sharding_settings.title }}** — при необходимости задайте детальные настройки параллельного копирования таблиц (если в трансфере заданы параметры параллельного копирования).

- CLI

    * `--include-table` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `--exclude-table` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут.

      Списки включают имя схемы (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

        * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
        * `<имя_схемы>.*` — все таблицы в указанной схеме.

        {% include [transfer custom types PGSQL](../../../../_includes/data-transfer/custom-types-pgsql.md) %}

    * `--slot-lag-limit` — максимальный размер Write-Ahead Log, удерживаемого слотом репликации. При превышении этого ограничения репликация останавливается и слот репликации удаляется. Значение по умолчанию – 50 ГБ.

    * `--service-schema` — имя схемы БД для служебных таблиц.

    * Настройки переноса схемы:

        * `--transfer-before-data` — на первичной стадии трансфера.
        * `--transfer-after-data` — на финальной стадии трансфера.

- {{ TF }}

    * `include_tables` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `exclude_tables` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут.

      Списки включают имя схемы (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

      * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
      * `<имя_схемы>.*` — все таблицы в указанной схеме.

      {% include [transfer custom types PGSQL](../../../../_includes/data-transfer/custom-types-pgsql.md) %}

    * `slot_gigabyte_lag_limit` — максимальный размер Write-Ahead Log, удерживаемого слотом репликации. При превышении этого ограничения репликация останавливается и слот репликации удаляется. Значение по умолчанию – 50 ГБ.

    * `service_schema` — имя схемы БД для служебных таблиц.

    * `object_transfer_settings` — настройки переноса схемы:

        * `sequence` — последовательности;
        * `sequence_owned_by` — пользовательские последовательности;
        * `table` — таблицы;
        * `primary_key` —  первичные ключи;
        * `fk_constraint` — внешние ключи;
        * `default_values` — значения по умолчанию;
        * `constraint` — ограничения;
        * `index` — индексы;
        * `view` — представления;
        * `function` — функции;
        * `trigger` — триггеры;
        * `type` — типы;
        * `rule` — правила;
        * `collation` — правила сортировки;
        * `policy` — политики;
        * `cast` — приведения типов.

        Для каждой сущности может быть задано одно из значений:

        * `BEFORE_DATA` — перенос на этапе активации трансфера;
        * `AFTER_DATA` — перенос на этапе деактивации трансфера;
        * `NEVER` — не переносить.

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    * `includeTables` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `excludeTables` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут.

      Списки включают имя схемы (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

        * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
        * `<имя_схемы>.*` — все таблицы в указанной схеме.

        {% include [transfer custom types PGSQL](../../../../_includes/data-transfer/custom-types-pgsql.md) %}

    * `slotByteLagLimit` — максимальный размер Write-Ahead Log, удерживаемого слотом репликации. При превышении этого ограничения репликация останавливается и слот репликации удаляется. Значение по умолчанию – 50 ГБ.

    * `serviceSchema` — имя схемы БД для служебных таблиц.

    * `objectTransferSettings` — настройки переноса схемы на первичной и финальной стадиях трансфера (значения `BEFORE_DATA` и `AFTER_DATA`, соответственно).

{% endlist %}

### Настройки переноса схемы при активации и деактивации трансфера {#schema-migrations-settings}

{% note info %}

Настройки эндпоинта для источника по умолчанию позволяют успешно выполнить трансфер для большинства баз данных. Изменяйте настройки первичной и финальной стадий переноса только если в этом есть необходимость.

{% endnote %}

В процессе работы трансфера схема базы данных переносится с источника на приемник. Перенос выполняется в два этапа:

1. На стадии активации.

    Этот этап выполняется при активации трансфера перед копированием или репликацией для создания схемы на приемнике. Вы можете выбрать, какие части схемы будут перенесены. По умолчанию это `TABLE`, `VIEW`, `PRIMARY KEY`, `SEQUENCE`, `SEQUENCE OWNED BY`, `RULE`, `TYPE`, `FUNCTION`, `DEFAULT`.

1. На стадии деактивации.

    Эта стадия выполняется в конце работы трансфера, при его деактивации. Если трансфер постоянно работает в режиме репликации, то финальная стадия переноса будет выполнена только при остановке репликации. Вы можете выбрать, какие части схемы будут перенесены.

    На финальной стадии предполагается, что при деактивации трансфера на источнике нет пишущей нагрузки. Это можно гарантировать переводом в режим <q>только чтение</q> (read-only). На этой стадии схема базы данных на приемнике приводится в состояние, когда она будет консистентна схеме на источнике.

    Рекомендуется включать в финальную стадию переноса ресурсоемкие операции, например, перенос индексов. Перенос индексов в начале трансфера может замедлить его работу.

Перенос схемы и на первичной, и на финальных стадиях выполняется с помощью [утилиты](https://www.postgresql.org/docs/current/app-pgdump.html) `pg_dump`.

{% note info %}

При редактировании настроек одного из эндпоинтов трансфера, который находится в состоянии {{ dt-status-repl }}, схемы таблиц на приемнике сохраняются. При этом на приемник переносятся только схемы таблиц, отсутствующих в приемнике на момент перезапуска.

{% endnote %}

Значения позиций в последовательности при репликации нельзя гарантированно сохранить, поэтому рекомендуется сделать обновление `sequence` на приемнике.
