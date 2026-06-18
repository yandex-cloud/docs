# Использование Object Storage в сервисе Yandex Managed Service for Apache Spark™

# Использование Yandex Object Storage в сервисе Yandex Managed Service for Apache Spark™


В бакетах Yandex Object Storage можно хранить как файлы, необходимые для выполнения заданий в кластере Yandex Managed Service for Apache Spark™, так и результаты выполнения заданий.

Кластеры Yandex Managed Service for Apache Spark™ уже сконфигурированы для работы с S3-хранилищами. Чтобы использовать бакет Object Storage в PySpark-задании:
* Предоставьте сервисному аккаунту кластера Yandex Managed Service for Apache Spark™ разрешение на доступ к бакету Object Storage.
* Укажите путь к каталогу в бакете Object Storage в аргументах задания.

В этом руководстве показан пример работы с таблицей в бакете Object Storage из PySpark-задания с использованием встроенного локального каталога Hive.

Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

Локальный каталог Hive позволяет обращаться к таблицам по имени без указания пути и использовать базовые возможности Hive, не подключая кластер Apache Hive™ Metastore. Хранящиеся в локальном каталоге метаданные остаются недоступными другим кластерам. Пример использования глобального каталога приведен в руководстве [Работа с Yandex Object Storage из PySpark-задания с использованием кластера Apache Hive™ Metastore](../../managed-spark/tutorials/metastore-and-spark.md).

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

* Бакеты Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../pricing.md)).
* Сервис Yandex Cloud Logging: объем записываемых данных и время их хранения ([тарифы Cloud Logging](../../logging/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `spark-agent` для кластера Yandex Managed Service for Apache Spark™ с ролью [managed-spark.integrationProvider](../../iam/roles-reference.md#managed-spark-integrationProvider) — чтобы кластер Yandex Managed Service for Apache Spark™ мог взаимодействовать с другими ресурсами.

    1. [Создайте бакеты](../operations/buckets/create.md):

        * `<бакет_для_исходного_кода_PySpark_задания>`.
        * `<бакет_для_выходных_данных_PySpark_задания>`.

    1. [Предоставьте разрешения](../operations/buckets/edit-acl.md) для сервисного аккаунта `spark-agent` на созданные бакеты:

        * `<бакет_для_исходного_кода_PySpark_задания>` — разрешение `READ`.
        * `<бакет_для_выходных_данных_PySpark_задания>` — разрешение `READ и WRITE`.

    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `spark-network`.

        Вместе с ней автоматически будут созданы три подсети в разных зонах доступности.

    1. [Создайте кластер Yandex Managed Service for Apache Spark™](../../managed-spark/operations/cluster-create.md) с параметрами:

        * **Сервисный аккаунт** — `spark-agent`.
        * **Сеть** — `spark-network`.
        * **Подсеть** — `spark-network-ru-central1-a`.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-a-job}

Для PySpark-задания используется Python-скрипт, который создает таблицу `table_1` в БД `database_1`. В аргументах PySpark-задания указан путь к каталогу, в котором будет создана БД. Для подключения встроенного каталога Hive в скрипте указывается параметр конфигурации Spark-сессии `spark.sql.catalogImplementation=hive`. Скрипт будет храниться в бакете Object Storage.

Подготовьте файл скрипта:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Создайте локально файл с именем `job_save_table.py` и скопируйте в него скрипт:

       {% cut "job_save_table.py" %}

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
               .appName('job_save_table')
               .config('spark.executor.instances', 1)
               .config('spark.sql.warehouse.dir', sys.argv[1])
               .config('spark.sql.catalogImplementation', 'hive')
               .getOrCreate()
           )
           database, table = 'database_1', 'table_1'
           prepare_table(spark, database, table)
           write_data(spark, database, table)
       
       
       if __name__ == '__main__':
           if len(sys.argv) != 2:
               print("Usage: job-save-table s3a://<bucket>/<folder>", file=sys.stderr)
               sys.exit(-1)
           main()
       
       ```

       {% endcut %}

    1. Создайте в бакете `<бакет_для_исходного_кода_PySpark_задания>` папку `scripts` и [загрузите](../operations/objects/upload.md#simple) в нее файл `job_save_table.py`.
    1. [Создайте задание](../../managed-spark/operations/jobs-pyspark.md) с параметрами:
        * **Тип задания** — **PySpark**.
        * **Main python файл** – `s3a://<бакет_для_исходного_кода_PySpark_задания>/scripts/job_save_table.py`.
        * **Аргументы** — `s3a://<бакет_для_выходных_данных_PySpark_задания>/warehouse`.

{% endlist %}

## Проверьте результат {#check-out}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
    1. Убедитесь, что в бакете `<бакет_для_выходных_данных_PySpark_задания>` в папке `warehouse` появилась БД `database_1`. Теперь данные из созданной БД хранятся в бакете Object Storage в формате JSON.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Бакеты Object Storage](../operations/buckets/delete.md).
    1. [Кластер Yandex Managed Service for Apache Spark™](../../managed-spark/operations/cluster-delete.md).

{% endlist %}