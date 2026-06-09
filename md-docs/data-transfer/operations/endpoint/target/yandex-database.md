# Передача данных в эндпоинт-приемник {{ ydb-name }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ ydb-name }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ ydb-name }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ ydb-name }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

    * [Миграция со сменой хранилища: {{ MY }} в {{ ydb-short-name }}](../../../tutorials/managed-mysql-to-ydb.md);
    * [Миграция со сменой хранилища: {{ PG }} в {{ ydb-short-name }}](../../../tutorials/mpg-to-ydb.md);
    * [Миграция со сменой хранилища: {{ OS }} в {{ ydb-short-name }}](../../../tutorials/opensearch-to-ydb.md).

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.

    * [Поставка данных из {{ KF }} в {{ ydb-short-name }}](../../../tutorials/mkf-to-ydb.md);
    * [Поставка данных из {{ DS }} в {{ ydb-short-name }}](../../../tutorials/yds-to-ydb.md).
1. Загрузка данных в витрины — процесс трансфера подготовленных данных в хранилища с целью последующей визуализации.

    * [Загрузка данных из {{ objstorage-name }} в {{ ydb-short-name }}](../../../tutorials/object-storage-to-ydb.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ MY }}](../source/mysql.md);
* [{{ KF }}](../source/kafka.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md);
* [{{ ytsaurus-name }}](../source/yt.md);
* [{{ PG }}](../source/postgresql.md);
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) с ролью `ydb.editor`.
1. Для базы данных в {{ dd }}-режиме [создайте](../../../../vpc/operations/security-group-create.md) и [настройте](../../../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.

## Настройка эндпоинта-приемника {{ ydb-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к базе данных {{ ydb-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ ydb-full-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `ydb.viewer`](../../../../ydb/security/index.md#ydb-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите из списка базу данных [{{ ydb-name }}](../../../../ydb/index.md).
    
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите или [создайте](../../../../iam/operations/sa/create.md) [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `ydb.editor`, от имени которого сервис {{ data-transfer-name }} будет подключаться к базе.
        
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:
    
        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).
    
            Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.
    
        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — не очищать.
    
            Выберите эту опцию, если будет производиться только репликация без копирования данных.

- {{ TF }} {#tf}

    * Тип эндпоинта — `ydb_target`.

    * `name` — имя эндпоинта {{ ydb-name }}.
    
    * `database` — путь к базе данных {{ ydb-name }}, в которую переносятся данные.
      
        Вы можете посмотреть путь к БД в [консоли управления]({{ link-console-main }}) на странице с информацией о БД {{ ydb-short-name }}.
      
        >Пример пути к БД: `{{ ydb.path-serverless }}`.
    
    * `cleanup_policy` — выберите способ очистки данных в базе-приемнике перед переносом:
      
      * `YDB_CLEANUP_POLICY_DROP` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию). Таблицы на приемнике будут удалены перед переносом новых таблиц.
      
        Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.
      
      * `YDB_CLEANUP_POLICY_DISABLED` — не очищать.
      
        Выберите эту опцию, если будет производиться только репликация без копирования данных.
    
    
    * `service_account_id` — [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) с ролью `ydb.editor`, от имени которого сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
    
    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
        Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к кластеру. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
        Группы безопасности должны принадлежать той же сети, в которой размещен кластер.
      
        {% note info %}
      
        В {{ TF }} сеть для групп безопасности задавать не нужно.
      
        {% endnote %}

    Пример структуры конфигурационного файла (приведены не все параметры):

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "ydb-target" {
    name        = "<имя_эндпоинта_приемника>"
    settings {
        ydb_target {
          database           = "<путь_целевой_БД>"
          cleanup_policy     = "<политика_очистки_данных>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
    }
    ```


    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.shard_count.title }}** — укажите нужное количество шардов `N`.

        Если настройка задана, в таблицы добавляется колонка `_shard_col`. Значения в ней вычисляются как остаток от деления `H/N`, где `H` — результат хеш-функции от текущего времени, а `N` — указанное настройкой количество шардов.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.default_compression.title }}** — задайте настройку `COMPRESSION` для группы колонок по умолчанию (FAMILY default).
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.path.title }}** — укажите [поддиректорию]({{ ydb.docs }}/concepts/datamodel/dir) для размещения таблиц.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.partition_policy.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_type.title }}** — час, день или месяц.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_size.title }}** — в выбранных единицах измерения.

            По истечении временного интервала, равного выбранной единице измерения, будет удалена самая старая таблица базы и создана новая.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.keep_part_count.title }}** — необходимое количество таблиц в базе-приемнике.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.time_column.title }}** — по значениям какой колонки разбивать (_партицировать_) таблицу. Колонка должна иметь тип <q>время</q>.

            
            Подробнее о партицировании таблиц — в документации [{{ ydb-full-name }}]({{ ydb.docs }}/concepts/datamodel/table#partitioning).


        Если используется эта настройка, в базе-приемнике создается указанное количество таблиц для данных за различные интервалы времени. Имя каждой таблицы выбирается автоматически по дате и времени начала интервала. В зависимости от значений в указанной колонке таблицы-источника, исходные строки распределяются по соответствующим таблицам базы-приемника.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.alt_names.title }}** — заполните, если необходимо переименовать таблицы базы-источника при переносе в базу-приемник.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.is_table_column_oriented.title }}** — выберите эту опцию, чтобы создавать колоночные таблицы (OLAP). По умолчанию используются строковые таблицы (OLTP). 

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.is_schema_migration_disabled.title }}** — выберите, чтобы не изменять схему данных на приемнике при изменении ее на источнике. По умолчанию при изменении схемы на источнике трансфер будет автоматически применять изменения схемы в приемнике: создавать новые таблицы, добавлять новые колонки, добавлять новые перечисляемые значения и перечисляемые типы. По умолчанию не применяются такие изменения, как удаление таблиц или колонок.

- {{ TF }} {#tf}

    * `path` — поддиректория для размещения таблиц.

    * `default_compression` — сжатие для группы колонок по умолчанию.

    * `is_table_column_oriented` — укажите значение `true` чтобы создавать колоночные таблицы (OLAP). По умолчанию используются строковые таблицы (OLTP).

    * `is_schema_migration_disabled` — установите значение `true`, чтобы не изменять схему данных на приемнике при изменении ее на источнике. По умолчанию при изменении схемы на источнике трансфер будет автоматически применять изменения схемы в приемнике: создавать новые таблицы, добавлять новые колонки, добавлять новые перечисляемые значения и перечисляемые типы. По умолчанию не применяются такие изменения, как удаление таблиц или колонок.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ ydb-name }}:

### Прерывание трансфера с ошибкой {#overloaded}

Трансфер типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ прерывается с ошибкой.

Текст ошибки:

```text
/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED
```

Трансфер прерывается из-за ограничения облачной [квоты]({{ link-console-quotas }}) на количество операций с {{ ydb-name }}.

**Решение:**

1. Увеличьте в [квотах {{ ydb-name }}](../../../../ydb/concepts/limits.md) на облако с нужной базой данных значение характеристики **Количество схемных операций в минуту** и [активируйте](../../transfer.md#activate) трансфер повторно.

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).