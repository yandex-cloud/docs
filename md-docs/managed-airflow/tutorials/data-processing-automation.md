[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Airflow™](../index.md) > [Практические руководства](index.md) > Работа с кластерами > Yandex Data Processing: автоматизация работы

# Автоматизация работы с Yandex Data Processing

# Автоматизация работы с Yandex Data Processing с помощью Yandex Managed Service for Apache Airflow™


{% note warning %}

Руководство тестировалось на кластерах с версией Apache Airflow™ ниже 3.0.

{% endnote %}

В сервисе Yandex Managed Service for Apache Airflow™ можно создать DAG — [направленный ациклический граф задач](../concepts/index.md), который позволит автоматизировать работу с [сервисом Yandex Data Processing](../../data-proc/index.md). Ниже рассматривается DAG, который включает в себя несколько задач:

1. Создать кластер Yandex Data Processing.
1. Создать и запустить [задание PySpark](../../data-proc/concepts/jobs.md).
1. Удалить кластер Yandex Data Processing.

При таком DAG кластер существует непродолжительное время. Так как стоимость ресурсов Yandex Data Processing [зависит от времени их использования](../../data-proc/pricing.md), в кластере можно задействовать ресурсы повышенной мощности и быстро обработать большее количество данных за те же деньги.

В этом DAG кластер Yandex Data Processing создается без сервиса Hive. Для хранения табличных метаданных в примере ниже используется [кластер Apache Hive™ Metastore](../../metadata-hub/concepts/metastore.md). Сохраненные метаданные затем может использовать другой кластер Yandex Data Processing.

