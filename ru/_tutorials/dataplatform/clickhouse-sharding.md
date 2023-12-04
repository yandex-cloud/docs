# Шардирование таблиц в {{ CH }}

[Шардирование](../../glossary/sharding.md) обеспечивает [ряд преимуществ](../../managed-clickhouse/concepts/sharding.md#advantages) при высокой частоте запросов и работе с большими наборами данных. При этом создается распределенная таблица, которая маршрутизирует запросы к нижележащим таблицам. Обращаться к данным в шардированных таблицах можно как через распределенную таблицу, так и напрямую.

Существует три подхода к шардированию:

* Классический, когда распределенная таблица использует все шарды кластера.
* С группами шардов, когда часть шардов объединена в группу.
* Продвинутый с группами шардов, когда шарды разделены на две группы: в одной находится распределенная таблица, в другой — нижележащие таблицы.

Далее рассмотрены примеры настройки шардирования для всех трех подходов.

Подробнее читайте в разделе [{#T}](../../managed-clickhouse/concepts/sharding.md).

Чтобы настроить шардирование:

1. [Создайте таблицы с данными](#create-tables).
1. [Проверьте работоспособность таблиц](#sharding-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

    1. [Создайте кластер](../../managed-clickhouse/operations/cluster-create.md) {{ mch-name }}:

        * **{{ ui-key.yacloud.mdb.forms.base_field_name }}** — `chcluster`.
        * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}** — выберите нужный тип дисков.

            От выбранного типа дисков зависит минимальное количество хостов в каждом шарде:

            * Два хоста, если выбраны локальные SSD-диски (`local-ssd`).
            * Три хоста, если выбраны сетевые нереплицируемые диски (`network-ssd-nonreplicated`).

            Дополнительные хосты для этих типов дисков необходимы для обеспечения отказоустойчивости.

            Подробнее см. в разделе [{#T}](../../managed-clickhouse/concepts/storage.md).

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `tutorial`.

        Хосты кластера должны быть доступны из интернета.

    1. [Создайте два дополнительных шарда](../../managed-clickhouse/operations/shards.md#add-shard) с именами `shard2`, `shard3`.
    1. [Добавьте в кластер три хоста {{ ZK }}](../../managed-clickhouse/operations/zk-hosts.md#add-zk-host).
    1. [Создайте группы шардов](../../managed-clickhouse/operations/shard-groups.md#create-shard-group). Их количество зависит от типа шардирования:

        * [Шардирование с использованием групп шардов](#shard-groups-example) требует одну группу шардов с именем `sgroup`, которая включает шарды `shard1` и `shard2`.
        * [Продвинутое шардирование с использованием групп шардов](#shard-groups-advanced-example) требует две группы:
            * `sgroup` включает `shard1` и `shard2`.
            * `sgroup_data` включает `shard3`.

         Для [классического шардирования](#shard-example) создание групп шардов не требуется.

    
    1. Если вы используете группы безопасности, [настройте их](../../managed-clickhouse/operations/connect.md#configuring-security-groups) так, чтобы к кластеру можно было подключаться из интернета.


- С помощью {{ TF }}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации для одного из описанных ниже примеров шардирования:

        * [simple-sharding.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-sharding/simple-sharding.tf) — классическое шардирование.
        * [sharding-with-group.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-sharding/sharding-with-group.tf) — шардирование с использованием групп шардов.
        * [advanced-sharding-with-groups.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-sharding/advanced-sharding-with-groups.tf) — продвинутое шардирование с использованием групп шардов.

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

[Установите и настройте clickhouse-client](../../managed-clickhouse/operations/connect.md), чтобы иметь возможность подключаться с его помощью к базе данных.

## Создайте таблицы с данными {#create-tables}

Пусть необходимо включить шардирование для [таблицы]({{ ch.docs }}/getting-started/example-datasets/metrica/) `hits_v1`. Текст запроса на создание таблицы зависит от выбранного подхода к шардированию.

Структура таблицы, которую нужно подставить вместо обозначения `<структура_таблицы>`, приведена [в документации {{ CH }}]({{ ch.docs }}/getting-started/tutorial/#create-tables).

После включения шардирования любым из способов, вы сможете отправлять `SELECT`- и `INSERT`-запросы к созданной распределенной таблице, и они будут обрабатываться согласно заданной конфигурации.

В примерах в качестве ключа шардирования используется случайное число `rand()`.

### Классическое шардирование {#shard-example}

В этом примере распределенная таблица, которая будет создана на основе `hits_v1`, использует все шарды `shard1`, `shard2`, `shard3` кластера `chcluster`.

Перед работой с распределенной таблицей:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/), которая будет размещена на всех хостах кластера:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER '{cluster}' ( <структура_таблицы> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

Чтобы создать распределенную таблицу `hits_v1_distributed` в кластере:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   Здесь допустимо вместо явного указания структуры таблицы использовать выражение `AS tutorial.hits_v1`, т. к. таблицы `hits_v1_distributed` и `hits_v1` находятся на одних и тех же хостах кластера.

   При создании таблицы на движке [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) укажите идентификатор кластера `chcluster`. Его можно получить со [списком кластеров в каталоге](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   {% note tip %}

   Вместо идентификатора кластера можно использовать макрос `{cluster}` — при выполнении запроса идентификатор кластера, в котором выполняется операция `CREATE TABLE`, будет подставлен автоматически.

   {% endnote %}

### Шардирование с использованием групп шардов {#shard-groups-example}

В этом примере:

- Используется одна группа шардов `sgroup`.
- Распределенная таблица и нижележащая таблица `hits_v1` расположены в одной группе шардов `sgroup` кластера.

Перед работой с распределенной таблицей:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/), которая использует все хосты группы шардов `sgroup` кластера:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup ( <структура_таблицы> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

Чтобы создать распределенную таблицу `tutorial.hits_v1_distributed` в кластере:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup AS tutorial.hits_v1
   ENGINE = Distributed(sgroup, tutorial, hits_v1, rand())
   ```

   Здесь допустимо вместо явного указания структуры таблицы использовать выражение `AS tutorial.hits_v1`, т. к. таблицы `hits_v1_distributed` и `hits_v1` используют один шард и находятся на одних и тех же хостах.

### Продвинутое шардирование с использованием групп шардов {#shard-groups-advanced-example}

В этом примере:

1. Используются две группы шардов: `sgroup` и `sgroup_data`.
1. Распределенная таблица расположена в группе шардов `sgroup`.
1. Нижележащая таблица `hits_v1` расположена в группе шардов `sgroup_data`.

Перед работой с распределенной таблицей:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/), которая использует все хосты группы шардов `sgroup_data` кластера:

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

1. [Подключитесь](../../managed-clickhouse/operations/connect.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed):

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

{% list tabs %}

- Вручную

    1. [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).
    1. Если для доступа к кластеру использовались статические публичные IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

- С помощью {{ TF }}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл (`simple-sharding.tf` `sharding-with-group.tf` или `advanced-sharding-with-groups.tf`).
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле, будут удалены.

{% endlist %}
