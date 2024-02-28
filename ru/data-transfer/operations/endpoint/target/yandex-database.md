---
title: "Как настроить эндпоинт-приемник {{ ydb-name }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ ydb-name }} в {{ data-transfer-full-name }}."
---
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

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    
    * [Миграция со сменой хранилища: {{ MY }} в {{ ydb-short-name }}](../../../tutorials/managed-mysql-to-ydb.md);
    * [Миграция со сменой хранилища: {{ PG }} в {{ ydb-short-name }}](../../../tutorials/mpg-to-ydb.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    
    * [Поставка данных из {{ KF }} в {{ ydb-short-name }}](../../../tutorials/mkf-to-ydb.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Загрузка данных из {{ objstorage-name }} в {{ ydb-short-name }}](../../../tutorials/object-storage-to-ydb.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ KF }}](../source/kafka.md);
* [Aibyte](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/ydb-prepare.md) %}

## Настройка эндпоинта-приемника {{ ydb-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к базе данных {{ ydb-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ ydb-full-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `ydb.viewer`](../../../../ydb/security/index.md#ydb-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [YDB UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-database.md) %}

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.shard_count.title }}** — укажите нужное количество шардов `N`.

        Если настройка задана, в таблицы добавляется колонка `_shard_col`. Значения в ней вычисляются как остаток от деления `H/N`, где `H` — результат хеш-функции от текущего времени, а `N` — указанное настройкой количество шардов.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.default_compression.title }}** — задайте настройку `COMPRESSION` для группы колонок по умолчанию (FAMILY default).
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.path.title }}** — укажите [поддиректорию](https://ydb.tech/ru/docs/concepts/datamodel/dir) для размещения таблиц.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.partition_policy.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_type.title }}** — час, день или месяц.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_size.title }}** — в выбранных единицах измерения.

            По истечении временного интервала, равного выбранной единице измерения, будет удалена самая старая таблица базы и создана новая.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.keep_part_count.title }}** — необходимое количество таблиц в базе-приемнике.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.time_column.title }}** — по значениям какой колонки разбивать (_партицировать_) таблицу. Колонка должна иметь тип <q>время</q>.

            
            Подробнее о партицировании таблиц см. в документации [{{ ydb-full-name }}](https://ydb.tech/ru/docs/concepts/datamodel/table#partitioning).


        Если используется эта настройка, в базе-приемнике создается указанное количество таблиц для данных за различные интервалы времени. Имя каждой таблицы выбирается автоматически по дате и времени начала интервала. В зависимости от значений в указанной колонке таблицы-источника, исходные строки распределяются по соответствующим таблицам базы-приемника.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.alt_names.title }}** — заполните, если необходимо переименовать таблицы базы-источника при переносе в базу-приемник.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.is_table_column_oriented.title }}** — выберите эту опцию, чтобы создавать колоночные таблицы (OLAP). По умолчанию используются строковые таблицы (OLTP). 

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ ydb-name }}:

{% include [overloaded](../../../../_includes/data-transfer/troubles/overloaded.md) %}

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).