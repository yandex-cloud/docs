[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Работа с таблицей в Object Storage из PySpark-задания

# Работа с таблицей в Object Storage из PySpark-задания с использованием Apache Hive™ Metastore и Apache Iceberg™

# Работа с таблицей формата Apache Iceberg™ из PySpark-задания


В сервис Yandex Managed Service for Apache Spark™ интегрирована библиотека Apache Iceberg™. Чтобы использовать в PySpark-задании возможности Apache Iceberg™, подключите к кластеру Yandex Managed Service for Apache Spark™ сервер Apache Hive™ Metastore.

Формат Apache Iceberg™ обеспечивает:
* Версионирование данных и хранение снимков состояний.
* ACID-транзакции, которые поддерживают операции `UPDATE`, `DELETE`, `MERGE`, а также эволюцию таблиц и способа партиционирования.
* Масштабируемость с сохранением высокой производительности операций.

В этом руководстве показан пример использования формата таблиц Apache Iceberg™ для создания и чтения снимков метаданных. Таблица Apache Iceberg™ создается в S3-хранилище Object Storage. Кластер Yandex Managed Service for Apache Spark™, в котором запускается PySpark-задание, использует глобальный каталог Apache Hive™ Metastore. Подробнее о подключении глобального каталога смотрите в руководстве [Работа с Yandex Object Storage из PySpark-задания с использованием кластера Apache Hive™ Metastore](../../managed-spark/tutorials/metastore-and-spark.md).

Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте и запустите PySpark-задание](#prepare-job).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Бакеты Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Сервис Yandex Cloud Logging: объем записываемых данных и время их хранения ([тарифы Cloud Logging](../../logging/pricing.md)).
* Кластер Yandex Managed Service for Apache Spark™: вычислительные ресурсы компонентов кластера ([тарифы Yandex Managed Service for Apache Spark™](../../managed-spark/pricing.md)).
* Кластер Apache Hive™ Metastore: вычислительные ресурсы компонентов кластера ([тарифы Yandex MetaData Hub](../../metadata-hub/pricing.md)).


## Подготовьте инфраструктуру {#infra}

Подготовьте инфраструктуру:

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `spark-agent` и выдайте ему роль [managed-spark.integrationProvider](../../iam/roles-reference.md#managed-spark-integrationProvider).

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `metastore-agent` и выдайте ему роль [managed-metastore.integrationProvider](../../iam/roles-reference.md#managed-metastore-integrationProvider), чтобы кластер Apache Hive™ Metastore мог [взаимодействовать с другими ресурсами](../../metadata-hub/concepts/metastore-impersonation.md).

1. [Создайте бакеты](../../storage/operations/buckets/create.md):

    * бакет для исходного кода PySpark-задания;
    * бакет для выходных данных.

1. [Предоставьте разрешения](../../storage/operations/buckets/edit-acl.md) для сервисного аккаунта `spark-agent` на созданные бакеты:

    * бакет для исходного кода PySpark-задания — `READ`;
    * бакет для выходных данных — `READ и WRITE`.

1. [Предоставьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ и WRITE` для сервисного аккаунта `metastore-agent` на бакет для выходных данных.

1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `integration-network`.

    Вместе с ней автоматически создадутся три подсети в разных зонах доступности.

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

1. [Создайте кластер Yandex Managed Service for Apache Spark™](../../managed-spark/operations/cluster-create.md) с параметрами:

    * **Сервисный аккаунт** — `spark-agent`.
    * **Сеть** — `integration-network`.
    * **Подсеть** — `integration-network-ru-central1-a`.
    * **Группы безопасности** — `spark-sg`.
    * **Metastore-сервер** — созданный ранее кластер Apache Hive™ Metastore.

## Подготовьте и запустите PySpark-задание {#prepare-job}

Для PySpark-задания будет использован Python-скрипт, который:

1. Создает базу данных и таблицу формата Apache Iceberg™ в бакете.
1. Записывает 10 строк с данными в таблицу.
1. Сохраняет идентификатор текущего снимка таблицы.
1. Записывает еще 10 строк с данными в таблицу.
1. Выводит количество строк в текущем состоянии таблицы.
1. Выводит количество строк в состоянии таблицы на момент снимка. 

Подготовьте файл скрипта:

1. Создайте файл `ice_min_demo.py` и скопируйте в него следующий код:

   {% cut "ice_min_demo.py" %}

   ```python
   import random
   from pyspark.sql import SparkSession

   spark = (
      SparkSession.builder
      .appName("ice_min_demo")
      .enableHiveSupport()
      .getOrCreate()
   )

   # Создание базы данных и таблицы в формате Apache Iceberg™.
   # Apache Hive™ Metastore фиксирует метаданные, что позволяет обращаться к таблице по имени db.tbl
   # из любых приложений Spark, подключённых к этому кластеру Apache Hive™ Metastore.
   db, tbl = "demo_db", "demo_events"
   spark.sql(f"CREATE DATABASE IF NOT EXISTS {db}")
   spark.sql(f"""
   CREATE TABLE IF NOT EXISTS {db}.{tbl} (
      id BIGINT,
      value DOUBLE
   ) USING iceberg
   """)

   # Запись первого набора данных в таблицу
   df1 = spark.createDataFrame([(i, random.random()) for i in range(10)], ["id","value"])
   df1.writeTo(f"{db}.{tbl}").append()

   # Фиксация идентификатора текущего снимка из служебной таблицы .snapshots
   snap_before = spark.sql(f"SELECT max(snapshot_id) AS s FROM {db}.{tbl}.snapshots").collect()[0][0]

   # Запись второго набора данных в таблицу
   df2 = spark.createDataFrame([(i, random.random()) for i in range(10, 20)], ["id","value"])
   df2.writeTo(f"{db}.{tbl}").append()

   # Подсчет и вывод числа строк в текущем (20) и предыдущем состоянии таблицы (10)
   cnt_now = spark.table(f"{db}.{tbl}").count()
   cnt_past = spark.sql(f"SELECT COUNT(*) FROM {db}.{tbl} VERSION AS OF {snap_before}").collect()[0][0]
   print(f"now_count: {cnt_now} | past_count: {cnt_past}", flush=True)

   spark.stop()
   ```

   {% endcut %}

1. В бакете для исходного кода создайте папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `ice_min_demo.py`.
1. [Создайте задание](../../managed-spark/operations/jobs-pyspark.md) с параметрами:
    * **Тип задания**: **PySpark**.
    * **Main python файл**: `s3a://<бакет_для_исходного_кода>/scripts/ice_min_demo.py`.
    * **Настройки**: `spark.sql.warehouse.dir` – `s3a://<бакет_для_выходных_данных>/warehouse/`.

## Проверьте результат {#check-out}

1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
1. Откройте [логи выполнения задания](../../managed-spark/operations/jobs-pyspark.md#get-logs).
1. Найдите в логах строку `now_count: 20 | past_count: 10`.
1. Убедитесь, что в бакете для выходных данных появилась папка `warehouse/demo_db`. Теперь данные из созданной БД `demo_db` хранятся в бакете Object Storage, а метаинформация о ней — в кластере Apache Hive™ Metastore.
 
## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Бакеты Object Storage](../../storage/operations/buckets/delete.md). Перед удалением бакетов [удалите из них все объекты](../../storage/operations/objects/delete.md).
1. [Кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-delete.md).
1. [Кластер Yandex Managed Service for Apache Spark™](../../managed-spark/operations/cluster-delete.md).