Чтобы автоматизировать работу с Yandex Data Processing с помощью Managed Service for Apache Airflow™:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Подготовьте и запустите DAG-файл](#dag).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Airflow™: вычислительные ресурсы компонентов кластера ([тарифы Managed Service for Apache Airflow™](../pricing.md)).
* Кластер Apache Hive™ Metastore: вычислительные ресурсы компонентов кластера ([тарифы Yandex MetaData Hub](../../metadata-hub/pricing.md#metastore)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Бакеты Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Кластер Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../data-proc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

В примере ниже рассматривается два сценария. Выберите наиболее подходящий:

* **Высокий уровень безопасности**. Такой сценарий рекомендуемый, так как в нем соблюдается [принцип минимальных привилегий](../../iam/best-practices/using-iam-securely.md#restrict-access). Сценарий включает в себя следующие особенности:

   * Права доступа разделяются между сервисными аккаунтами. Для каждого кластера вы создаете отдельный сервисный аккаунт и назначаете ему роли, необходимые только для работы кластера этого аккаунта.
   * Используется несколько бакетов для разных задач, различные данные хранятся в разных бакетах. Например, результаты выполнения PySpark-задания записываются в один бакет, а логи — в другой.
   * Настроены группы безопасности. Вы ограничиваете трафик, и в результате доступ получают только разрешенные ресурсы.

* **Упрощенная настройка**. Предусматривает более низкий уровень безопасности:

   * Используется один сервисный аккаунт, который обладает большими привилегиями, чем необходимо.
   * Все данные хранятся только в одном бакете, но в разных папках.
   * Группы безопасности не настраиваются.

{% list tabs group=instructions %}

* Высокий уровень безопасности

   Подготовьте инфраструктуру:

   1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md) со следующими ролями:

      #|
      || **Сервисный аккаунт** | **Его роли** ||
      || `airflow-agent` для кластера Apache Airflow™. |
      * [dataproc.editor](../../iam/roles-reference.md#dataproc-editor) — чтобы управлять кластером Yandex Data Processing из DAG;
      * [vpc.user](../../iam/roles-reference.md#vpc-user) — чтобы в кластере Apache Airflow™ использовать [подсеть Virtual Private Cloud](../../vpc/concepts/network.md#subnet);
      * [managed-airflow.integrationProvider](../../iam/roles-reference.md#managed-airflow-integrationProvider) — чтобы кластер Apache Airflow™ мог [взаимодействовать с другими ресурсами](../concepts/impersonation.md);
      * [iam.serviceAccounts.user](../../iam/roles-reference.md#iam-serviceAccounts-user) — чтобы указать сервисный аккаунт `data-processing-agent` при создании кластера Yandex Data Processing. ||
      || `metastore-agent` для кластера Apache Hive™ Metastore. |
      * [managed-metastore.integrationProvider](../../iam/roles-reference.md#managed-metastore-integrationProvider) — чтобы кластер Apache Hive™ Metastore мог [взаимодействовать с другими ресурсами](../../metadata-hub/concepts/metastore-impersonation.md). ||
      || `data-processing-agent` для кластера Yandex Data Processing. |
      * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent) — чтобы сервисный аккаунт мог получать информацию о состоянии хостов кластера, [заданиях](../../data-proc/concepts/jobs.md) и [лог-группах](../../logging/concepts/log-group.md).
      * [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner) — чтобы сервисный аккаунт мог взаимодействовать с автоматически масштабируемой группой ВМ. Тогда будет доступно [автомасштабирование подкластеров](../../data-proc/concepts/autoscaling.md).
      * [resource-manager.auditor](../../resource-manager/security/index.md#resource-manager-auditor) и выше на каталог, в котором нужно создать кластер Yandex Data Processing — для подключения к кластеру с помощью [OS Login](../../organization/concepts/os-login.md).
      
      {% note tip %}
      
      Чтобы ограничить права сервисного аккаунта кластера (его IAM-токен доступен при выполнении заданий):
      
      1. Укажите отдельный сервисный аккаунт для автомасштабирования подкластеров при [создании](../../data-proc/operations/cluster-create.md) или [изменении кластера](../../data-proc/operations/cluster-update.md) через интерфейсы Yandex Cloud CLI, Terraform или API.
      1. Назначьте роль `dataproc.provisioner` только этому аккаунту.
      
      {% endnote %}
      ||
      |#

   1. [Создайте бакеты](../../storage/operations/buckets/create.md):

      * `<бакет_для_Managed_Airflow>`;
      * `<бакет_для_исходного_кода_PySpark_задания>`;
      * `<бакет_для_выходных_данных_PySpark_задания>`;
      * `<бакет_для_сбора_логов_Spark>`.

      Бакетов нужно несколько, так как на них назначаются различные права доступа.

   1. [Предоставьте разрешения](../../storage/operations/buckets/edit-acl.md) на следующие бакеты:

      * `<бакет_для_Managed_Airflow>` — разрешение `READ` для сервисного аккаунта `airflow-agent`;
      * `<бакет_для_исходного_кода_PySpark_задания>` — разрешение `READ` для сервисного аккаунта `data-processing-agent`;
      * `<бакет_для_выходных_данных_PySpark_задания>` — разрешение `READ и WRITE` для сервисных аккаунтов `data-processing-agent` и `metastore-agent`;
      * `<бакет_для_сбора_логов_Spark>` — разрешение `READ и WRITE` для сервисного аккаунта `data-processing-agent`.

   1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `data-processing-network`.

      Вместе с ней автоматически создадутся три подсети в разных зонах доступности.

   1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети `data-processing-network-ru-central1-a`.
   1. Для кластера Apache Hive™ Metastore [создайте группу безопасности](../../vpc/operations/security-group-create.md) `metastore-sg` в сети `data-processing-network`. Добавьте в группу следующие правила:

      * Для входящего трафика от клиентов:

         * диапазон портов — `30000-32767`;
         * протокол — `Любой` (`Any`);
         * источник — `CIDR`;
         * CIDR блоки — `0.0.0.0/0`.

      * Для входящего трафика от балансировщика:

         * диапазон портов — `10256`;
         * протокол — `Любой` (`Any`);
         * источник — `Проверки состояния балансировщика`.

   1. Для кластеров Managed Service for Apache Airflow™ и Yandex Data Processing создайте группу безопасности `airflow-sg` в сети `data-processing-network`. Добавьте в группу следующие правила:

      * Для входящего служебного трафика:

         * диапазон портов — `0-65535`;
         * протокол — `Любой` (`Any`);
         * источник — `Группа безопасности`;
         * группа безопасности — `Текущая` (`Self`).

      * Для исходящего служебного трафика:

         * диапазон портов — `0-65535`;
         * протокол — `Любой` (`Any`);
         * назначение — `Группа безопасности`;
         * группа безопасности — `Текущая` (`Self`).

      * Для исходящего HTTPS-трафика:

         * диапазон портов — `443`;
         * протокол — `TCP`;
         * назначение — `CIDR`;
         * CIDR блоки — `0.0.0.0/0`.

      * Для исходящего трафика, чтобы разрешить подключение кластера Yandex Data Processing к Apache Hive™ Metastore:

         * диапазон портов — `9083`;
         * протокол — `Любой` (`Any`);
         * назначение — `Группа безопасности`;
         * группа безопасности — `metastore-sg` (`Из списка`).

   1. [Создайте кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-create.md) с параметрами:

      * **Сервисный аккаунт** — `metastore-agent`.
      * **Версия** — `3.1`.
      * **Сеть** — `data-processing-network`.
      * **Подсеть** — `data-processing-network-ru-central1-a`.
      * **Группа безопасности** — `metastore-sg`.

   1. [Создайте кластер Managed Service for Apache Airflow™](../operations/cluster-create.md) с параметрами:

      * **Сервисный аккаунт** — `airflow-agent`.
      * **Зона доступности** — `ru-central1-a`.
      * **Сеть** — `data-processing-network`.
      * **Подсеть** — `data-processing-network-ru-central1-a`.
      * **Группа безопасности** — `airflow-sg`.
      * **Имя бакета** — `<бакет_для_Managed_Airflow>`.

* Упрощенная настройка

   Подготовьте инфраструктуру:

   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `my-editor` со следующими ролями:

      * [dataproc.editor](../../iam/roles-reference.md#dataproc-editor) — для управления кластером Yandex Data Processing из DAG;
      * [editor](../../iam/roles-reference.md#editor) — для остальных необходимых операций.

   1. [Создайте бакет](../../storage/operations/buckets/create.md) `<бакет_для_заданий_и_данных>`.

      На него не нужно [предоставлять разрешение](../../storage/operations/buckets/edit-acl.md) сервисному аккаунту, так как роли `editor` достаточно.

   1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `data-processing-network`.

      Вместе с ней автоматически создадутся три подсети в разных зонах доступности и группа безопасности.

   1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети `data-processing-network-ru-central1-a`.
   1. [Создайте кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-create.md) с параметрами:

      * **Сервисный аккаунт** — `my-editor`.
      * **Версия** — `3.1`.
      * **Сеть** — `data-processing-network`.
      * **Подсеть** — `data-processing-network-ru-central1-a`.
      * **Группа безопасности** — группа по умолчанию в сети `data-processing-network`.

   1. [Создайте кластер Managed Service for Apache Airflow™](../operations/cluster-create.md) с параметрами:

      * **Сервисный аккаунт** — `my-editor`.
      * **Зона доступности** — `ru-central1-a`.
      * **Сеть** — `data-processing-network`.
      * **Подсеть** — `data-processing-network-ru-central1-a`.
      * **Группа безопасности** — группа по умолчанию в сети `data-processing-network`.
      * **Имя бакета** — `<бакет_для_заданий_и_данных>`.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-a-job}

Для PySpark-задания будет использован Python-скрипт, который создает таблицу и хранится в бакете Object Storage. Подготовьте файл скрипта:

{% list tabs group=instructions %}

* Высокий уровень безопасности

   1. Создайте локально файл с именем `create-table.py` и скопируйте в него скрипт:

      {% cut "create-table.py" %}

      ```python
      from pyspark.sql.types import *
      from pyspark.sql import SparkSession

      # Создание Spark-сессии
      spark = SparkSession.builder \
          .appName("create-table") \
          .enableHiveSupport() \
          .getOrCreate()

      # Создание схемы данных
      schema = StructType([StructField('Name', StringType(), True),
      StructField('Capital', StringType(), True),
      StructField('Area', IntegerType(), True),
      StructField('Population', IntegerType(), True)])

      # Создание датафрейма
      df = spark.createDataFrame([('Австралия', 'Канберра', 7686850, 19731984), ('Австрия', 'Вена', 83855, 7700000)], schema)

      # Запись датафрейма в бакет в виде таблицы countries
      df.write.mode("overwrite").option("path","s3a://<бакет_для_выходных_данных_PySpark_задания>/countries").saveAsTable("countries")
      ```

      {% endcut %}

   1. Создайте в бакете `<бакет_для_исходного_кода_PySpark_задания>` папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `create-table.py`.

* Упрощенная настройка

   1. Создайте локально файл с именем `create-table.py` и скопируйте в него скрипт:

      {% cut "create-table.py" %}

      ```python
      from pyspark.sql.types import *
      from pyspark.sql import SparkSession

      # Создание Spark-сессии
      spark = SparkSession.builder \
          .appName("create-table") \
          .enableHiveSupport() \
          .getOrCreate()

      # Создание схемы данных
      schema = StructType([StructField('Name', StringType(), True),
      StructField('Capital', StringType(), True),
      StructField('Area', IntegerType(), True),
      StructField('Population', IntegerType(), True)])

      # Создание датафрейма
      df = spark.createDataFrame([('Австралия', 'Канберра', 7686850, 19731984), ('Австрия', 'Вена', 83855, 7700000)], schema)

      # Запись датафрейма в бакет в виде таблицы countries
      df.write.mode("overwrite").option("path","s3a://<бакет_для_заданий_и_данных>/countries").saveAsTable("countries")
      ```

      {% endcut %}

   1. Создайте в бакете `<бакет_для_заданий_и_данных>` папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `create-table.py`.

{% endlist %}

## Подготовьте и запустите DAG-файл {#dag}

DAG будет состоять из нескольких вершин, которые формируют цепочку последовательных действий:

1. Managed Service for Apache Airflow™ создает временный, легковесный кластер Yandex Data Processing с настройками, заданными в DAG. Этот кластер автоматически подключается к созданному ранее кластеру Apache Hive™ Metastore.
1. Когда кластер Yandex Data Processing готов, запускается задание PySpark.
1. После выполнения задания временный кластер Yandex Data Processing удаляется.

Чтобы подготовить DAG:

{% list tabs group=instructions %}

* Высокий уровень безопасности

   1. [Создайте SSH-ключ](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Сохраните открытую часть ключа — она понадобится для создания кластера Yandex Data Processing.
   1. Создайте локально файл с именем `Data-Processing-DAG.py`, скопируйте в него скрипт и подставьте данные вашей инфраструктуры в переменные:

      {% cut "Data-Processing-DAG.py" %}

      ```python
      import uuid
      import datetime
      from airflow import DAG
      from airflow.utils.trigger_rule import TriggerRule
      from airflow.providers.yandex.operators.yandexcloud_dataproc import (
          DataprocCreateClusterOperator,
          DataprocCreatePysparkJobOperator,
          DataprocDeleteClusterOperator,
      )

      # Данные вашей инфраструктуры
      YC_DP_AZ = 'ru-central1-a'
      YC_DP_SSH_PUBLIC_KEY = '<открытая_часть_SSH-ключа>'
      YC_DP_SUBNET_ID = '<идентификатор_подсети>'
      YC_DP_SA_ID = '<идентификатор_сервисного_аккаунта_data-processing-agent>'
      YC_DP_METASTORE_URI = '<IP-адрес>'
      YC_SOURCE_BUCKET = '<бакет_для_исходного_кода_PySpark_задания>'
      YC_DP_LOGS_BUCKET = '<бакет_для_сбора_логов_Spark>'

      # Настройки DAG
      with DAG(
              'DATA_INGEST',
              schedule='@hourly',
              tags=['data-processing-and-airflow'],
              start_date=datetime.datetime.now(),
              max_active_runs=1,
              catchup=False
      ) as ingest_dag:
          # 1 этап: создание кластера Yandex Data Proc
          create_spark_cluster = DataprocCreateClusterOperator(
              task_id='dp-cluster-create-task',
              cluster_name=f'tmp-dp-{uuid.uuid4()}',
              cluster_description='Временный кластер для выполнения PySpark-задания под оркестрацией Managed Service for Apache Airflow™',
              ssh_public_keys=YC_DP_SSH_PUBLIC_KEY,
              service_account_id=YC_DP_SA_ID,
              subnet_id=YC_DP_SUBNET_ID,
              s3_bucket=YC_DP_LOGS_BUCKET,
              zone=YC_DP_AZ,
              cluster_image_version='2.1',
              masternode_resource_preset='s2.small',
              masternode_disk_type='network-ssd',
              masternode_disk_size=200,
              computenode_resource_preset='m2.large',
              computenode_disk_type='network-ssd',
              computenode_disk_size=200,
              computenode_count=2,
              computenode_max_hosts_count=5,  # Количество подкластеров для обработки данных будет автоматически масштабироваться в случае большой нагрузки.
              services=['YARN', 'SPARK'],     # Создается легковесный кластер.
              datanode_count=0,               # Без подкластеров для хранения данных.
              properties={                    # С указанием на удаленный кластер Apache Hive™ Metastore.
                  'spark:spark.hive.metastore.uris': f'thrift://{YC_DP_METASTORE_URI}:9083',
              },
          )

          # 2 этап: запуск задания PySpark
          poke_spark_processing = DataprocCreatePysparkJobOperator(
              task_id='dp-cluster-pyspark-task',
              main_python_file_uri=f's3a://{YC_SOURCE_BUCKET}/scripts/create-table.py',
          )

          # 3 этап: удаление кластера Yandex Data Processing
          delete_spark_cluster = DataprocDeleteClusterOperator(
              task_id='dp-cluster-delete-task',
              trigger_rule=TriggerRule.ALL_DONE,
          )

          # Формирование DAG из указанных выше этапов
          create_spark_cluster >> poke_spark_processing >> delete_spark_cluster
      ```

      Где:

      * `YC_DP_AZ` — зона доступности для кластера Yandex Data Processing;
      * `YC_DP_SSH_PUBLIC_KEY` — открытая часть SSH-ключа для кластера Yandex Data Processing;
      * `YC_DP_SUBNET_ID` — идентификатор подсети;
      * `YC_DP_SA_ID` — идентификатор сервисного аккаунта для Yandex Data Processing;
      * `YC_DP_METASTORE_URI` — IP-адрес кластера Apache Hive™ Metastore;
      * `YC_SOURCE_BUCKET` — бакет с Python-скриптом для задания PySpark;
      * `YC_DP_LOGS_BUCKET` — бакет для логов.

      {% endcut %}

   1. Загрузите DAG в кластер Managed Service for Apache Airflow™: создайте в бакете `<бакет_для_Managed_Airflow>` папку `dags` и загрузите в нее файл `Data-Processing-DAG.py`.
   1. Откройте веб-интерфейс Apache Airflow™.
   1. Убедитесь, что в разделе **DAGs** появился новый DAG `DATA_INGEST` с тегом `data-processing-and-airflow`.

      Загрузка DAG-файла из бакета может занять несколько минут.

   1. Чтобы запустить DAG, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

* Упрощенная настройка

   1. [Создайте SSH-ключ](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Сохраните открытую часть ключа — она понадобится для создания кластера Yandex Data Processing.
   1. Создайте локально файл с именем `Data-Processing-DAG.py`, скопируйте в него скрипт и подставьте данные вашей инфраструктуры в переменные:

      {% cut "Data-Processing-DAG.py" %}

      ```python
      import uuid
      import datetime
      from airflow import DAG
      from airflow.utils.trigger_rule import TriggerRule
      from airflow.providers.yandex.operators.yandexcloud_dataproc import (
          DataprocCreateClusterOperator,
          DataprocCreatePysparkJobOperator,
          DataprocDeleteClusterOperator,
      )

      # Данные вашей инфраструктуры
      YC_DP_AZ = 'ru-central1-a'
      YC_DP_SSH_PUBLIC_KEY = '<открытая_часть_SSH-ключа>'
      YC_DP_SUBNET_ID = '<идентификатор_подсети>'
      YC_DP_SA_ID = '<идентификатор_сервисного_аккаунта_my-editor>'
      YC_DP_METASTORE_URI = '<IP-адрес>'
      YC_BUCKET = '<бакет_для_заданий_и_данных>'

      # Настройки DAG
      with DAG(
              'DATA_INGEST',
              schedule='@hourly',
              tags=['data-processing-and-airflow'],
              start_date=datetime.datetime.now(),
              max_active_runs=1,
              catchup=False
      ) as ingest_dag:
          # 1 этап: создание кластера Yandex Data Proc
          create_spark_cluster = DataprocCreateClusterOperator(
              task_id='dp-cluster-create-task',
              cluster_name=f'tmp-dp-{uuid.uuid4()}',
              cluster_description='Временный кластер для выполнения PySpark-задания под оркестрацией Managed Service for Apache Airflow™',
              ssh_public_keys=YC_DP_SSH_PUBLIC_KEY,
              service_account_id=YC_DP_SA_ID,
              subnet_id=YC_DP_SUBNET_ID,
              s3_bucket=YC_BUCKET,
              zone=YC_DP_AZ,
              cluster_image_version='2.1',
              masternode_resource_preset='s2.small',
              masternode_disk_type='network-ssd',
              masternode_disk_size=200,
              computenode_resource_preset='m2.large',
              computenode_disk_type='network-ssd',
              computenode_disk_size=200,
              computenode_count=2,
              computenode_max_hosts_count=5,  # Количество подкластеров для обработки данных будет автоматически масштабироваться в случае большой нагрузки.
              services=['YARN', 'SPARK'],     # Создается легковесный кластер.
              datanode_count=0,               # Без подкластеров для хранения данных.
              properties={                    # С указанием на удаленный кластер Apache Hive™ Metastore.
                  'spark:spark.hive.metastore.uris': f'thrift://{YC_DP_METASTORE_URI}:9083',
              },
          )

          # 2 этап: запуск задания PySpark
          poke_spark_processing = DataprocCreatePysparkJobOperator(
              task_id='dp-cluster-pyspark-task',
              main_python_file_uri=f's3a://{YC_BUCKET}/scripts/create-table.py',
          )

          # 3 этап: удаление кластера Yandex Data Processing
          delete_spark_cluster = DataprocDeleteClusterOperator(
              task_id='dp-cluster-delete-task',
              trigger_rule=TriggerRule.ALL_DONE,
          )

          # Формирование DAG из указанных выше этапов
          create_spark_cluster >> poke_spark_processing >> delete_spark_cluster
      ```

      Где:

      * `YC_DP_AZ` — зона доступности для кластера Yandex Data Processing;
      * `YC_DP_SSH_PUBLIC_KEY` — открытая часть SSH-ключа для кластера Yandex Data Processing;
      * `YC_DP_SUBNET_ID` — идентификатор подсети;
      * `YC_DP_SA_ID` — идентификатор сервисного аккаунта `my-editor`;
      * `YC_DP_METASTORE_URI` — IP-адрес кластера Apache Hive™ Metastore;
      * `YC_BUCKET` — `<бакет_для_заданий_и_данных>`.

      {% endcut %}

   1. Загрузите DAG в кластер Managed Service for Apache Airflow™: создайте в бакете `<бакет_для_заданий_и_данных>` папку `dags` и загрузите в нее файл `Data-Processing-DAG.py`.
   1. Откройте веб-интерфейс Apache Airflow™.
   1. Убедитесь, что в разделе **DAGs** появился новый DAG `DATA_INGEST` с тегом `data-processing-and-airflow`.

      Загрузка DAG-файла из бакета может занять несколько минут.

   1. Чтобы запустить DAG, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

{% endlist %}

## Проверьте результат {#check-out}

{% list tabs group=instructions %}

* Высокий уровень безопасности

   1. Чтобы отслеживать результаты выполнения задач, нажмите на название DAG. Результаты отображаются во вкладке **Grid**.
   1. Дождитесь, когда все три задачи в DAG перейдут в статус **Success**. Параллельно вы можете проверить, что в [консоли управления](https://console.yandex.cloud) создается кластер Yandex Data Processing, выполняется задание PySpark и удаляется тот же кластер.
   1. Убедитесь, что в бакете `<бакет_для_выходных_данных_PySpark_задания>` появилась папка `countries`, а в ней — файл `part-00000-...`. Теперь данные из созданной таблицы хранятся в бакете Object Storage, а метаинформация о ней — в кластере Apache Hive™ Metastore.
   1. Проверьте, что в бакете `<бакет_для_сбора_логов_Spark>` появились логи выполнения PySpark-задания.

* Упрощенная настройка

   1. Чтобы отслеживать результаты выполнения задач, нажмите на название DAG. Результаты отображаются во вкладке **Grid**.
   1. Дождитесь, когда все три задачи в DAG перейдут в статус **Success**. Параллельно вы можете проверить, что в [консоли управления](https://console.yandex.cloud) создается кластер Yandex Data Processing, выполняется задание PySpark и удаляется тот же кластер.
   1. Убедитесь, что в бакете `<бакет_для_заданий_и_данных>` появилась папка `countries`, а в ней — файл `part-00000-...`. Теперь данные из созданной таблицы хранятся в бакете Object Storage, а метаинформация о ней — в кластере Apache Hive™ Metastore.
   1. Проверьте, что в бакете `<бакет_для_заданий_и_данных>` появились логи выполнения PySpark-задания. Они записываются в папки `dataproc`, `user` и `var`.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

* Высокий уровень безопасности

   1. [Сервисные аккаунты](../../iam/operations/sa/delete.md).
   1. [Бакеты Object Storage](../../storage/operations/buckets/delete.md).
   1. [Кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-delete.md).
   1. [Кластер Managed Service for Apache Airflow™](../operations/cluster-delete.md).
   1. [Таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
   1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
   1. [Группы безопасности](../../vpc/operations/security-group-delete.md).
   1. [Облачные подсети](../../vpc/operations/subnet-delete.md), созданные по умолчанию в сети `data-processing-network`.
   1. [Облачную сеть](../../vpc/operations/network-delete.md).

* Упрощенная настройка

   1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
   1. [Бакет Object Storage](../../storage/operations/buckets/delete.md).
   1. [Кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-delete.md).
   1. [Кластер Managed Service for Apache Airflow™](../operations/cluster-delete.md).
   1. [Таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
   1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
   1. [Группу безопасности](../../vpc/operations/security-group-delete.md), созданную по умолчанию в сети `data-processing-network`.
   1. [Облачные подсети](../../vpc/operations/subnet-delete.md), созданные по умолчанию в сети `data-processing-network`.
   1. [Облачную сеть](../../vpc/operations/network-delete.md).

{% endlist %}