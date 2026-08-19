[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Практические руководства](index.md) > Шардирование таблиц

# Шардирование таблиц в ClickHouse®


В [шардированном кластере ClickHouse®](../concepts/sharding.md#uses) для распределения данных таблицы можно использовать как все шарды кластера, так и их часть — [группу шардов](../operations/shard-groups.md).

Организовать распределенное хранение данных таблицы на шардах кластера можно тремя способами:
* [Использование всех шардов](#shard-example): локальная и распределенная таблицы создаются на всех шардах кластера.
* [Использование одной группы шардов](#shard-groups-example): локальная и распределенная таблицы создаются на всех шардах группы.
* [Использование двух групп шардов](#shard-groups-advanced-example): локальная таблица создается на шардах одной группы, а распределенная таблица — на шардах другой группы.

Чтобы распределить данные таблицы по шардам:

1. [Создайте таблицы с данными](#create-tables).
1. [Проверьте работоспособность таблиц](#sharding-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for ClickHouse®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства ([тарифы Managed Service for ClickHouse®](../pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер](../operations/cluster-create.md) Managed Service for ClickHouse® с хостами в публичном доступе и настройками:

        * **Имя кластера** — `chcluster`.
        * **Тип диска** — выберите нужный тип дисков.

            От выбранного типа дисков зависит минимальное количество хостов в каждом шарде:

            * Два хоста, если выбраны локальные SSD-диски (`local-ssd`).
            * Три хоста, если выбраны сетевые нереплицируемые диски (`network-ssd-nonreplicated`).

            Дополнительные хосты для этих типов дисков необходимы для обеспечения отказоустойчивости.

            Подробнее в разделе [Хранилище в Managed Service for ClickHouse®](../concepts/storage.md).

        * **Имя БД** — `tutorial`.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. [Создайте два дополнительных шарда](../operations/shards.md#add-shard) с именами `shard2`, `shard3`.
    1. [Добавьте в кластер три хоста ZooKeeper](../operations/zk-hosts.md#add-zk).
    1. [Создайте группы шардов](../operations/shard-groups.md#create-shard-group). Их количество зависит от типа шардирования:

        * [Шардирование с использованием групп шардов](#shard-groups-example) требует одну группу шардов с именем `sgroup`, которая включает шарды `shard1` и `shard2`.
        * [Продвинутое шардирование с использованием групп шардов](#shard-groups-advanced-example) требует две группы:
            * `sgroup` включает `shard1` и `shard2`.
            * `sgroup_data` включает `shard3`.

         Для [классического шардирования](#shard-example) создание групп шардов не требуется.

    
    1. Если вы используете группы безопасности, [настройте их](../operations/connect/index.md#configuring-security-groups) так, чтобы к кластеру можно было подключаться из интернета.


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации для одного из описанных ниже примеров шардирования:

        * [simple-sharding.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/simple-sharding.tf) — классическое шардирование.
        * [sharding-with-groups.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/advanced-sharding-with-groups.tf) — шардирование с использованием групп шардов.
        * [advanced-sharding-with-groups.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/advanced-sharding-with-groups.tf) — продвинутое шардирование с использованием групп шардов.

        В каждом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру из интернета;
        * кластер Managed Service for ClickHouse® с необходимыми хостами и шардами.

    1. Укажите в конфигурационном файле имя пользователя и пароль, которые будут использоваться для доступа к кластеру Managed Service for ClickHouse®.
    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.
    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

### Настройте clickhouse-client {#deploy-clickhouse-client}

[Установите и настройте clickhouse-client](../operations/connect/clients.md#clickhouse-client), чтобы иметь возможность подключаться с его помощью к базе данных.

## Создайте таблицы с данными {#create-tables}

Пусть необходимо распределить по шардам данные [таблицы](https://clickhouse.com/docs/ru/getting-started/example-datasets/metrica) `hits_v1`.

Структура таблицы, которую нужно подставить вместо обозначения `<структура_таблицы>`, приведена [в документации ClickHouse®](https://clickhouse.com/docs/ru/getting-started/example-datasets/metrica#create-the-database-and-table).

В примерах в качестве ключа шардирования используется выражение `rand()`, которое распределяет данные между шардами случайным образом.

### Использование всех шардов {#shard-example}

В этом примере распределенная и локальная таблицы создаются на всех шардах `shard1`, `shard2`, `shard3` кластера.

Перед созданием распределенной таблицы:

1. [Подключитесь](../operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree) на всех хостах кластера:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER '{cluster}' ( <структура_таблицы> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

Чтобы создать распределенную таблицу `hits_v1_distributed` в кластере:

1. [Подключитесь](../operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed](https://clickhouse.com/docs/ru/engines/table-engines/special/distributed):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   Здесь допустимо вместо явного указания структуры таблицы использовать выражение `AS tutorial.hits_v1`, т. к. таблицы `hits_v1_distributed` и `hits_v1` находятся на одних и тех же хостах кластера.

   При создании таблицы на движке [Distributed](https://clickhouse.com/docs/ru/engines/table-engines/special/distributed) укажите идентификатор кластера `chcluster`. Его можно получить со [списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

   {% note tip %}

   Вместо идентификатора кластера можно использовать макрос `{cluster}` — при выполнении запроса идентификатор кластера, в котором выполняется операция `CREATE TABLE`, будет подставлен автоматически.

   {% endnote %}

### Использование одной группы шардов {#shard-groups-example}

В этом примере распределенная и локальная таблицы создаются в одной группе шардов `sgroup`.

Перед созданием распределенной таблицы:

1. [Подключитесь](../operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree) на всех хостах группы шардов `sgroup`:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup ( <структура_таблицы> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

Чтобы создать распределенную таблицу `tutorial.hits_v1_distributed` в кластере:

1. [Подключитесь](../operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed](https://clickhouse.com/docs/ru/engines/table-engines/special/distributed):

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

1. [Подключитесь](../operations/connect/clients.md) к базе `tutorial`.
1. Создайте локальную таблицу `hits_v1` на движке [ReplicatedMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication) на всех хостах группы шардов `sgroup_data`:

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

1. [Подключитесь](../operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу на движке [Distributed](https://clickhouse.com/docs/ru/engines/table-engines/special/distributed) на всех хостах группы шардов `sgroup`:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup ( <структура_таблицы> )
   ENGINE = Distributed(sgroup_data, tutorial, hits_v1, rand())
   ```

   Здесь необходимо явно указать структуру распределенной таблицы, т. к. таблицы `hits_v1_distributed` и `hits_v1` используют разные шарды и находятся на разных хостах.

## Проверьте работоспособность таблиц {#sharding-test}

Чтобы проверить работоспособность созданной распределенной таблицы `tutorial.hits_v1_distributed`:

1. Загрузите тестовый набор данных `hits_v1`:

   
   ```bash
   curl https://storage.yandexcloud.net/doc-files/managed-clickhouse/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
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

    Чтобы узнать имена хостов, посмотрите [список хостов ClickHouse® в кластере](../operations/hosts.md#list-hosts).

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

    1. [Удалите кластер Managed Service for ClickHouse®](../operations/cluster-delete.md).
    1. Если для доступа к кластеру использовались статические публичные IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

- Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._