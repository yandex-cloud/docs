[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Шардирование таблиц Managed Service for ClickHouse®

# Шардирование таблиц Yandex Managed Service for ClickHouse®

# Шардирование таблиц в ClickHouse®


[Шардирование](../../glossary/sharding.md) обеспечивает [ряд преимуществ](../../managed-clickhouse/concepts/sharding.md#advantages) при высокой частоте запросов и работе с большими наборами данных. При этом создается распределенная таблица, которая маршрутизирует запросы к нижележащим таблицам. Обращаться к данным в шардированных таблицах можно как через распределенную таблицу, так и напрямую.

Существует три подхода к шардированию:

* Классический, когда распределенная таблица использует все шарды кластера.
* С группами шардов, когда часть шардов объединена в группу.
* Продвинутый с группами шардов, когда шарды разделены на две группы: в одной находится распределенная таблица, в другой — нижележащие таблицы.

Далее рассмотрены примеры настройки шардирования для всех трех подходов.

Подробнее читайте в разделе [Шардирование в Managed Service for ClickHouse®](../../managed-clickhouse/concepts/sharding.md).

Чтобы настроить шардирование:

1. [Создайте таблицы с данными](#create-tables).
1. [Проверьте работоспособность таблиц](#sharding-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for ClickHouse®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер](../../managed-clickhouse/operations/cluster-create.md) Managed Service for ClickHouse® с хостами в публичном доступе и настройками:

        * **Имя кластера** — `chcluster`.
        * **Тип диска** — выберите нужный тип дисков.

            От выбранного типа дисков зависит минимальное количество хостов в каждом шарде:

            * Два хоста, если выбраны локальные SSD-диски (`local-ssd`).
            * Три хоста, если выбраны сетевые нереплицируемые диски (`network-ssd-nonreplicated`).

            Дополнительные хосты для этих типов дисков необходимы для обеспечения отказоустойчивости.

            Подробнее в разделе [Хранилище в Managed Service for ClickHouse®](../../managed-clickhouse/concepts/storage.md).

        * **Имя БД** — `tutorial`.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. [Создайте два дополнительных шарда](../../managed-clickhouse/operations/shards.md#add-shard) с именами `shard2`, `shard3`.
    1. [Добавьте в кластер три хоста ZooKeeper](../../managed-clickhouse/operations/zk-hosts.md#add-zk).
    1. [Создайте группы шардов](../../managed-clickhouse/operations/shard-groups.md#create-shard-group). Их количество зависит от типа шардирования:

        * [Шардирование с использованием групп шардов](#shard-groups-example) требует одну группу шардов с именем `sgroup`, которая включает шарды `shard1` и `shard2`.
        * [Продвинутое шардирование с использованием групп шардов](#shard-groups-advanced-example) требует две группы:
            * `sgroup` включает `shard1` и `shard2`.
            * `sgroup_data` включает `shard3`.

         Для [классического шардирования](#shard-example) создание групп шардов не требуется.

    
    1. Если вы используете группы безопасности, [настройте их](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) так, чтобы к кластеру можно было подключаться из интернета.


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

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

[Установите и настройте clickhouse-client](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client), чтобы иметь возможность подключаться с его помощью к базе данных.

## Создайте таблицы с данными {#create-tables}

Пусть необходимо включить шардирование для [таблицы](https://clickhouse.com/docs/ru/getting-started/example-datasets/metrica) `hits_v1`. Текст запроса на создание таблицы зависит от выбранного подхода к шардированию.

Структура таблицы, которую нужно подставить вместо обозначения `<структура_таблицы>`, приведена [в документации ClickHouse®](https://clickhouse.com/docs/ru/getting-started/example-datasets/star-schema#create-tables).

После включения шардирования любым из способов, вы сможете отправлять `SELECT`- и `INSERT`-запросы к созданной распределенной таблице, и они будут обрабатываться согласно заданной конфигурации.

В примерах в качестве ключа шардирования используется случайное число `rand()`.

### Классическое шардирование {#shard-example}

В этом примере распределенная таблица, которая будет создана на основе `hits_v1`, использует все шарды `shard1`, `shard2`, `shard3` кластера `chcluster`.

Перед работой с распределенной таблицей:

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree), которая будет размещена на всех хостах кластера:

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
1. Создайте таблицу на движке [Distributed](https://clickhouse.com/docs/ru/engines/table-engines/special/distributed):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   Здесь допустимо вместо явного указания структуры таблицы использовать выражение `AS tutorial.hits_v1`, т. к. таблицы `hits_v1_distributed` и `hits_v1` находятся на одних и тех же хостах кластера.

   При создании таблицы на движке [Distributed](https://clickhouse.com/docs/ru/engines/table-engines/special/distributed) укажите идентификатор кластера `chcluster`. Его можно получить со [списком кластеров в каталоге](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   {% note tip %}

   Вместо идентификатора кластера можно использовать макрос `{cluster}` — при выполнении запроса идентификатор кластера, в котором выполняется операция `CREATE TABLE`, будет подставлен автоматически.

   {% endnote %}

### Шардирование с использованием групп шардов {#shard-groups-example}

В этом примере:

- Используется одна группа шардов `sgroup`.
- Распределенная таблица и нижележащая таблица `hits_v1` расположены в одной группе шардов `sgroup` кластера.

Перед работой с распределенной таблицей:

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree), которая использует все хосты группы шардов `sgroup` кластера:

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
1. Создайте таблицу на движке [Distributed](https://clickhouse.com/docs/ru/engines/table-engines/special/distributed):

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

1. [Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на движке [ReplicatedMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication), которая использует все хосты группы шардов `sgroup_data` кластера:

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
1. Создайте таблицу на движке [Distributed](https://clickhouse.com/docs/ru/engines/table-engines/special/distributed):

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

    Чтобы узнать имена хостов, посмотрите [список хостов ClickHouse® в кластере](../../managed-clickhouse/operations/hosts.md#list-hosts).

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

    1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
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