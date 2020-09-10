# Репликация {{ CH }}

{{ mch-short-name }} помогает организовать репликацию для кластеров {{ CH }} из 2 и более хостов с помощью Apache ZooKeeper. Вам нужно только создать таблицы нужного вида, хосты ZooKeeper будут созданы и настроены автоматически.

{% note info %}

Если вы создали кластер {{ CH }} из двух и более хостов, уменьшить количество хостов до одного невозможно.

{% endnote %}

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

### Реплицируемые таблицы {#replicated-tables}

{{ CH }} поддерживает автоматическую репликацию только для таблиц семейства `ReplicatedMergeTree` (см. раздел [Репликация данных](https://clickhouse.yandex/docs/ru/table_engines/replication/) в документации {{ CH }}). Чтобы обеспечить репликацию, вы можете создать такие таблицы на каждом хосте по отдельности или использовать распределенный DDL-запрос.

Чтобы создать таблицу `ReplicatedMergeTree` на определенном хосте {{ CH }}, отправьте запрос следующего вида:

```
CREATE TABLE db_01.table_01 (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}') PARTITION BY log_date ORDER BY (log_date, user_name);
```

Здесь:

* `db_01` — имя базы данных.

* `table_01` — имя таблицы.

* `/table_01` — путь к таблице в ZooKeeper, обязательно должен начинаться с прямого слэша <q>/</q>.

* `{replica}` — макроподстановка идентификатора хоста.


Чтобы создать реплицируемые таблицы на всех хостах кластера, отправьте распределенный DDL-запрос (описан в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/query_language/queries/#ddl-on-cluster)):

```
CREATE TABLE db_01.table_01 ON CLUSTER '{cluster}' (log_date Date, user_name String) \
 ENGINE = ReplicatedMergeTree('/table_01', '{replica}') PARTITION BY log_date ORDER BY (log_date, user_name);
```

Аргумент `'{cluster}'` автоматически разрешится в идентификатор кластера {{ CH }}.


### Хосты ZooKeeper {#zookeeper-hosts}

Для каждого кластера {{ CH }} из 2 и более хостов {{ mch-short-name }} создает кластер из 3 хостов ZooKeeper. Хосты ZooKeeper учитываются при расчете [потребления ресурсов]({{ link-console-quotas }}) и стоимости кластера.

Как управляются хосты ZooKeeper:

* По умолчанию хосты ZooKeeper создаются с минимальным [классом хостов](instance-types.md). Вы можете задать нужный класс хостов при создании кластера [через API](../api-ref/Cluster/create.md).

* {{ mch-short-name }} не предоставляет возможности подключаться к серверам ZooKeeper и настраивать их. Но вы можете изменить ресурсы, выделенные хостам ZooKeeper, изменив класс хостов.

{% if audience != "internal" %}

* Если вы не указали подсети для хостов ZooKeeper, {{ mch-short-name }} автоматически распределит их по подсетям той сети, к которой подключен {{ CH }}-кластер.

{% endif %}

Подробнее об использовании ZooKeeper для управления репликацией в {{ CH }} см. [документацию {{ CH }}](https://clickhouse.yandex/docs/ru/operations/table_engines/replication/).
