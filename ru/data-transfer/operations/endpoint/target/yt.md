---
title: Как настроить эндпоинт-приемник {{ ytsaurus-name }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ ytsaurus-name }} в {{ data-transfer-full-name }}.
---

# Передача данных в эндпоинт-приемник {{ ytsaurus-name }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в {{ ytsaurus-name }} и реализовывать различные сценарии переноса, обработки и трансформации данных.


Для {{ ytsaurus-name }} доступны два вида эндпоинтов-приемников:

* `YTSaurus Dynamic` — запись данных в [динамические таблицы](https://ytsaurus.tech/docs/ru/user-guide/dynamic-tables/overview);
* `YTSaurus Static` — запись данных в [статические таблицы](https://ytsaurus.tech/docs/ru/user-guide/storage/static-tables).


Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой данных и [контролируйте трансфер](../../monitoring.md).


## Сценарии передачи данных в {{ ytsaurus-name }} с помощью {{ data-transfer-full-name }} {#scenarios}

Вы можете реализовывать сценарии загрузки данных из таблиц в управляемые базы данных {{ yandex-cloud }} для дальнейшего хранения в облаке, обработки и загрузки в витрины данных для визуализации.

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ KF }}](../source/kafka.md) (трансфер возможен только в приемник вида `YTSaurus Dynamic`);
* [{{ CH }}](../source/clickhouse.md);
* [{{ GP }}](../source/greenplum.md);
* [{{ MG }}](../source/mongodb.md);
* [{{ MY }}](../source/mysql.md);
* [{{ PG }}](../source/postgresql.md);
* [{{ objstorage-full-name }}](../source/object-storage.md);
* [Oracle](../source/oracle.md);
* [{{ ydb-name }}](../source/ydb.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

1. Для трансфера в статические таблицы выдайте права на создание и запись в таблицы (разрешение `write` на директорию с таблицами). Если перед трансфером выполняется очистка данных, выдайте разрешение `remove`. Также для трансфера потребуется право `use` на аккаунт, ассоциированный с директорией, в которой будут находиться таблицы.

1. Для трансфера в динамические таблицы, помимо прав `write`, `remove` и `use`, выдайте разрешение на `mount` таблиц.

## Настройка эндпоинта-приемника {{ ytsaurus-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ myt-full-name }}](#cluster). Эти параметры обязательные.
* [Расширенные настройки](#additional-settings).

### Поддерживаемые схемы поставок данных и ограничения {#supported-transfers}

| Схемы поставок данных                                             | Уровень поддержки                            | Ограничения                                                                                                                                              |
|-------------------------------------------------------------------|----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Поставка данных в статические таблицы                             | ![image](../../../../_assets/common/yes.svg) | Без трансформации данных (шардирования, ротации или разделения таблицы на подтаблицы).                                                                    |
| Параллельное копирование в статические таблицы                    | ![image](../../../../_assets/common/no.svg)  | В разработке.                                                                                                                        |
| Поставка данных в динамические таблицы через статические          | ![image](../../../../_assets/common/yes.svg) | Все промежуточные операции над частями таблиц производятся нетранзакционно и видны пользователю.<br>Ограничения политики очистки `Disabled` и `Drop` ^1^. |
| Параллельное копирование в динамические таблицы через статические | ![image](../../../../_assets/common/yes.svg) | Все промежуточные операции над частями таблиц производятся нетранзакционно и видны пользователю.<br>Ограничения политики очистки `Disabled` и `Drop` ^1^. |

^1^ Ограничения политики очистки:
* При использовании политики `Disabled` не гарантируется, что новые данные в существующих таблицах имеют приоритет над старыми при пересечении ключей.
* При использовании политики `Drop` очистка старых таблиц производится до момента добавления частей новых таблиц. Это будет исправлено.

{% note warning %}

Для динамических таблиц первичные ключи в данных обязательны. Динамические таблицы {{ ytsaurus-name }} хранят данные в формате `ключ:значение`, где ключ и соответствующее ему значение также обязательно должны быть заданы. При отсутствии значения не ключевых колонок будет создана не ключевая колонка-заглушка `__dummy`. При отсутствии первичного ключа трансфер завершится с ошибкой.

{% endnote %}

### Кластер {{ myt-name }} {#cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  {% include [main-settings](../../../../_includes/data-transfer/fields/yt/ui/main-settings.md) %}

  * **Путь** — путь к папке, в которую будут записываться переносимые трансфером данные.


  * {% include [Cleanup Policy](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop.md) %}

{% endlist %}


### Расширенные настройки {#additional-settings}


#### Настройки для типа базы данных YTSaurus Dynamic

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Настройки таблицы**:

        * {% include [medium](../../../../_includes/data-transfer/fields/yt/ui/medium.md) %}
        * {% include [chunk-format](../../../../_includes/data-transfer/fields/yt/ui/chunk-format.md) %}
        * {% include [atomic-transactions](../../../../_includes/data-transfer/fields/yt/ui/atomic-transactions.md) %}
        * {% include [ttl](../../../../_includes/data-transfer/fields/yt/ui/ttl.md) %}
        * {% include [custom-attributes](../../../../_includes/data-transfer/fields/yt/ui/custom-attributes.md) %}

    * **Настройки процесса записи**:

        * {% include [alter-schema-change](../../../../_includes/data-transfer/fields/alter-schema-change.md) %}
        * {% include [big-value](../../../../_includes/data-transfer/fields/yt/ui/big-value.md) %}
        * {% include [сopy-via-static-table](../../../../_includes/data-transfer/fields/yt/ui/сopy-via-static-table.md) %}
        * {% include [computing-pool](../../../../_includes/data-transfer/fields/yt/ui/computing-pool.md) %}

{% endlist %}

#### Настройки для типа базы данных YTSaurus Static

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Настройки таблицы**:

        * {% include [chunk-format](../../../../_includes/data-transfer/fields/yt/ui/chunk-format.md) %}
        * **Отсортировать статические таблицы** — включите, если нужно, чтобы [записи таблицы были отсортированы](https://ytsaurus.tech/docs/ru/user-guide/storage/static-tables#sorted_tables) по ключу.
        * {% include [custom-attributes](../../../../_includes/data-transfer/fields/yt/ui/custom-attributes.md) %}

    * **Настройки процесса записи**:

        * {% include [big-value](../../../../_includes/data-transfer/fields/yt/ui/big-value.md) %}
        * {% include [computing-pool](../../../../_includes/data-transfer/fields/yt/ui/computing-pool.md) %}

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

