# Использование гибридного хранилища в Yandex Managed Service for ClickHouse®

# Использование гибридного хранилища в Managed Service for ClickHouse®


Гибридное хранилище позволяет хранить часто используемые данные на сетевых дисках кластера Managed Service for ClickHouse®, а редко используемые данные — в Yandex Object Storage. Гибридное хранилище самостоятельно создаст бакет и подключит его к ClickHouse®. Автоматическое перемещение данных между этими уровнями хранения поддерживается только для таблиц семейства [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree/). Подробнее см. в разделе [Хранилище в Managed Service for ClickHouse®](../../managed-clickhouse/concepts/storage.md).

Чтобы воспользоваться гибридным хранилищем:

1. [Создайте таблицу](#create-table).
1. [Наполните таблицу данными](#fill-table-with-data).
1. [Проверьте размещение данных таблицы в кластере](#check-table-tiering).
1. [Выполните тестовый запрос](#submit-test-query).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for ClickHouse®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства (см. [тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер](../../managed-clickhouse/operations/cluster-create.md) Managed Service for ClickHouse®:

        
        * **Тип диска** — стандартные (`network-hdd`), быстрые (`network-ssd`) или нереплицируемые (`network-ssd-nonreplicated`) сетевые диски.


        * **Размер** — не менее 15 ГБ.
        * **Управление пользователями через SQL** — выключено.
        * **Имя БД** — `tutorial`.
        * **Гибридное хранилище** — включено.

    1. [Настройте права доступа](../../managed-clickhouse/operations/cluster-users.md#update-settings) так, чтобы вы могли выполнять в этой базе запросы на чтение и запись.

- С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [clickhouse-hybrid-storage.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-hybrid-storage/blob/main/clickhouse-hybrid-storage.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) по умолчанию и правила, необходимые для подключения к кластеру из интернета;
        * кластер Managed Service for ClickHouse® с включенным гибридным хранилищем.

    1. Укажите в файле `clickhouse-hybrid-storage.tf` имя пользователя и пароль, которые будут использоваться для доступа к кластеру Managed Service for ClickHouse®.

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

### Настройте инструменты командной строки {#set-instruments}

1. Установите инструменты `curl` и `unxz`:

    ```bash
    apt-get update && apt-get install curl xz-utils
    ```

1. [Настройте clickhouse-client](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) и подключитесь с его помощью к базе данных.

### Познакомьтесь с тестовым набором данных (необязательный шаг) {#explore-dataset}

Для демонстрации работы гибридного хранилища используются анонимизированные данные о хитах (`hits_v1`) Яндекс Метрики. Этот [датасет](https://clickhouse.com/docs/ru/getting-started/example-datasets/metrica/) содержит данные о почти девяти миллионах хитов за неделю с 17 марта 2014 года по 23 марта 2014 года.

Таблица `tutorial.hits_v1` будет [настроена при создании](#create-table) таким образом, чтобы все <q>свежие</q> данные в таблице с 21 марта 2014 года и позже попали в хранилище на сетевых дисках, а более старые данные (с 17 марта по 20 марта 2014 года) — в объектное хранилище.

## Создайте таблицу {#create-table}

Создайте таблицу `tutorial.hits_v1`, которая использует гибридное хранилище. Для этого выполните SQL-запрос, подставив вместо `<схема>` схему таблицы из [документации ClickHouse®](https://clickhouse.com/docs/ru/getting-started/tutorial/#create-tables):

```sql
CREATE TABLE tutorial.hits_v1
(
   <схема>
)
ENGINE = MergeTree()
PARTITION BY EventDate
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID)
TTL EventDate + toIntervalDay(dateDiff('day', toDate('2014-03-20'), now())) TO DISK 'object_storage'
SETTINGS index_granularity = 8192
```

{% cut "Запрос с заполненной схемой" %}

```sql
CREATE TABLE tutorial.hits_v1
(
    `WatchID` UInt64,
    `JavaEnable` UInt8,
    `Title` String,
    `GoodEvent` Int16,
    `EventTime` DateTime,
    `EventDate` Date,
    `CounterID` UInt32,
    `ClientIP` UInt32,
    `ClientIP6` FixedString(16),
    `RegionID` UInt32,
    `UserID` UInt64,
    `CounterClass` Int8,
    `OS` UInt8,
    `UserAgent` UInt8,
    `URL` String,
    `Referer` String,
    `URLDomain` String,
    `RefererDomain` String,
    `Refresh` UInt8,
    `IsRobot` UInt8,
    `RefererCategories` Array(UInt16),
    `URLCategories` Array(UInt16),
    `URLRegions` Array(UInt32),
    `RefererRegions` Array(UInt32),
    `ResolutionWidth` UInt16,
    `ResolutionHeight` UInt16,
    `ResolutionDepth` UInt8,
    `FlashMajor` UInt8,
    `FlashMinor` UInt8,
    `FlashMinor2` String,
    `NetMajor` UInt8,
    `NetMinor` UInt8,
    `UserAgentMajor` UInt16,
    `UserAgentMinor` FixedString(2),
    `CookieEnable` UInt8,
    `JavascriptEnable` UInt8,
    `IsMobile` UInt8,
    `MobilePhone` UInt8,
    `MobilePhoneModel` String,
    `Params` String,
    `IPNetworkID` UInt32,
    `TraficSourceID` Int8,
    `SearchEngineID` UInt16,
    `SearchPhrase` String,
    `AdvEngineID` UInt8,
    `IsArtifical` UInt8,
    `WindowClientWidth` UInt16,
    `WindowClientHeight` UInt16,
    `ClientTimeZone` Int16,
    `ClientEventTime` DateTime,
    `SilverlightVersion1` UInt8,
    `SilverlightVersion2` UInt8,
    `SilverlightVersion3` UInt32,
    `SilverlightVersion4` UInt16,
    `PageCharset` String,
    `CodeVersion` UInt32,
    `IsLink` UInt8,
    `IsDownload` UInt8,
    `IsNotBounce` UInt8,
    `FUniqID` UInt64,
    `HID` UInt32,
    `IsOldCounter` UInt8,
    `IsEvent` UInt8,
    `IsParameter` UInt8,
    `DontCountHits` UInt8,
    `WithHash` UInt8,
    `HitColor` FixedString(1),
    `UTCEventTime` DateTime,
    `Age` UInt8,
    `Sex` UInt8,
    `Income` UInt8,
    `Interests` UInt16,
    `Robotness` UInt8,
    `GeneralInterests` Array(UInt16),
    `RemoteIP` UInt32,
    `RemoteIP6` FixedString(16),
    `WindowName` Int32,
    `OpenerName` Int32,
    `HistoryLength` Int16,
    `BrowserLanguage` FixedString(2),
    `BrowserCountry` FixedString(2),
    `SocialNetwork` String,
    `SocialAction` String,
    `HTTPError` UInt16,
    `SendTiming` Int32,
    `DNSTiming` Int32,
    `ConnectTiming` Int32,
    `ResponseStartTiming` Int32,
    `ResponseEndTiming` Int32,
    `FetchTiming` Int32,
    `RedirectTiming` Int32,
    `DOMInteractiveTiming` Int32,
    `DOMContentLoadedTiming` Int32,
    `DOMCompleteTiming` Int32,
    `LoadEventStartTiming` Int32,
    `LoadEventEndTiming` Int32,
    `NSToDOMContentLoadedTiming` Int32,
    `FirstPaintTiming` Int32,
    `RedirectCount` Int8,
    `SocialSourceNetworkID` UInt8,
    `SocialSourcePage` String,
    `ParamPrice` Int64,
    `ParamOrderID` String,
    `ParamCurrency` FixedString(3),
    `ParamCurrencyID` UInt16,
    `GoalsReached` Array(UInt32),
    `OpenstatServiceName` String,
    `OpenstatCampaignID` String,
    `OpenstatAdID` String,
    `OpenstatSourceID` String,
    `UTMSource` String,
    `UTMMedium` String,
    `UTMCampaign` String,
    `UTMContent` String,
    `UTMTerm` String,
    `FromTag` String,
    `HasGCLID` UInt8,
    `RefererHash` UInt64,
    `URLHash` UInt64,
    `CLID` UInt32,
    `YCLID` UInt64,
    `ShareService` String,
    `ShareURL` String,
    `ShareTitle` String,
    `ParsedParams` Nested(
        Key1 String,
        Key2 String,
        Key3 String,
        Key4 String,
        Key5 String,
        ValueDouble Float64),
    `IslandID` FixedString(16),
    `RequestNum` UInt32,
    `RequestTry` UInt8
)
ENGINE = MergeTree()
PARTITION BY EventDate
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID)
TTL EventDate + toIntervalDay(dateDiff('day', toDate('2014-03-20'), now())) TO DISK 'object_storage'
SETTINGS index_granularity = 8192
```

{% endcut %}

{% note info %}

Эта таблица использует [политику хранения](../../managed-clickhouse/concepts/storage.md#storage-policies) `default` (по умолчанию).

{% endnote %}

{#ttl}

Выражение `TTL ...` задает политику работы с устаревающими данными:
1. TTL задает время жизни строки таблицы (в данном случае — это количество дней от текущей даты до 20 марта 2014 года). 
1. Для данных в таблице проверяется значение `EventDate`:
   * если количество дней от текущей даты до `EventDate` меньше значения TTL (то есть время жизни еще не истекло), то эти данные остаются в хранилище на сетевых дисках;
   * если количество дней от текущей даты до `EventDate` больше или равно значению TTL (то есть время жизни уже истекло), то эти данные помещаются в объектное хранилище согласно политике `TO DISK 'object_storage'`;

Указывать TTL для использования гибридного хранилища необязательно, однако это позволяет явно контролировать, какие данные будут находиться в Object Storage. Если не указывать TTL, то данные будут помещаться в объектное хранилище, только когда в хранилище на сетевых дисках закончится место. Подробнее см. в разделе [Хранилище в Managed Service for ClickHouse®](../../managed-clickhouse/concepts/storage.md).

{% note info %}

Сложность выражения для TTL в примере выше обусловлена выбранным тестовым набором данных: необходимо искусственно разделить давно собранные фиксированные данные на части для размещения на разных уровнях хранения. Для большинства таблиц, в которые постоянно поступают новые данные, будет достаточно более простого выражения для TTL, например, `EventDate + INTERVAL 5 DAY`: данные старше пяти дней будут перемещены в объектное хранилище.

{% endnote %}

Данные между хранилищем на сетевых дисках и объектным хранилищем перемещаются не построчно, а [кусками](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes). Старайтесь выбирать выражение TTL и [ключ партиционирования](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/custom-partitioning-key/) так, чтобы для всех строк куска данных TTL совпадал. Если этого не сделать, то могут возникнуть проблемы с перемещением данных в объектное хранилище по истечении TTL, если один кусок будет содержать данные, предназначенные для разных уровней хранения. В самом простом случае выражение для TTL должно использовать те же столбцы, что и в ключе партиционирования, как в примере выше, где используется столбец `EventDate`.

Подробнее о настройке TTL см. [в документации ClickHouse®](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-ttl).

## Наполните таблицу данными {#fill-table-with-data}

1. Отключитесь от базы данных.
1. Загрузите тестовый датасет:

   
   ```bash
   curl https://storage.yandexcloud.net/doc-files/managed-clickhouse/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```


   Объем загруженного датасета — около 10 ГБ.

1. Вставьте данные из этого датасета в ClickHouse® с помощью `clickhouse-client`:

   ```bash
   clickhouse-client \
       --host <FQDN_хоста_ClickHouse®> \
       --secure \
       --user <имя_пользователя> \
       --database tutorial \
       --port 9440 \
       --ask-password \
       --query "INSERT INTO tutorial.hits_v1 FORMAT TSV" \
       --max_insert_block_size=100000 < hits_v1.tsv
   ```

   FQDN хоста можно получить [со списком хостов в кластере](../../managed-clickhouse/operations/hosts.md#list-hosts).

1. Дождитесь завершения операции, вставка данных может занять некоторое время.

Подробнее см. [в документации ClickHouse®](https://clickhouse.com/docs/ru/getting-started/tutorial/#import-data).

## Проверьте размещение данных в кластере {#check-table-tiering}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client).
1. Посмотрите, где размещены строки таблицы:

   ```sql
   SELECT
       table,
       partition,
       name,
       rows,
       disk_name
   FROM system.parts
   WHERE active AND (table = 'hits_v1') AND (database = 'tutorial')
   ```

   Партиции таблицы, для которых значение `EventDate` выходит за [заданный TTL](#ttl) должны находиться на диске с именем `object_storage`, то есть в объектном хранилище, все прочие партиции — на диске `default`:

   ```text
   ┌─table───┬─partition──┬─name───────────────┬───rows─┬─disk_name──────┐
   │ hits_v1 │ 2014-03-17 │ 20140317_6_80_2    │ 571657 │ object_storage │
   │ hits_v1 │ 2014-03-17 │ 20140317_86_125_1  │ 287545 │ object_storage │
   │ ...                                                                 │
   │ hits_v1 │ 2014-03-20 │ 20140320_109_145_1 │ 250484 │ object_storage │
   │ hits_v1 │ 2014-03-20 │ 20140320_149_200_1 │ 420081 │ object_storage │
   │ hits_v1 │ 2014-03-21 │ 20140321_3_57_1    │ 612616 │ default        │
   │ hits_v1 │ 2014-03-21 │ 20140321_65_65_0   │  53382 │ default        │
   │ ...                                                                 │
   │ hits_v1 │ 2014-03-23 │ 20140323_191_191_0 │  11145 │ default        │
   │ hits_v1 │ 2014-03-23 │ 20140323_197_197_0 │  98910 │ default        │
   └─────────┴────────────┴────────────────────┴────────┴────────────────┘
   ```

1. Получите число строк на каждом из уровней хранения:

   ```sql
   SELECT
    sum(rows),
    disk_name
   FROM system.parts
   WHERE active AND (database = 'tutorial') AND (table = 'hits_v1')
   GROUP BY disk_name
   ```
   
   В результате будет отражено распределение строк таблицы по уровням хранения:
   
   ```text
   ┌─sum(rows)─┬─disk_name──────┐
   │   2711246 │ default        │
   │   6162652 │ object_storage │
   └───────────┴────────────────┘
   ```
   
Как видно из результатов выполнения SQL-команд, данные в таблице были успешно распределены в гибридном хранилище между разными уровнями хранения.

## Выполните тестовый запрос {#submit-test-query}

Выполните тестовый запрос к таблице `tutorial.hits_v1`, который затрагивает данные сразу на нескольких уровнях хранения:

```sql
SELECT
    URLDomain AS Domain,
    AVG(SendTiming) AS AvgSendTiming
FROM tutorial.hits_v1
WHERE (EventDate >= '2014-03-19') AND (EventDate <= '2014-03-22')
GROUP BY Domain
ORDER BY AvgSendTiming DESC
LIMIT 10
```

Результат:

```text
┌─Domain──────────────────────────────┬──────AvgSendTiming─┐
│ realty.ru.msn.com.travel            │ 101166.85714285714 │
│ podbor.ru.msn.com.uazbukatusprosima │  76429.16666666667 │
│ club.metalia-woman                  │ 64872.333333333336 │
│ avito.rusfootki                     │              51099 │
│ papas.drimmirkvart                  │ 50325.642857142855 │
│ apps.oyunuoyna.com.uazbukadelight   │ 32761.666666666668 │
│ voyeurhit                           │          31501.625 │
│ yandex.ru.com.travesti.net          │            31427.5 │
│ sozcu.com.ua.alm.slands             │              29439 │
│ hasters.ru                          │ 18365.666666666668 │
└─────────────────────────────────────┴────────────────────┘
```

Как видно из результата выполнения SQL-запроса, с точки зрения пользователя таблица выступает единой сущностью: ClickHouse® успешно выполняет запросы к такой таблице вне зависимости от фактического места расположения данных в ней.

## Отслеживайте объем, занимаемый данными в Object Storage (необязательный шаг) {#metrics}

Чтобы узнать, какой объем занимают куски таблиц [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree/) в Object Storage, воспользуйтесь метрикой `ch_s3_disk_parts_size` в сервисе Yandex Monitoring:

1. Откройте [консоль управления](https://console.yandex.cloud).
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Monitoring**.
1. Перейдите в раздел **Обзор метрик**.
1. Выполните запрос:

    ```text
    "ch_s3_disk_parts_size"{service="managed-clickhouse", resource_type="cluster", node="by_host", resource_id="<идентификатор_кластера>", subcluster_name="clickhouse_subcluster"}
    ```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).

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