---
title: "Как настроить эндпоинт-приемник {{ ydb-name }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ ydb-name }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-приемника {{ ydb-name }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к базе данных {{ ydb-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ ydb-full-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `ydb.viewer`](../../../../ydb/security/index.md#ydb-viewer) или примитивная [роль `viewer`](../../../../iam/concepts/access-control/roles.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [YDB UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-database.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.shard_count.title }}** — укажите нужное количество шардов `N`.

        Если настройка задана, в таблицы добавляется колонка `_shard_col`. Значения в ней вычисляются как остаток от деления `H/N`, где `H` — результат хеш-функции от текущего времени, а `N` — указанное настройкой количество шардов.


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.partition_policy.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_type.title }}** — час, день или месяц.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_size.title }}** — в выбранных единицах измерения.

            По истечении временного интервала, равного выбранной единице измерения, будет удалена самая старая таблица базы и создана новая.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.keep_part_count.title }}** — необходимое количество таблиц в базе-приемнике.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.time_column.title }}** — по значениям какой колонки разбивать (_партицировать_) таблицу. Колонка должна иметь тип <q>время</q>.

            
            Подробнее о партицировании таблиц см. в документации [{{ ydb-full-name }}](https://ydb.tech/ru/docs/concepts/datamodel/table#partitioning).


        Если используется эта настройка, в базе-приемнике создается указанное количество таблиц для данных за различные интервалы времени. Имя каждой таблицы выбирается автоматически по дате и времени начала интервала. В зависимости от значений в указанной колонке таблицы-источника, исходные строки распределяются по соответствующим таблицам базы-приемника.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.alt_names.title }}** — заполните, если необходимо переименовать таблицы базы-источника при переносе в базу-приемник.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.path.title }}** — укажите [поддиректорию](https://ydb.tech/ru/docs/concepts/datamodel/dir) для размещения таблиц.

        Итоговый путь размещения таблицы: `<путь_в_Yandex_Database>/<поддиректория>/<таблица>`.

{% endlist %}
