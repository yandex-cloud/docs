[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Работа с заданиями Yandex Data Processing > Работа с заданиями Hive

# Работа с заданиями Hive

[Apache Hive](https://hive.apache.org/) — это система управления большими распределенными наборами данных на основе платформы Hadoop, использующая язык запросов SQL.

В этой статье на простом примере показывается, как в Yandex Data Processing использовать Hive для анализа данных. При помощи Hive в приведенном примере анализируется численность населения крупнейших городов России.

Чтобы выполнить задание Hive:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте задание Hive](#create-job).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../data-proc/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Бакеты Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).


## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. В Object Storage [создайте бакеты](../../storage/operations/buckets/create.md) и [настройте доступ](../../storage/operations/buckets/edit-acl.md) к ним:
   
   1. Создайте бакет для исходных данных и предоставьте сервисному аккаунту кластера разрешение `READ` для этого бакета.
   1. Создайте бакет для результатов обработки и предоставьте сервисному аккаунту кластера разрешение `READ и WRITE` для этого бакета.

1. [Создайте кластер Yandex Data Processing](../../data-proc/operations/cluster-create.md) со следующими настройками:

    * **Окружение** — `PRODUCTION`.
    * **Сервисы**:
        * `HDFS`
        * `SPARK`
        * `HIVE`
    * **Сервисный аккаунт**: выберите созданный ранее сервисный аккаунт.
    * **Имя бакета**: выберите бакет для результатов обработки.

## Создайте задание Hive {#create-job}

1. В бакете для исходных данных [создайте папку](../../storage/operations/objects/upload.md) `cities` и загрузите в нее файл для обработки `cities.csv`:

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

1. [Создайте задание Hive](../../data-proc/operations/jobs-hive.md#create) с параметрами:

    * **Драйвер**: `Файл`
    * **Файл с запросами**: `s3a://<имя_бакета_для_исходных_данных>/cities.sql`

1. Подождите, пока [статус задания](../../data-proc/operations/jobs-spark.md#get-info) изменится на `Done`.

1. [Откройте логи задания](../../data-proc/operations/jobs-hive.md#get-logs) и просмотрите результаты обработки:

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

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [Yandex Cloud Logging](../../logging/index.md). Подробнее в разделе [Работа с логами](../../data-proc/operations/logging.md).

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер](../../data-proc/operations/cluster-delete.md).
1. [Удалите бакеты](../../storage/operations/buckets/delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).