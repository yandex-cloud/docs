# Работа с Yandex Object Storage из PySpark-задания с использованием кластера Apache Hive™ Metastore

# Интеграция Yandex Managed Service for Apache Spark™ и Apache Hive™ Metastore


В PySpark-задании можно использовать глобальный каталог Hive. Для этого к кластеру Yandex Managed Service for Apache Spark™ нужно подключить кластер Apache Hive™ Metastore.

Apache Hive™ Metastore обеспечивает:
* Централизованное хранение метаданных о базах, таблицах и партициях.
* Упрощенный доступ к данным без указания путей и схем вручную.
* Хранение статистики таблиц и колонок для оптимизации запросов.

В этом руководстве показан пример работы с таблицей в бакете Yandex Object Storage из PySpark-задания с использованием глобального каталога Hive. Метаданные о БД сохраняются в кластере Apache Hive™ Metastore, а затем экспортируются в бакет для выходных данных.

Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте и запустите PySpark-задание](#prepare-job).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

Интеграция кластера Yandex Managed Service for Apache Spark™ с Apache Hive™ Metastore позволяет использовать в задании Spark формат таблиц Apache Iceberg™. Подробнее см. в руководстве [Работа с таблицей формата Apache Iceberg™ из PySpark-задания](spark-simple-rw-job.md).

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

* Бакеты Object Storage: использование хранилища и выполнение операций с данными (см. [тарифы Object Storage](../../storage/pricing.md)).
* Сервис Yandex Cloud Logging: объем записываемых данных и время их хранения (см. [тарифы Cloud Logging](../../logging/pricing.md)).
* Кластер Yandex Managed Service for Apache Spark™: вычислительные ресурсы компонентов кластера (см. [тарифы Yandex Managed Service for Apache Spark™](../pricing.md)).
* Кластер Apache Hive™ Metastore: вычислительные ресурсы компонентов кластера (см. [тарифы Yandex MetaData Hub](../../metadata-hub/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `spark-agent` для кластера Yandex Managed Service for Apache Spark™ с ролью [managed-spark.integrationProvider](../../iam/roles-reference.md#managed-spark-integrationProvider) — чтобы кластер Yandex Managed Service for Apache Spark™ мог взаимодействовать с другими ресурсами.

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `metastore-agent` с ролями [managed-metastore.integrationProvider](../../iam/roles-reference.md#managed-metastore-integrationProvider) и [storage.uploader](../../iam/roles-reference.md#storage-uploader) — чтобы кластер Apache Hive™ Metastore мог [взаимодействовать с другими ресурсами](../../metadata-hub/concepts/metastore-impersonation.md) и экспортировать метаданные в бакет Object Storage.

    1. [Создайте бакеты](../../storage/operations/buckets/create.md):

        * бакет для исходного кода PySpark-задания;
        * бакет для выходных данных.

    1. [Предоставьте разрешения](../../storage/operations/buckets/edit-acl.md) для сервисного аккаунта `spark-agent` на созданные бакеты:

        * бакет для исходного кода PySpark-задания — разрешение `READ`;
        * бакет для выходных данных — разрешение `READ и WRITE`.

    1. [Предоставьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ и WRITE` для сервисного аккаунта `metastore-agent` на бакет для выходных данных.

    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `integration-network`.

        Вместе с ней будут автоматически созданы три подсети в разных зонах доступности.

    1. Для кластера Yandex Managed Service for Apache Spark™ [создайте группу безопасности](../../vpc/operations/security-group-create.md) `spark-sg` в сети `integration-network`. Добавьте в группу следующее правило:

        * Для исходящего трафика, чтобы разрешить подключение кластера Yandex Managed Service for Apache Spark™ к Apache Hive™ Metastore:

            * Диапазон портов — `9083`.
            * Протокол — `Любой` (`Any`).
            * Назначение — `CIDR`.
            * CIDR блоки — `0.0.0.0/0`.

    1. Для кластера Apache Hive™ Metastore [создайте группу безопасности](../../vpc/operations/security-group-create.md) `metastore-sg` в сети `integration-network`. Добавьте в группу следующие правила:

        * Для входящего трафика от клиентов:

            * Диапазон портов — `30000-32767`.
            * Протокол — `Любой` (`Any`).
            * Источник — `CIDR`.
            * CIDR блоки — `0.0.0.0/0`.

        * Для входящего трафика от балансировщика:

            * Диапазон портов — `10256`.
            * Протокол — `Любой` (`Any`).
            * Источник — `Проверки состояния балансировщика`.

    1. [Создайте кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-create.md) с параметрами:

        * **Сервисный аккаунт** — `metastore-agent`.
        * **Версия** — `3.1`.
        * **Сеть** — `integration-network`.
        * **Подсеть** — `integration-network-ru-central1-a`.
        * **Группы безопасности** — `metastore-sg`.


    1. [Создайте кластер Yandex Managed Service for Apache Spark™](../operations/cluster-create.md) с параметрами:

        * **Сервисный аккаунт** — `spark-agent`.
        * **Сеть** — `integration-network`.
        * **Подсеть** — `integration-network-ru-central1-a`.
        * **Группы безопасности** — `spark-sg`.
        * **Metastore-сервер** — созданный ранее кластер Apache Hive™ Metastore.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-job}

Для PySpark-задания будет использован Python-скрипт, который создает БД `database_1` и таблицу `table_1`. Чтобы кластер Yandex Managed Service for Apache Spark™ получил доступ к глобальному каталогу Apache Hive™ Metastore, в скрипте вызывается метод `enableHiveSupport()`. Скрипт будет храниться в бакете Object Storage.

Подготовьте файл скрипта:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Создайте локально файл с именем `job-create-table.py` и скопируйте в него скрипт:

        {% cut "job-create-table.py" %}

        ```python
        import random
        import sys
        from pyspark.sql import SparkSession
        
        
        def prepare_table(spark, database, table):
            create_database_sql = "create database if not exists {database}"
            create_table_sql = """
            create table if not exists {database}.{table} (
                id int,
                value double
            )
            """
            truncate_table_sql = "truncate table {database}.{table}"
        
            spark.sql(create_database_sql.format(database=database))
            spark.sql(create_table_sql.format(database=database, table=table))
            spark.sql(truncate_table_sql.format(database=database, table=table))
        
        
        def write_data(spark, database, table):
            data = [(i, random.random()) for i in range(100_000)]
            # Создание датафрейма
            df = spark.createDataFrame(data, schema=['id', 'value'])
            table_full_name = "{database}.{table}".format(database=database, table=table)
            df.write.mode('overwrite').format('json').saveAsTable(table_full_name)
        
        
        def main():
            # Создание Spark-сессии
            spark = (
                SparkSession
                .builder
                .appName('job-create-table')
                .enableHiveSupport()
                .config('spark.sql.warehouse.dir', sys.argv[1])
                .getOrCreate()
            )
            database, table = 'database_1', 'table_1'
            prepare_table(spark, database, table)
            write_data(spark, database, table)
        
        
        if __name__ == '__main__':
            if len(sys.argv) != 2:
                print("Usage: job-create-table s3a://<bucket>/<folder>", file=sys.stderr)
                sys.exit(-1)
            main()
        ```

        {% endcut %}

    1. В бакете для исходного кода создайте папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `job-create-table.py`.
    1. В бакете для выходных данных создайте папку `warehouse`, в которую будут загружены данные из БД `database_1`.
    1. [Создайте задание](../operations/jobs-pyspark.md) с параметрами:
        * **Тип задания** — **PySpark**.
        * **Main python файл** — `s3a://<бакет_для_исходного_кода>/scripts/job-create-table.py`.
        * **Аргументы** — `s3a://<бакет_для_выходных_данных>/warehouse`.

{% endlist %}

## Проверьте результат {#check-result}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
    1. Убедитесь, что в бакете для выходных данных, в папке `warehouse`, появился файл с данными из БД `database_1`.
    1. Проверьте, что в кластере Apache Hive™ Metastore появились метаданные о БД `database_1`:

        1. [Экспортируйте метаданные](../../metadata-hub/operations/metastore/export-and-import.md#export) из кластера Apache Hive™ Metastore в бакет для выходных данных.
        1. [Скачайте файл](../../storage/operations/objects/download.md) с метаданными и убедитесь, что в нем упоминается БД `database_1`.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-delete.md).
    1. [Кластер Yandex Managed Service for Apache Spark™](../operations/cluster-delete.md).
    1. [Бакеты Object Storage](../../storage/operations/buckets/delete.md). Перед удалением бакетов [удалите](../../storage/operations/objects/delete.md) из них все объекты.

{% endlist %}