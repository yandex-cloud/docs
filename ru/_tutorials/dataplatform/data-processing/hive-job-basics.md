# Работа с заданиями Hive

[Apache Hive](https://hive.apache.org/) — это система управления большими распределенными наборами данных на основе платформы Hadoop, использующая язык запросов SQL.

В этой статье на простом примере показывается, как в {{ dataproc-name }} использовать Hive для анализа данных. При помощи Hive в приведенном примере анализируется численность населения крупнейших городов России.

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. {% include [tutorials-basic-before-buckets](../../../_includes/data-processing/tutorials/basic-before-buckets.md) %}

1. [Создайте кластер {{ dataproc-name }}](../../../data-proc/operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** — `PRODUCTION`.
    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`
        * `SPARK`
        * `HIVE`
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: выберите созданный ранее сервисный аккаунт.
    * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: выберите бакет для результатов обработки.

## Создайте задание Hive {#create-job}

1. В бакете для исходных данных [создайте папку](../../../storage/operations/objects/upload.md) `cities` и загрузите в нее файл для обработки `cities.csv`:

    {% cut "cities.csv" %}

    ```text
    Moscow,12655000
    Saint Petersburg,5384000
    Novosibirsk,1620000
    Yekaterinburg,1495000
    Kazan,1257000
    Nizhny Novgorod,1244000
    Chelyabinsk,1188000
    Samara,1145000
    Omsk,1140000
    Rostov-on-Don,1138000
    Ufa,1126000
    Krasnoyarsk,1093000
    Voronezh,1051000
    Perm,1049000
    Volgograd,1005000
    ```

    {% endcut %}

    В файле показана численность населения крупнейших городов России, с населением более одного миллиона человек, по оценке на 2021 год (округленно).

1. Создайте и загрузите в бакет для исходных данных файл c SQL-запросами `cities.sql`:

    {% cut "cities.sql" %}

    ```sql
    /* Создать внешнюю таблицу с данными, которые содержатся в CSV-файлах: */
    CREATE EXTERNAL TABLE IF NOT EXISTS cities
    (city_name string, population decimal)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION 's3a://<бакет_для_исходных_данных>/cities';

    /* Показать количество городов и суммарную численность населения в них: */
    SELECT COUNT(*) num_cities, SUM(population) sum_populataion FROM cities;

    /* Показать минимальную и максимальную численность населения: */
    SELECT MIN(population) min_population, MAX(population) max_population FROM cities;
    ```

    {% endcut %}

1. [Создайте задание Hive](../../../data-proc/operations/jobs-hive#create) с параметрами:

    * **{{ ui-key.yacloud.dataproc.jobs.field_driver }}**: `Файл`
    * **{{ ui-key.yacloud.dataproc.jobs.field_query-file-uri }}**: `s3a://<имя_бакета_для_исходных_данных>/cities.sql`

1. Подождите, пока [статус задания](../../../data-proc/operations/jobs-spark.md#get-info) изменится на `Done`.

1. [Откройте логи задания](../../../data-proc/operations/jobs-hive#get-logs) и просмотрите результаты обработки:

    {% cut "Логи" %}

    ```text
    ...
    OK
    15  33590000
    Time taken: 21.104 seconds, Fetched: 1 row(s)
    ...
    OK
    1005000 12655000
    Time taken: 3.393 seconds, Fetched: 1 row(s)
    ```

    {% endcut %}

{% include [get-logs-info](../../../_includes/data-processing/note-info-get-logs.md) %}

## Удалите созданные ресурсы {#clear-out}

{% include [tutorials-basic-clear-out.md](../../../_includes/data-processing/tutorials/basic-clear-out.md) %}
