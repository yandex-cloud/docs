---
title: Репликация в {{ mch-full-name }}
description: Из статьи вы узнаете, как работает репликация хостов кластера в {{ mch-full-name }}.
---

# Репликация в {{ mch-name }}

Репликация в {{ CH }} осуществляется, если в кластере одновременно выполняются следующие условия:

* существует хотя бы один шард с двумя или более хостами;
* настроен механизм [координации](coordination-system.md) между хостами.

Кластер {{ mch-name }}, в котором функционирует репликация, считается [высокодоступным](high-availability.md). В таком кластере доступно создание [реплицируемых таблиц](#replicated-tables) и [реплицируемых баз данных](#replicated-db).

## Реплицируемые таблицы {#replicated-tables}

{{ CH }} поддерживает автоматическую репликацию только для таблиц на [движке семейства ReplicatedMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication). Чтобы обеспечить репликацию, вы можете создать такие таблицы на каждом хосте по отдельности или использовать распределенный DDL-запрос.

{% note warning %}

Рекомендуется создавать реплицируемые таблицы на всех хостах кластера, иначе может произойти потеря данных после восстановления кластера из [резервной копии](backup.md) или [миграции хостов кластера](../operations/host-migration.md) в другую зону доступности.

{% endnote %}

Чтобы создать таблицу `ReplicatedMergeTree` на определенном хосте {{ CH }}, отправьте запрос следующего вида:

```sql
CREATE TABLE db_01.table_01 (
    log_date date,
    user_name String) ENGINE = ReplicatedMergeTree ('/table_01', '{replica}'
)
PARTITION BY log_date
ORDER BY
    (log_date, user_name);
```

Здесь:

* `db_01` — имя базы данных.
* `table_01` — имя таблицы.
* `/table_01` — путь к таблице в {{ ZK }} или {{ CK }}, обязательно должен начинаться с прямого слэша `/`.
* `{replica}` — макроподстановка идентификатора хоста.

Чтобы создать реплицируемые таблицы на всех хостах кластера, отправьте [распределенный DDL-запрос]({{ ch.docs }}{{ lang }}/sql-reference/distributed-ddl):

```sql
CREATE TABLE db_01.table_01 ON CLUSTER '{cluster}' (
    log_date date,
    user_name String) ENGINE = ReplicatedMergeTree ('/table_01', '{replica}'
)
PARTITION BY log_date
ORDER BY
    (log_date, user_name);
```

Аргумент `'{cluster}'` автоматически разрешится в идентификатор кластера {{ CH }}.

Об организации взаимодействия реплицированных и распределенных таблиц в кластере {{ CH }} см. в разделе [Шардирование](sharding.md).

## Реплицируемые базы данных {#replicated-db}

В {{ CH }} при [создании базы данных](../operations/databases.md#add-db) можно выбрать движок Replicated. Он обеспечивает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.

Движок задается при создании базы данных и не может быть изменен для этой базы.

## Примеры использования {#examples}

* [{#T}](../tutorials/rdbms-to-clickhouse.md)
* [{#T}](../tutorials/ydb-to-clickhouse.md)
* [{#T}](../tutorials/object-storage-to-clickhouse.md)
* [{#T}](../tutorials/mysql-to-clickhouse.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
