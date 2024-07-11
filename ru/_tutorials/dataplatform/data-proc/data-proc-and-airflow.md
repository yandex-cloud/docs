# Автоматизация работы с {{ dataproc-full-name }} с помощью {{ maf-full-name }}


В сервисе {{ maf-full-name }} можно создать DAG — [направленный ациклический граф задач](../../../managed-airflow/concepts/index.md), который позволит автоматизировать работу с [сервисом {{ dataproc-full-name }}](../../../data-proc/index.yaml). Ниже рассматривается DAG, который включает в себя несколько задач:

1. Создать кластер {{ dataproc-name }}.
1. Создать и запустить [задание PySpark](../../../data-proc/concepts/jobs.md).
1. Удалить кластер {{ dataproc-name }}.

При таком DAG кластер существует непродолжительное время. Так как стоимость ресурсов {{ dataproc-name }} [зависит от времени их использования](../../../data-proc/pricing.md), в кластере можно задействовать ресурсы повышенной мощности и быстро обработать большее количество данных за те же деньги.

В этом DAG кластер {{ dataproc-name }} создается без сервиса Hive. Для хранения табличных метаданных в примере ниже используется [кластер {{ metastore-full-name }}](../../../data-proc/concepts/metastore.md). Сохраненные метаданные затем может использовать другой кластер {{ dataproc-name }}.

