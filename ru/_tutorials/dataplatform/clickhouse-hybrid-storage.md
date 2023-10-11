# Использование гибридного хранилища в {{ mch-name }}

Гибридное хранилище позволяет хранить часто используемые данные на сетевых дисках кластера {{ mch-name }}, а редко используемые данные — в {{ objstorage-full-name }}. Автоматическое перемещение данных между этими уровнями хранения поддерживается только для таблиц семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/). Подробнее см. в разделе [{#T}](../../managed-clickhouse/concepts/storage.md).

Чтобы воспользоваться гибридным хранилищем:

1. [Создайте таблицу](#create-table).
1. [Наполните таблицу данными](#fill-table-with-data).
1. [Проверьте размещение данных таблицы в кластере](#check-table-tiering).
1. [Выполните тестовый запрос](#submit-test-query).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

    1. [Создайте кластер](../../managed-clickhouse/operations/cluster-create.md) {{ mch-name }}:

        * **{{ ui-key.yacloud.mdb.forms.base_field_version }}** — {{ mch-ck-version }} или выше.

        
        * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}** — стандартные (`network-hdd`), быстрые (`network-ssd`) или нереплицируемые (`network-ssd-nonreplicated`) сетевые диски.


        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `tutorial`.
        * **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}** — `{{ ui-key.yacloud.mdb.cluster.overview.label_storage-enabled }}`.

    1. [Настройте права доступа](../../managed-clickhouse/operations/cluster-users.md#update-settings) так, чтобы вы могли выполнять в этой базе запросы на чтение и запись.

- С помощью {{ TF }}

    
    1. Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md).


    1. Клонируйте репозиторий с примерами:

        ```bash
        git clone https://github.com/yandex-cloud/examples/
        ```

    1. Скопируйте из директории `examples/tutorials/terraform/` файл `clickhouse-hybrid-storage.tf` в директорию, в которой размещен файл с настройками провайдера.

        В этом файле описаны:

        * сеть;
        * подсеть;
                * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру из интернета;
        * кластер {{ mch-name }} с включенным гибридным хранилищем.

    1. Укажите в файле `clickhouse-hybrid-storage.tf` имя пользователя и пароль, которые будут использоваться для доступа к кластеру {{ mch-name }}.

    1. В терминале перейдите в директорию с планом инфраструктуры.

    1. Для проверки правильности файлов конфигурации выполните команду:

       ```bash
       terraform validate
       ```

       Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте инфраструктуру, необходимую для выполнения инструкций из этого руководства:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Настройте clickhouse-client {#deploy-clickhouse-client}

[Настройте clickhouse-client](../../managed-clickhouse/operations/connect.md), чтобы иметь возможность подключаться с его помощью к базе данных.

### Познакомьтесь с тестовым набором данных (необязательный шаг) {#explore-dataset}

Для демонстрации работы гибридного хранилища используются анонимизированные данные о хитах (`hits_v1`) Яндекс Метрики. Этот [датасет]({{ ch.docs }}/getting-started/example-datasets/metrica/) содержит данные о почти девяти миллионах хитов за неделю с 17 марта 2014 года по 23 марта 2014 года.

Таблица `tutorial.hits_v1` будет [настроена при создании](#create-table) таким образом, чтобы все <q>свежие</q> данные в таблице с 21 марта 2014 года и позже попали в хранилище на сетевых дисках, а более старые данные (с 17 марта по 20 марта 2014 года) — в объектное хранилище.

## Создайте таблицу {#create-table}

Создайте таблицу `tutorial.hits_v1`, которая использует гибридное хранилище. Для этого выполните SQL-запрос, подставив вместо `<схема>` схему таблицы из [документации {{ CH }}]({{ ch.docs }}/getting-started/tutorial/#create-tables):

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

{% include [mch-hybrid-storage-tutorial-sample-query-full](../../_includes/mdb/mch-hs-tutorial-sample-query-full.md) %}

{% note info %}

Эта таблица использует [политику хранения](../../managed-clickhouse/concepts/storage.md#storage-policies) `default` (по умолчанию).

{% endnote %}

{#ttl}

Выражение `TTL ...` задает политику работы с устаревающими данными:
1. TTL задает время жизни строки таблицы (в данном случае — это количество дней от текущей даты до 20 марта 2014 года). 
1. Для данных в таблице проверяется значение `EventDate`:
   * если количество дней от текущей даты до `EventDate` меньше значения TTL (то есть время жизни еще не истекло), то эти данные остаются в хранилище на сетевых дисках;
   * если количество дней от текущей даты до `EventDate` больше или равно значению TTL (то есть время жизни уже истекло), то эти данные помещаются в объектное хранилище согласно политике `TO DISK 'object_storage'`;

Указывать TTL для использования гибридного хранилища необязательно, однако это позволяет явно контролировать, какие данные будут находиться в {{ objstorage-name }}. Если не указывать TTL, то данные будут помещаться в объектное хранилище, только когда в хранилище на сетевых дисках закончится место. Подробнее см. в разделе [{#T}](../../managed-clickhouse/concepts/storage.md).

{% note info %}

Сложность выражения для TTL в примере выше обусловлена выбранным тестовым набором данных: необходимо искусственно разделить давно собранные фиксированные данные на части для размещения на разных уровнях хранения. Для большинства таблиц, в которые постоянно поступают новые данные, будет достаточно более простого выражения для TTL, например, `EventDate + INTERVAL 5 DAY`: данные старше пяти дней будут перемещены в объектное хранилище.

{% endnote %}

Данные между хранилищем на сетевых дисках и объектным хранилищем перемещаются не построчно, а [кусками]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes). Старайтесь выбирать выражение TTL и [ключ партиционирования]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) так, чтобы для всех строк куска данных TTL совпадал. Если этого не сделать, то могут возникнуть проблемы с перемещением данных в объектное хранилище при истечении TTL, если один кусок будет содержать данные, предназначенные для разных уровней хранения. В самом простом случае выражение для TTL должно использовать те же столбцы, что и в ключе партиционирования, как в примере выше, где используется столбец `EventDate`.

Подробнее о настройке TTL см. [в документации {{ CH }}]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-ttl).

## Наполните таблицу данными {#fill-table-with-data}

1. Загрузите тестовый датасет:

   
   ```bash
   curl https://{{ s3-storage-host }}/doc-files/managed-clickhouse/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```


1. Вставьте данные из этого датасета в {{ CH }} с помощью `clickhouse-client`:

   ```bash
   clickhouse-client \
       --host <FQDN хоста {{ CH }}> \
       --secure \
       --user <имя пользователя> \
       --database tutorial \
       --port 9440 \
       --ask-password \
       --query "INSERT INTO tutorial.hits_v1 FORMAT TSV" \
       --max_insert_block_size=100000 < hits_v1.tsv
   ```

   FQDN хоста можно получить [со списком хостов в кластере](../../managed-clickhouse/operations/hosts.md#list-hosts).

1. Дождитесь завершения операции, вставка данных может занять некоторое время.

Подробнее см. [в документации {{ CH }}]({{ ch.docs }}/getting-started/tutorial/#import-data).

## Проверьте размещение данных в кластере {#check-table-tiering}

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

Как видно из результата выполнения SQL-запроса, с точки зрения пользователя таблица выступает единой сущностью: {{ CH }} успешно выполняет запросы к такой таблице вне зависимости от фактического места расположения данных в ней.

## Отслеживайте объем, занимаемый данными в {{ objstorage-name }} (необязательный шаг) {#metrics}

Чтобы узнать, какой объем занимают куски таблиц [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) в {{ objstorage-name }}, воспользуйтесь метрикой `ch_s3_disk_parts_size` в сервисе {{ monitoring-full-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Перейдите в раздел **Обзор метрик**.
1. Выполните запрос:

    ```text
    "ch_s3_disk_parts_size"{service="managed-clickhouse", resource_type="cluster", node="by_host", resource_id="<ID_кластера>", subcluster_name="clickhouse_subcluster"}
    ```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs %}

- Вручную

    [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).

- С помощью {{ TF }}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите файл `clickhouse-hybrid-storage.tf`.
    1. Выполните команду:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в файле `clickhouse-hybrid-storage.tf`, будут удалены.

{% endlist %}
