# Работа с таблицей формата {{ IBRG }} из PySpark-задания


В сервис {{ msp-full-name }} интегрирована библиотека {{ IBRG }}. Чтобы использовать в PySpark-задании возможности {{ IBRG }}, подключите к кластеру {{ msp-full-name }} сервер {{ metastore-name }}.

Формат {{ IBRG }} обеспечивает:
* Версионирование данных и хранение снимков состояний.
* ACID-транзакции, которые поддерживают операции `UPDATE`, `DELETE`, `MERGE`, а также эволюцию таблиц и способа партиционирования.
* Масштабируемость с сохранением высокой производительности операций.

В этом руководстве показан пример использования формата таблиц {{ IBRG }} для создания и чтения снимков метаданных. Таблица {{ IBRG }} создается в S3-хранилище {{ objstorage-name }}. Кластер {{ msp-full-name }}, в котором запускается PySpark-задание, использует глобальный каталог {{ metastore-name }}. Подробнее о подключении глобального каталога см. в руководстве [{#T}](../../../managed-spark/tutorials/metastore-and-spark.md).

Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте и запустите PySpark-задание](#prepare-job).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за бакеты {{ objstorage-name }}: хранение данных и выполнение операций с ними (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md)).
* Плата за получение и хранение логов (см. [тарифы {{ cloud-logging-name }}](../../../logging/pricing.md)).
* Плата за вычислительные ресурсы компонентов кластера {{ msp-full-name }} (см. [тарифы {{ msp-full-name }}](../../../managed-spark/pricing.md)).
* Плата за вычислительные ресурсы компонентов кластера {{ metastore-name }} (см. [тарифы {{ metadata-hub-full-name }}](../../../metadata-hub/pricing.md)).


## Подготовьте инфраструктуру {#infra}

Подготовьте инфраструктуру:

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `spark-agent` и выдайте ему роль [managed-spark.integrationProvider](../../../iam/roles-reference.md#managed-spark-integrationProvider).

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `metastore-agent` и выдайте ему роль [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider), чтобы кластер {{ metastore-name }} мог [взаимодействовать с другими ресурсами](../../../metadata-hub/concepts/metastore-impersonation.md).

1. [Создайте бакеты](../../../storage/operations/buckets/create.md):

    * бакет для исходного кода PySpark-задания;
    * бакет для выходных данных.

1. [Предоставьте разрешения](../../../storage/operations/buckets/edit-acl.md) для сервисного аккаунта `spark-agent` на созданные бакеты:

    * бакет для исходного кода PySpark-задания — `READ`;
    * бакет для выходных данных — `READ и WRITE`.

1. [Предоставьте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` для сервисного аккаунта `metastore-agent` на бакет для выходных данных.

1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `integration-network`.

    Вместе с ней автоматически создадутся три подсети в разных зонах доступности.

1. Для кластера {{ msp-full-name }} [создайте группу безопасности](../../../vpc/operations/security-group-create.md) `spark-sg` в сети `integration-network`. Добавьте в группу следующее правило:

    * Для исходящего трафика, чтобы разрешить подключение кластера {{ msp-full-name }} к {{ metastore-name }}:

        * Диапазон портов — `{{ port-metastore }}`.
        * Протокол — `Любой` (`Any`).
        * Назначение — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`.

1. Для кластера {{ metastore-name }} [создайте группу безопасности](../../../vpc/operations/security-group-create.md) `metastore-sg` в сети `integration-network`. Добавьте в группу следующие правила:

    * Для входящего трафика от клиентов:

        * Диапазон портов — `30000-32767`.
        * Протокол — `Любой` (`Any`).
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`.

    * Для входящего трафика от балансировщика:

        * Диапазон портов — `10256`.
        * Протокол — `Любой` (`Any`).
        * Источник — `Проверки состояния балансировщика`.

1. [Создайте кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-create.md) с параметрами:

    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `metastore-agent`.
    * **{{ ui-key.yacloud.mdb.forms.base_field_version }}** — `{{ metastore.integration-version }}`.
    * **{{ ui-key.yacloud.mdb.forms.label_network }}** — `integration-network`.
    * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** — `integration-network-{{ region-id }}-a`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `metastore-sg`.

1. [Создайте кластер {{ msp-full-name }}](../../../managed-spark/operations/cluster-create.md) с параметрами:

    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `spark-agent`.
    * **{{ ui-key.yacloud.mdb.forms.label_network }}** — `integration-network`.
    * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** — `integration-network-{{ region-id }}-a`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `spark-sg`.
    * **{{ ui-key.yacloud.spark.label_metastore }}** — созданный ранее кластер {{ metastore-name }}.

## Подготовьте и запустите PySpark-задание {#prepare-job}

Для PySpark-задания будет использован Python-скрипт, который:

1. Создает базу данных и таблицу формата {{ IBRG }} в бакете.
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

   # Создание базы данных и таблицы в формате {{ IBRG }}.
   # {{ metastore-name }} фиксирует метаданные, что позволяет обращаться к таблице по имени db.tbl
   # из любых приложений Spark, подключённых к этому кластеру {{ metastore-name }}.
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

1. В бакете для исходного кода создайте папку `scripts` и [загрузите](../../../storage/operations/objects/upload.md#simple) в нее файл `ice_min_demo.py`.
1. [Создайте задание](../../../managed-spark/operations/jobs-pyspark.md) с параметрами:
    * **Тип задания**: **PySpark**.
    * **Main python файл**: `s3a://<бакет_для_исходного_кода>/scripts/ice_min_demo.py`.
    * **Настройки**: `spark.sql.warehouse.dir` – `s3a://<бакет_для_выходных_данных>/warehouse/`.

## Проверьте результат {#check-out}

1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
1. Откройте [логи выполнения задания](../../../managed-spark/operations/jobs-pyspark.md#get-logs).
1. Найдите в логах строку `now_count: 20 | past_count: 10`.
1. Убедитесь, что в бакете для выходных данных появилась папка `warehouse/demo_db`. Теперь данные из созданной БД `demo_db` хранятся в бакете {{ objstorage-name }}, а метаинформация о ней — в кластере {{ metastore-name }}.
 
## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Бакеты {{ objstorage-name }}](../../../storage/operations/buckets/delete.md). Перед удалением бакетов [удалите из них все объекты](../../../storage/operations/objects/delete.md).
1. [Кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-delete.md).
1. [Кластер {{ msp-full-name }}](../../../managed-spark/operations/cluster-delete.md).