Чтобы автоматизировать работу с {{ dataproc-name }} с помощью {{ maf-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Создайте подключения {{ AF }}](#connections).
1. [Подготовьте и запустите DAG-файл](#dag).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

Сервисы {{ maf-name }} и {{ metastore-name }} находятся на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `airflow-sa` с ролями:

   * `storage.editor`;
   * `dataproc.agent`;
   * `dataproc.editor`.

1. Создайте ключи для сервисного аккаунта:

   * [Статический ключ доступа](../../../iam/operations/sa/create-access-key.md). Сохраните его идентификатор и секретный ключ.
   * [Авторизованный ключ](../../../iam/operations/authorized-key/create.md). Сохраните открытую часть ключа и скачайте файл с открытой и закрытой частями.

1. [Создайте бакеты](../../../storage/operations/buckets/create.md):

   * `airflow-bucket` — для {{ maf-name }};
   * `pyspark-bucket` — для PySpark-задания;
   * `output-bucket` – для выходных данных;
   * `log-bucket` — для сбора логов.

   Бакетов нужно несколько, так как на них назначаются различные права доступа.

1. [Предоставьте сервисному аккаунту](../../../storage/operations/buckets/edit-acl.md) `airflow-sa` разрешения на бакеты:

   * `airflow-bucket` — разрешение `READ`;
   * `pyspark-bucket` — разрешение `READ`;
   * `output-bucket` – разрешение `READ и WRITE`;
   * `log-bucket` — разрешение `READ и WRITE`.

1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `dataproc-network`.

   Вместе с ней автоматически создадутся три подсети в разных зонах доступности и группа безопасности.

1. [Настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) для подсети `dataproc-network-{{ region-id }}-a`.
1. [Добавьте правила](../../../vpc/operations/security-group-add-rule.md) в группу безопасности в сети `dataproc-network`:

   {% cut "Правила группы безопасности" %}

   #|
   || **Для какого сервиса нужно правило** | **Зачем нужно правило** | **Настройки правила** ||
   || {{ dataproc-name }} | Для входящего служебного трафика.
   |
   * Диапазон портов — `{{ port-any }}`.
   * Протокол — `Любой` (`Any`).
   * Источник — `Группа безопасности`.
   * Группа безопасности — `Текущая` (`Self`). ||
   || {{ metastore-name }} | Для входящего трафика от клиентов.
   |
   * Диапазон портов — `30000-32767`.
   * Протокол — `Любой` (`Any`).
   * Источник — `CIDR`.
   * CIDR блоки — `0.0.0.0/0`. ||
   || {{ metastore-name }} | Для входящего трафика от балансировщика.
   |
   * Диапазон портов — `10256`.
   * Протокол — `Любой` (`Any`).
   * Источник — `Проверки состояния балансировщика`. ||
   || {{ dataproc-name }} | Для исходящего служебного трафика.
   |
   * Диапазон портов — `{{ port-any }}`.
   * Протокол — `Любой` (`Any`).
   * Источник — `Группа безопасности`.
   * Группа безопасности — `Текущая` (`Self`). ||
   || {{ dataproc-name }} | Для исходящего HTTPS-трафика.
   |
   * Диапазон портов — `{{ port-https }}`.
   * Протокол — `TCP`.
   * Назначение — `CIDR`.
   * CIDR блоки — `0.0.0.0/0`. ||
   || {{ dataproc-name }} | Для исходящего трафика, чтобы разрешить подключение кластера {{ dataproc-name }} к {{ metastore-name }}.
   |
   * Диапазон портов — `{{ port-metastore }}`.
   * Протокол — `Любой` (`Any`).
   * Источник — `CIDR`.
   * CIDR блоки — `0.0.0.0/0`. ||
   |#

   {% endcut %}

1. [Создайте кластер {{ metastore-name }}](../../../data-proc/operations/metastore/cluster-create.md) с параметрами:

   * **Сеть** — `dataproc-network`.
   * **Подсеть** — `dataproc-network-{{ region-id }}-a`.
   * **Группа безопасности** — группа по умолчанию в сети `dataproc-network`.
   * **Идентификатор ключа** и **секретный ключ** — принадлежат статическому ключу доступа.

1. [Создайте кластер {{ maf-name }}](../../../managed-airflow/operations/cluster-create.md) с параметрами:

   * **Зона доступности** — `{{ region-id }}-a`.
   * **Сеть** — `dataproc-network`.
   * **Подсеть** — `dataproc-network-{{ region-id }}-a`.
   * **Группа безопасности** — группа по умолчанию в сети `dataproc-network`.
   * **Имя бакета** — `airflow-bucket`.
   * **Идентификатор ключа** и **секретный ключ** — принадлежат статическому ключу доступа.

## Подготовьте PySpark-задание {#prepare-a-job}

Для PySpark-задания будет использован Python-скрипт, который создает таблицу и хранится в бакете {{ objstorage-name }}. Подготовьте файл скрипта:

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
   df.write.mode("overwrite").option("path","s3a://output-bucket/countries").saveAsTable("countries")
   ```

   {% endcut %}

1. Создайте в бакете `pyspark-bucket` папку `scripts` и [загрузите](../../../storage/operations/objects/upload.md#simple) в нее файл `create-table.py`.

## Создайте подключения {{ AF }} {#connections}

Для DAG задач будет использовано два подключения: для {{ objstorage-name }} и сервисного аккаунта. Они будут указаны в DAG-файле. Чтобы создать подключения:

1. [Откройте веб-интерфейс {{ AF }}](../../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Перейдите в раздел **Admin** → **Connections**.
1. Нажмите кнопку ![image](../../../_assets/managed-airflow/blue-plus.png =18x).
1. Создайте подключение для {{ objstorage-name }}. Укажите его параметры:

   * **Connection Id** — `yc-s3`.
   * **Connection Type** — `Amazon Elastic MapReduce`.
   * **Run Job Flow Configuration** — JSON-файл в формате:

      ```json
      {
         "aws_access_key_id": "<идентификатор_статического_ключа>",
         "aws_secret_access_key": "<секретный_ключ>",
         "host": "https://{{ s3-storage-host }}/"
      }
      ```

      В файле укажите данные статического ключа, который вы [создавали ранее](#infra).

1. Нажмите кнопку **Save**.
1. Снова нажмите кнопку ![image](../../../_assets/managed-airflow/blue-plus.png =18x), чтобы создать подключение для сервисного аккаунта.
1. Укажите параметры подключения:

   * **Connection Id** — `yc-airflow-sa`.
   * **Connection Type** — `{{ yandex-cloud }}`.
   * **Service account auth JSON** — содержимое JSON-файла с авторизованным ключом.
   * **Public SSH key** — публичная часть авторизованного ключа, который вы [создавали ранее](#infra). Оформите ключ в виде одной строки, в нем не должно быть символов переноса.

   Остальные поля оставьте пустыми.

1. Нажмите кнопку **Save**.

## Подготовьте и запустите DAG-файл {#dag}

DAG будет состоять из нескольких вершин, которые формируют цепочку последовательных действий:

1. {{ maf-name }} создает временный, легковесный кластер {{ dataproc-name }} с настройками, заданными в DAG. Этот кластер автоматически подключается к созданному ранее кластеру {{ metastore-name }}.
1. Когда кластер {{ dataproc-name }} готов, запускается задание PySpark.
1. После выполнения задания временный кластер {{ dataproc-name }} удаляется.

Чтобы подготовить DAG:

1. [Создайте SSH-ключ](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Сохраните открытую часть ключа — она понадобится для создания кластера {{ dataproc-name }}.
1. Создайте локально файл с именем `Data-Proc-DAG.py`, скопируйте в него скрипт и подставьте данные вашей инфраструктуры в переменные:

   {% cut "Data-Proc-DAG.py" %}

   ```python
   import uuid
   import datetime
   from airflow import DAG, settings
   from airflow.models import Connection, Variable
   from airflow.utils.trigger_rule import TriggerRule
   from airflow.providers.amazon.aws.sensors.s3 import S3KeySensor
   from airflow.providers.amazon.aws.operators.s3 import S3DeleteObjectsOperator
   from airflow.providers.yandex.operators.yandexcloud_dataproc import (
       DataprocCreateClusterOperator,
       DataprocCreatePysparkJobOperator,
       DataprocDeleteClusterOperator,
   )

   # Данные вашей инфраструктуры
   YC_DP_FOLDER_ID = '<идентификатор_каталога>'
   YC_DP_SSH_PUBLIC_KEY = '<открытая_часть_SSH-ключа>'
   YC_DP_SUBNET_ID = '<идентификатор_подсети>'
   YC_DP_GROUP_ID = '<идентификатор_группы_безопасности>'
   YC_DP_SA_ID = '<идентификатор_сервисного_аккаунта>'
   YC_DP_METASTORE_URI = '<IP-адрес>'
   YC_DP_AZ = '{{ region-id }}-a'
   YC_SOURCE_BUCKET = 'pyspark-bucket'
   YC_DP_LOGS_BUCKET = 'log-bucket'

   # Создание подключения для {{ objstorage-name }}
   session = settings.Session()
   ycS3_connection = Connection(
       conn_id='yc-s3'
   )
   if not session.query(Connection).filter(Connection.conn_id == ycS3_connection.conn_id).first():
       session.add(ycS3_connection)
       session.commit()

   # Создание подключения для сервисного аккаунта
   ycSA_connection = Connection(
       conn_id='yc-airflow-sa'
   )
   if not session.query(Connection).filter(Connection.conn_id == ycSA_connection.conn_id).first():
       session.add(ycSA_connection)
       session.commit()

   # Настройки DAG
   with DAG(
           'DATA_INGEST',
           schedule_interval='@hourly',
           tags=['data-proc-and-airflow'],
           start_date=datetime.datetime.now(),
           max_active_runs=1,
           catchup=False
   ) as ingest_dag:

       # 1 этап: создание кластера {{ dataproc-name }}
       create_spark_cluster = DataprocCreateClusterOperator(
           task_id='dp-cluster-create-task',
           folder_id=YC_DP_FOLDER_ID,
           cluster_name=f'tmp-dp-{uuid.uuid4()}',
           cluster_description='Временный кластер для выполнения PySpark-задания под оркестрацией {{ maf-name }}',
           ssh_public_keys=YC_DP_SSH_PUBLIC_KEY,
           subnet_id=YC_DP_SUBNET_ID,
           s3_bucket=YC_DP_LOGS_BUCKET,
           service_account_id=YC_DP_SA_ID,
           zone=YC_DP_AZ,
           cluster_image_version='2.1.7',
           enable_ui_proxy=False,
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
           properties={                    # С указанием на удаленный кластер {{ metastore-name }}.
               'spark:spark.hive.metastore.uris': f'thrift://{YC_DP_METASTORE_URI}:9083',
           },
           security_group_ids=[YC_DP_GROUP_ID],
           connection_id=ycSA_connection.conn_id,
           dag=ingest_dag
       )

       # 2 этап: запуск задания PySpark
       poke_spark_processing = DataprocCreatePysparkJobOperator(
           task_id='dp-cluster-pyspark-task',
           main_python_file_uri=f's3a://{YC_SOURCE_BUCKET}/scripts/create-table.py',
           connection_id=ycSA_connection.conn_id,
           dag=ingest_dag
       )

       # 3 этап: удаление кластера {{ dataproc-name }}
       delete_spark_cluster = DataprocDeleteClusterOperator(
           task_id='dp-cluster-delete-task',
           trigger_rule=TriggerRule.ALL_DONE,
           dag=ingest_dag
       )

       # Формирование DAG из указанных выше этапов
       create_spark_cluster >> poke_spark_processing >> delete_spark_cluster
   ```

   Где:

   * `YC_DP_FOLDER_ID` — идентификатор каталога в облаке.
   * `YC_DP_SSH_PUBLIC_KEY` — открытая часть SSH-ключа для кластера {{ dataproc-name }}.
   * `YC_DP_SUBNET_ID` —  идентификатор подсети.
   * `YC_DP_GROUP_ID` — идентификатор группы безопасности.
   * `YC_DP_SA_ID` — идентификатор сервисного аккаунта.
   * `YC_DP_METASTORE_URI` — IP-адрес кластера {{ metastore-name }}.
   * `YC_DP_AZ` — зона доступности для кластера {{ dataproc-name }}, например `{{ region-id }}-a`.
   * `YC_SOURCE_BUCKET` — бакет с Python-скриптом для задания PySpark, например `pyspark-bucket`.
   * `YC_DP_LOGS_BUCKET` — бакет для логов, например `pyspark-bucket`.

   {% endcut %}

1. Загрузите DAG в кластер {{ maf-name }}: создайте в бакете `airflow-bucket` папку `dags` и загрузите в нее файл `Data-Proc-DAG.py`.
1. [Откройте веб-интерфейс {{ AF }}](../../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый DAG `DATA_INGEST` с тегом `data-proc-and-airflow`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить DAG, в строке с его именем нажмите кнопку ![image](../../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-out}

1. Чтобы отслеживать результаты выполнения задач, нажмите на название DAG. Результаты отображаются во вкладке **Grid**.
1. Дождитесь, когда все три задачи в DAG перейдут в статус **Success**. Параллельно вы можете проверить, что в [консоли управления]({{ link-console-main }}) создается кластер {{ dataproc-name }}, выполняется задание PySpark и удаляется тот же кластер.
1. Убедитесь, что в бакете `output-bucket` появилась папка `countries`, а в ней — файл `part-00000-...`. Теперь данные из созданной таблицы хранятся в бакете {{ objstorage-name }}, а метаинформация о ней — в кластере {{ metastore-name }}.
1. Проверьте, что в бакете `log-bucket` появились логи выполнения PySpark-задания.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../../iam/operations/sa/delete.md).
1. [Бакеты {{ objstorage-name }}](../../../storage/operations/buckets/delete.md).
1. [Кластер {{ metastore-name }}](../../../data-proc/operations/metastore/cluster-delete.md).
1. [Кластер {{ maf-name }}](../../../managed-airflow/operations/cluster-delete.md).
1. [Таблицу маршрутизации](../../../vpc/operations/delete-route-table.md).
1. [NAT-шлюз](../../../vpc/operations/delete-nat-gateway.md).
1. [Группу безопасности](../../../vpc/operations/security-group-delete.md).
1. [Облачные подсети](../../../vpc/operations/subnet-delete.md), созданные по умолчанию в сети `dataproc-network`.
1. [Облачную сеть](../../../vpc/operations/network-delete.md).
