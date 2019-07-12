# Репликация ClickHouse

Managed Service for ClickHouse помогает организовать репликацию для кластеров ClickHouse из 2 и более хостов с помощью Apache ZooKeeper. Вам нужно только создать таблицы нужного вида, хосты ZooKeeper будут созданы и настроены автоматически.

{% note info %}

Если вы создали кластер ClickHouse из 2 и более хостов, уменьшить количество хостов до 1 пока невозможно. И наоборот, если вы создали кластер из 1 хоста, добавить хосты в него не получится.

{% endnote %}

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

### Реплицируемые таблицы

ClickHouse поддерживает автоматическую репликацию только для таблиц семейства `ReplicatedMergeTree` (см. раздел [Репликация данных](https://clickhouse.yandex/docs/ru/table_engines/replication/) в документации ClickHouse). Чтобы обеспечить репликацию, вы можете создать такие таблицы на каждом хосте по отдельности или использовать распределенный DDL-запрос.

Чтобы создать таблицу `ReplicatedMergeTree` на определенном хосте ClickHouse, отправьте запрос следующего вида:

```
CREATE TABLE db_01.table_01 (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}', log_date, (log_date, user_name), 8192);
```

Здесь:

* `db_01` — имя базы данных.

* `table_01` — имя таблицы.

* `/table_01` — путь к таблице в ZooKeeper, обязательно должен начинаться с прямого слэша <q>/</q>.

* `{replica}` — макроподстановка идентификатора хоста.


Чтобы создать реплицируемые таблицы на всех хостах кластера, отправьте распределенный DDL-запрос (описан в [документации ClickHouse](https://clickhouse.yandex/docs/ru/query_language/queries/#ddl-on-cluster)):

```
CREATE TABLE db_01.table_01 ON CLUSTER '{cluster}' (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}', log_date, (log_date, user_name), 8192);
```

Аргумент `'{cluster}'` автоматически разрешится в идентификатор кластера ClickHouse.


### Хосты ZooKeeper {#zookeeper-hosts}

Для каждого кластера ClickHouse из 2 и более хостов Managed Service for ClickHouse создает кластер из 3 хостов ZooKeeper. Хосты ZooKeeper учитываются при расчете [потребления ресурсов](https://console.cloud.yandex.ru/cloud?section=quotas) и стоимости кластера.

Как управляются хосты ZooKeeper:

* По умолчанию хосты ZooKeeper создаются с минимальным [классом хостов](instance-types.md). Вы можете задать нужный класс хостов при создании кластера [через API](../api-ref/Cluster/create.md).
* Managed Service for ClickHouse не предоставляет возможности подключаться к серверам ZooKeeper и настраивать их. Но вы можете изменить ресурсы, выделенные хостам ZooKeeper, изменив класс хостов.

* Если вы не указали подсети для хостов ZooKeeper, Managed Service for ClickHouse автоматически распределит их по подсетям той сети, к которой подключен ClickHouse-кластер.

Подробнее об использовании ZooKeeper для управления репликацией в ClickHouse см. [документацию ClickHouse](https://clickhouse.yandex/docs/ru/operations/table_engines/replication/).
