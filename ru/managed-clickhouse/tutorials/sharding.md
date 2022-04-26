# Шардирование таблиц {{ CH }}

{{ mch-name }} автоматически создает кластер с одним шардом. Этот шард включает все хосты кластера. 

Чтобы начать использовать шардирование, [добавьте](../operations/shards.md#add-shard) нужное количество шардов и создайте таблицу на базе движка [Distributed](https://{{ ch-domain }}/docs/ru/operations/table_engines/distributed/). В статье по ссылке описаны стратегии шардирования и инструкции по созданию таблиц нужного вида, а также ограничения распределенных таблиц.

Каждая шардированная таблица в {{ CH }} состоит из:
- распределенной таблицы на движке Distributed, которая маршрутизирует запросы;
- нижележащих таблиц с данными, расположенных на нескольких шардах кластера.
 
С шардированной таблицей вы можете работать с данными:
- обращаясь к ним через распределенную таблицу, которая будет представлять все шардированные таблицы в виде единой таблицы;
- обращаясь к нижележащим таблицам напрямую: вставлять данные на нужные шарды или читать данные, содержащиеся в таблице на конкретном шарде.     

Подробнее о концепции шардирования читайте в разделе [{#T}](../concepts/sharding.md).

## Примеры шардирования {#example}

Допустим, что [создан кластер](../operations/cluster-create.md) {{ mch-name }} `chcluster` с:
- Пятью шардами: `shard1, ..., shard5`;
- Базой данных `tutorial`. 

Пусть необходимо включить шардирование для [таблицы](https://{{ ch-domain }}/docs/ru/getting-started/example-datasets/metrica/) `hits_v1`. Таблица будет создана отдельно для каждого примера. Структура таблицы, которую нужно подставить вместо обозначения `<структура таблицы>`, приведена [в документации {{ CH }}](https://{{ ch-domain }}/docs/ru/getting-started/tutorial/#create-tables). 

После включения шардирования любым из приведенных ниже способов, вы сможете отправлять `SELECT`- и `INSERT`-запросы к созданной распределенной таблице, и они будут обрабатываться согласно заданной конфигурации.

В примерах в качестве ключа шардирования используется случайное число `rand()`.

### Классическое шардирование { #shard-example }

В этом примере распределенная таблица, которая будет создана на основе `hits_v1`, использует все шарды `shard1, ..., shard5` кластера `chcluster`. 

Перед работой с распределенной таблицей:
1. [Подключитесь](../operations/connect.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на [движке MergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/), которая будет размещена на все хостах кластера:
  
   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER '{cluster}' ( <структура таблицы> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192 
   ``` 
   
Чтобы создать распределенную таблицу `hits_v1_distributed` в кластере:
1. [Подключитесь](../operations/connect.md) к базе `tutorial`.
1. Создайте таблицу на [движке Distributed](https://{{ ch-domain }}/docs/ru/engines/table-engines/special/distributed/):
 
   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   Здесь допустимо вместо явного указания структуры таблицы использовать выражение `AS tutorial.hits_v1`, т.к. таблицы `hits_v1_distributed` и `hits_v1` находятся на одних и тех же хостах кластера.

   При создании распределенной таблицы укажите в качестве первого параметра в `Distributed` идентификатор кластера `chcluster`, либо воспользуйтесь макросом `{cluster}`, который автоматически подставляет идентификатор кластера, в котором выполняется операция `CREATE TABLE`. 

   Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](../operations/cluster-list.md#list-clusters).

### Шардирование с использованием групп шардов { #shard-groups-example }

В этом примере:
- Используется одна группа шардов `sgroup`.
- Распределенная таблица и нижележащая таблица `hits_v1` расположены в одной группе шардов `sgroup` кластера.

Перед работой с распределенной таблицей:
1. [Создайте](../operations/shard-groups.md#create-shard-group) группу шардов `sgroup`, состоящую из шардов `shard1` и `shard2` кластера.
1. [Подключитесь](../operations/connect.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на [движке MergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/), которая использует все хосты группы шардов `sgroup` кластера:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup ( <структура таблицы> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192 
   ```

Чтобы создать распределенную таблицу `tutorial.hits_v1_distributed` в кластере:
1. [Подключитесь](../operations/connect.md) к базе `tutorial`.
1. Создайте таблицу на [движке Distributed](https://{{ ch-domain }}/docs/ru/engines/table-engines/special/distributed/):
 
   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup AS tutorial.hits_v1
   ENGINE = Distributed(sgroup, tutorial, hits_v1, rand())
   ```

   Здесь допустимо вместо явного указания структуры таблицы использовать выражение `AS tutorial.hits_v1`, т.к. таблицы `hits_v1_distributed` и `hits_v1` используют один шард и находятся на одних и тех же хостах.

### Продвинутое шардирование с использованием групп шардов { #shard-groups-advanced-example }

В этом примере:
1. Используются две группы шардов: `sgroup` и `sgroup_data`.
1. Распределенная таблица расположена в группе шардов `sgroup`.
1. Нижележащая таблица `hits_v1` расположена в группе шардов `sgroup_data`.

Перед работой с распределенной таблицей:
1. [Создайте](../operations/shard-groups.md#create-shard-group) группы шардов:
   - `sgroup`: включает шарды `shard1` и `shard2`.
   - `sgroup_data`: включает шарды `shard3`, `shard4` и `shard5`.
1. [Подключитесь](../operations/connect.md) к базе `tutorial`.
1. Создайте таблицу `hits_v1` на [движке ReplicatedMergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/replication/), которая использует все хосты группы шардов `sgroup_data` кластера:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup_data ( <структура таблицы> )
   ENGINE = ReplicatedMergeTree('/tables/{shard}/hits_v1', '{replica}')
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192 
   ```

   Движок `ReplicatedMergeTree` используется для обеспечения отказоустойчивости.

Чтобы создать распределенную таблицу `tutorial.hits_v1_distributed` в кластере:
1. [Подключитесь](../operations/connect.md) к базе `tutorial`.
1. Создайте таблицу на [движке Distributed](https://{{ ch-domain }}/docs/ru/engines/table-engines/special/distributed/):
 
   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup ( <структура таблицы> )
   ENGINE = Distributed(sgroup_data, tutorial, hits_v1, rand())
   ```  

   Здесь необходимо явно указать структуру распределенной таблицы, т.к. таблицы `hits_v1_distributed` и `hits_v1` используют разные шарды и находятся на разных хостах.
   
### Проверка работоспособности { #sharding-test }

Чтобы проверить работоспособность созданной распределенной таблицы `tutorial.hits_v1_distributed`:
1. Загрузите тестовый набор данных `hits_v1`:

   ```bash
   curl https://clickhouse-datasets.s3.yandex.net/hits/tsv/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ``` 
1. Наполните таблицу тестовыми данными:

   ```bash
   clickhouse-client \ 
       --host <любой хост с распределенной таблицей> \
       --secure \
       --port 9440 \ 
       --user <имя пользователя> \
       --password <пароль пользователя> \
       --database tutorial \                      
       --query "INSERT INTO tutorial.hits_v1_distributed FORMAT TSV" --max_insert_block_size=100000 < hits_v1.tsv
   ```
1. Выполните один или несколько тестовых запросов к этой таблице. Например, можно узнать количество строк в таблице:

   ```sql
   SELECT count() FROM tutorial.hits_v1_distributed
   ```
   
   Должен быть получен следующий ответ на запрос: 
   
   `8873898`.
