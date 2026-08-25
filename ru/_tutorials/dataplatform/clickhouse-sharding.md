# Шардирование таблиц в {{ CH }}


В [шардированном кластере {{ CH }}](../../managed-clickhouse/concepts/sharding.md#uses) для распределения данных таблицы можно использовать как все шарды кластера, так и их часть — [группу шардов](../../managed-clickhouse/operations/shard-groups.md).

Организовать распределенное хранение данных таблицы на шардах кластера можно тремя способами:
* [Использование всех шардов](#shard-example): локальная и распределенная таблицы создаются на всех шардах кластера.
* [Использование одной группы шардов](#shard-groups-example): локальная и распределенная таблицы создаются на всех шардах группы.
* [Использование двух групп шардов](#shard-groups-advanced-example): локальная таблица создается на шардах одной группы, а распределенная таблица — на шардах другой группы.

Чтобы распределить данные таблицы по шардам:

1. [Создайте таблицы с данными](#create-tables).
1. [Проверьте работоспособность таблиц](#sharding-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mch-name }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам {{ ZK }}), и дискового пространства ([тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер](../../managed-clickhouse/operations/cluster-create.md) {{ mch-name }} с хостами в публичном доступе и настройками:

        * **{{ ui-key.yacloud.mdb.forms.base_field_name }}** — `chcluster`.
        * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}** — выберите нужный тип дисков.

            От выбранного типа дисков зависит минимальное количество хостов в каждом шарде:

            * Два хоста, если выбраны локальные SSD-диски (`local-ssd`).
            * Три хоста, если выбраны сетевые нереплицируемые диски (`network-ssd-nonreplicated`).

            Дополнительные хосты для этих типов дисков необходимы для обеспечения отказоустойчивости.

            Подробнее в разделе [{#T}](../../managed-clickhouse/concepts/storage.md).

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `tutorial`.

        {% include [public-access](../../_includes/mdb/note-public-access.md) %}

    1. [Создайте два дополнительных шарда](../../managed-clickhouse/operations/shards.md#add-shard) с именами `shard2`, `shard3`.
    1. [Добавьте в кластер три хоста {{ ZK }}](../../managed-clickhouse/operations/zk-hosts.md#add-zk).
    1. [Создайте группы шардов](../../managed-clickhouse/operations/shard-groups.md#create-shard-group). Их количество зависит от типа шардирования:

        * [Шардирование с использованием групп шардов](#shard-groups-example) требует одну группу шардов с именем `sgroup`, которая включает шарды `shard1` и `shard2`.
        * [Продвинутое шардирование с использованием групп шардов](#shard-groups-advanced-example) требует две группы:
            * `sgroup` включает `shard1` и `shard2`.
            * `sgroup_data` включает `shard3`.

         Для [классического шардирования](#shard-example) создание групп шардов не требуется.

    
    1. Если вы используете группы безопасности, [настройте их](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) так, чтобы к кластеру можно было подключаться из интернета.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации для одного из описанных ниже примеров шардирования:

        * [simple-sharding.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/simple-sharding.tf) — классическое шардирование.
        * [sharding-with-groups.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/advanced-sharding-with-groups.tf) — шардирование с использованием групп шардов.
        * [advanced-sharding-with-groups.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/advanced-sharding-with-groups.tf) — продвинутое шардирование с использованием групп шардов.

        В каждом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру из интернета;
        * кластер {{ mch-name }} с необходимыми хостами и шардами.

    1. Укажите в конфигурационном файле имя пользователя и пароль, которые будут использоваться для доступа к кластеру {{ mch-name }}.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Настройте clickhouse-client {#deploy-clickhouse-client}

[Установите и настройте clickhouse-client](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client), чтобы иметь возможность подключаться с его помощью к базе данных.

## Создайте таблицы с данными {#create-tables}

Пусть необходимо распределить по шардам данные [таблицы]({{ ch.docs }}{{ lang }}/getting-started/example-datasets/metrica) `hits_v1`.

Структура таблицы, которую нужно подставить вместо обозначения `<структура_таблицы>`, приведена [в документации {{ CH }}]({{ ch.docs }}{{ lang }}/getting-started/example-datasets/metrica#create-the-database-and-table).

В примерах в качестве ключа шардирования используется выражение `rand()`, которое распределяет данные между шардами случайным образом.

### Использование всех шардов {#shard-example}

В этом примере распределенная и локальная таблицы создаются на всех шардах `shard1`, `shard2`, `shard3` кластера.

Перед созданием распределенной таблицы:

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) на всех хостах кластера:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER '{cluster}' ( <структура_таблицы> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

Чтобы создать распределенную таблицу `hits_v1_distributed` в кластере:

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   Здесь допустимо вместо явного указания структуры таблицы использовать выражение `AS tutorial.hits_v1`, т. к. таблицы `hits_v1_distributed` и `hits_v1` находятся на одних и тех же хостах кластера.

   При создании таблицы на движке [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed) укажите идентификатор кластера `chcluster`. Его можно получить со [списком кластеров в каталоге](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   {% note tip %}

   Вместо идентификатора кластера можно использовать макрос `{cluster}` — при выполнении запроса идентификатор кластера, в котором выполняется операция `CREATE TABLE`, будет подставлен автоматически.

   {% endnote %}

### Использование одной группы шардов {#shard-groups-example}

В этом примере распределенная и локальная таблицы создаются в одной группе шардов `sgroup`.

Перед созданием распределенной таблицы:

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) на всех хостах группы шардов `sgroup`:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup ( <структура_таблицы> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

Чтобы создать распределенную таблицу `tutorial.hits_v1_distributed` в кластере:

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup AS tutorial.hits_v1
   ENGINE = Distributed(sgroup, tutorial, hits_v1, rand())
   ```

   Здесь допустимо вместо явного указания структуры таблицы использовать выражение `AS tutorial.hits_v1`, т. к. таблицы `hits_v1_distributed` и `hits_v1` используют один шард и находятся на одних и тех же хостах.

### Использование двух групп шардов {#shard-groups-advanced-example}

В этом примере:
* распределенная таблица создается в группе шардов `sgroup`;
* локальная таблица создается в группе шардов `sgroup_data`.

Перед созданием распределенной таблицы:

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте локальную таблицу `hits_v1` на движке [ReplicatedMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication) на всех хостах группы шардов `sgroup_data`:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup_data ( <структура_таблицы> )
   ENGINE = ReplicatedMergeTree('/tables/{shard}/hits_v1', '{replica}')
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

   Движок ReplicatedMergeTree используется для обеспечения отказоустойчивости.

Чтобы создать распределенную таблицу `tutorial.hits_v1_distributed` в кластере:

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed) на всех хостах группы шардов `sgroup`:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup ( <структура_таблицы> )
   ENGINE = Distributed(sgroup_data, tutorial, hits_v1, rand())
   ```

   Здесь необходимо явно указать структуру распределенной таблицы, т. к. таблицы `hits_v1_distributed` и `hits_v1` используют разные шарды и находятся на разных хостах.

## Проверьте работоспособность таблиц {#sharding-test}

Чтобы проверить работоспособность созданной распределенной таблицы `tutorial.hits_v1_distributed`:

1. Загрузите тестовый набор данных `hits_v1`:

   
   ```bash
   curl https://{{ s3-storage-host }}/doc-files/managed-clickhouse/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```


1. Наполните таблицу тестовыми данными:

   ```bash
   clickhouse-client \
      --host "<FQDN_любого_хоста_с_распределенной_таблицей>" \
      --secure \
      --port 9440 \
      --user "<имя_пользователя>" \
      --password "<пароль_пользователя>" \
      --database "tutorial" \
      --query "INSERT INTO tutorial.hits_v1_distributed FORMAT TSV" \
      --max_insert_block_size=100000 < hits_v1.tsv
   ```

    Чтобы узнать имена хостов, посмотрите [список хостов {{ CH }} в кластере](../../managed-clickhouse/operations/hosts.md#list-hosts).

1. Выполните один или несколько тестовых запросов к этой таблице. Например, можно узнать количество строк в ней:

   ```sql
   SELECT count() FROM tutorial.hits_v1_distributed
   ```

    Результат:

    ```text
    8873898
    ```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).
    1. Если для доступа к кластеру использовались статические публичные IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
