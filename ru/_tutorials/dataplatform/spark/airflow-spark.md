# Запуск PySpark-задания с помощью {{ maf-full-name }}

{% include [af-restriction-version](../../../_includes/mdb/maf/af-restriction-version.md) %}

С помощью кластера {{ maf-full-name }} можно автоматизировать работу с [сервисом {{ msp-full-name }}](../../../managed-spark/index.yaml), включая создание кластеров {{ msp-full-name }}, запуск заданий и другие операции. Для этого создайте DAG — [направленный ациклический граф задач](../../../managed-airflow/concepts/index.md) (DAG). Используя DAG, кластер {{ AF }} автоматически выполнит все необходимые действия по работе с {{ msp-full-name }}.

Такой подход позволяет:
* Выполнять задания по расписанию для создания отчетов и снимков данных, обслуживания, обновления метрик и т. п.
* Строить пайплайны, включающие анализ данных, эксперименты, переобучение моделей и другие задачи.
* Быстро обрабатывать большие объемы данных без необходимости платить за постоянную инфраструктуру с ресурсами большой мощности.

В этом руководстве показан пример использования простого DAG, включающего в себя:
1. Создание кластера {{ msp-full-name }}.
1. Запуск PySpark-задания: запись сообщений в лог.
1. Удаление кластера.

Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Подготовьте и запустите DAG-файл](#dag).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

Создаваемый кластер {{ msp-full-name }} не использует S3-хранилище [{{ objstorage-name }}](../../../storage/concepts/index.md) и глобальный каталог [{{ metastore-name }}](../../../metadata-hub/concepts/metastore.md). В такой конфигурации кластер {{ msp-full-name }} может работать только с данными в памяти. Для работы с постоянными базами и таблицами, а также для долговременного хранения результатов подключите внешнее хранилище {{ objstorage-name }} и, при необходимости, кластер {{ metastore-name }} для управления метаданными. Подробнее см. в руководстве [{#T}](../../../managed-spark/tutorials/airflow-automation.md).

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за вычислительные ресурсы компонентов кластера {{ maf-name }} (см. [тарифы {{ maf-full-name }}](../../../managed-airflow/pricing.md)).
* Плата за бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md)).
* Плата за сервис {{ cloud-logging-name }}: объем записываемых данных и время их хранения (см. [тарифы {{ cloud-logging-name }}](../../../logging/pricing.md)).
* Плата за вычислительные ресурсы компонентов кластера {{ msp-full-name }} (см. [тарифы {{ msp-full-name }}](../../../managed-spark/pricing.md)).


## Подготовьте инфраструктуру {#infra}

В этом руководстве используется упрощенная настройка инфраструктуры:

* один сервисный аккаунт с расширенными привилегиями,
* один бакет для хранения всех всех данных,
* группа безопасности по умолчанию.

Такая настройка подходит для тестирования, но не предоставляет достаточный для решения реальных задач уровень безопасности. Чтобы повысить безопасность решения, обеспечьте соблюдение [принципа минимальных привилегий](../../../iam/best-practices/using-iam-securely.md#restrict-access).

Подготовьте инфраструктуру:

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `integration-agent` со следующими ролями:

   * [{{ roles.maf.integrationProvider }}](../../../iam/roles-reference.md#managed-airflow-integrationProvider) — чтобы кластер {{ AF }} мог [взаимодействовать с другими ресурсами](../../../managed-airflow/concepts/impersonation.md).
   * [managed-spark.editor](../../../iam/roles-reference.md#managed-spark-editor) — чтобы управлять кластером {{ msp-full-name }} из DAG.
   * [iam.serviceAccounts.user](../../../iam/roles-reference.md#iam-serviceAccounts-user) — чтобы выбрать сервисный аккаунт `integration-agent` при создании кластера {{ msp-full-name }}.
   * [{{ roles-vpc-user }}](../../../iam/roles-reference.md#vpc-user) — чтобы использовать в кластере {{ AF }} [подсеть {{ vpc-full-name }}](../../../vpc/concepts/network.md#subnet).
   * [logging.editor](../../../iam/roles-reference.md#logging-editor) — чтобы работать с лог-группами.
   * [logging.reader](../../../iam/roles-reference.md#logging-reader) — чтобы читать логи.
   * [mdb.viewer](../../../iam/roles-reference.md#mdb-viewer) — чтобы получать статусы операций.

1. [Создайте бакет](../../../storage/operations/buckets/create.md).

1. [Предоставьте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` на бакет для сервисного аккаунта `integration-agent`.

1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `datalake-network`.

   Вместе с ней будут автоматически созданы три подсети в разных зонах доступности и группа безопасности.

1. [Создайте кластер {{ maf-name }}](../../../managed-airflow/operations/cluster-create.md) с параметрами:

   * **Сервисный аккаунт** — `integration-agent`.
   * **Зона доступности** — `{{ region-id }}-a`.
   * **Сеть** — `datalake-network`.
   * **Подсеть** — `datalake-network-{{ region-id }}-a`.
   * **Группа безопасности** — группа по умолчанию в сети `datalake-network`.
   * **Имя бакета** — имя созданного ранее бакета.

## Подготовьте PySpark-задание {#prepare-a-job}

Для PySpark-задания будет использован Python-скрипт, который:

1. Создает DataFrame с числами от 0 до 9.
1. Выводит количество строк в созданном DataFrame.
1. Выводит первые пять строк в табличном виде. 

Скрипт будет храниться в бакете {{ objstorage-name }}.

Подготовьте файл скрипта:

1. Создайте локально файл с именем `job_minimal.py` и скопируйте в него скрипт:

   ```python
   from pyspark.sql import SparkSession

   spark = (SparkSession.builder.appName("hello_spark").getOrCreate())
   
   df = spark.range(10).toDF("id")

   print("Row count:", df.count())
   df.show(5, truncate=False)
   
   spark.stop()
   ```

1. Создайте в бакете папку `scripts` и [загрузите](../../../storage/operations/objects/upload.md#simple) в нее файл `job_minimal.py`.

## Подготовьте и запустите DAG-файл {#dag}

DAG будет состоять из нескольких вершин, которые формируют цепочку последовательных действий:

1. {{ maf-name }} создает временный кластер {{ msp-full-name }} с настройками, заданными в DAG.
1. Когда кластер {{ msp-full-name }} готов, запускается задание PySpark.
1. После выполнения задания временный кластер {{ msp-full-name }} удаляется.

Чтобы подготовить DAG:

1. Создайте локально файл с именем `dag.py`, скопируйте в него скрипт и подставьте данные вашей инфраструктуры в переменные:

   {% cut "dag.py" %}

   ```python
   import logging
   import pendulum
   from airflow.models.dag import DAG
   from airflow.decorators import task
   from airflow.providers.yandex.hooks.yandex import YandexCloudBaseHook
   from airflow.exceptions import AirflowSkipException

   from yandexcloud.operations import OperationError

   # Данные вашей инфраструктуры
   FOLDER_ID = '<идентификатор_каталога>'
   SERVICE_ACCOUNT_ID = '<идентификатор_сервисного_аккаунта_integration-agent>'
   SUBNET_IDS = ['<идентификатор_подсети>']
   SECURITY_GROUP_IDS = ['<идентификатор_группы_безопасности>']

   JOB_NAME = 'job_minimal'
   JOB_SCRIPT = 's3a://<имя_бакета>/scripts/job_minimal.py'
   JOB_ARGS = []
   JOB_PROPERTIES = {
       'spark.executor.instances': '1',
   }


   @task
   # 1 этап: создание кластера {{ msp-full-name }}
   def create_cluster(yc_hook, cluster_spec):
       spark_client = yc_hook.sdk.wrappers.Spark()
       spark_client.create_cluster(cluster_spec)
       return spark_client.cluster_id


   @task
   # 2 этап: запуск задания PySpark
   def run_spark_job(yc_hook, cluster_id, job_spec):
       spark_client = yc_hook.sdk.wrappers.Spark()
       try:
           job_operation = spark_client.create_pyspark_job(cluster_id=cluster_id, spec=job_spec)
           job_id = job_operation.response.id
           job_info = job_operation.response
       except OperationError as job_error:
           job_id = job_error.operation_result.meta.job_id
           job_info, _ = spark_client.get_job(cluster_id=cluster_id, job_id=job_id)
           raise
       finally:
           job_log = spark_client.get_job_log(cluster_id=cluster_id, job_id=job_id)
           for line in job_log:
               logging.info(line)
           logging.info("Job info: %s", job_info)


   @task(trigger_rule="all_done")
   # 3 этап: удаление кластера {{ msp-full-name }}
   def delete_cluster(yc_hook, cluster_id):
       if cluster_id:
           spark_client = yc_hook.sdk.wrappers.Spark()
           spark_client.delete_cluster(cluster_id=cluster_id)
    else:
        raise AirflowSkipException("cluster_id is empty; nothing to delete")

   # Настройки DAG
   with DAG(
       dag_id="example_spark",
       start_date=pendulum.datetime(2025, 1, 1),
       schedule=None,
   ):
       yc_hook = YandexCloudBaseHook()

       cluster_spec = yc_hook.sdk.wrappers.SparkClusterParameters(
           folder_id=FOLDER_ID,
           service_account_id=SERVICE_ACCOUNT_ID,
           subnet_ids=SUBNET_IDS,
           security_group_ids=SECURITY_GROUP_IDS,
           driver_pool_resource_preset="c2-m8",
           driver_pool_size=1,
           executor_pool_resource_preset="c4-m16",
           executor_pool_min_size=1,
           executor_pool_max_size=2,
       )
       cluster_id = create_cluster(yc_hook, cluster_spec)

       job_spec = yc_hook.sdk.wrappers.PysparkJobParameters(
           name=JOB_NAME,
           main_python_file_uri=JOB_SCRIPT,
           args=JOB_ARGS,
           properties=JOB_PROPERTIES,
       )
       task_job = run_spark_job(yc_hook, cluster_id, job_spec)
       task_delete = delete_cluster(yc_hook, cluster_id)

       task_job >> task_delete
   ```

   Где:

   * `FOLDER_ID` — идентификатор каталога, в котором будет создан кластер {{ msp-full-name }}.
   * `SERVICE_ACCOUNT_ID` — идентификатор сервисного аккаунта, который будет использоваться для создания кластера {{ msp-full-name }}.
   * `SUBNET_IDS` — идентификатор подсети `datalake-network-{{ region-id }}-a`.
   * `SECURITY_GROUP_IDS` — идентификатор группы безопасности для кластера {{ msp-full-name }}.
   * `JOB_NAME` — имя задания PySpark.
   * `JOB_SCRIPT` — путь к файлу с заданием PySpark в бакете.
   * `JOB_ARGS` — аргументы задания PySpark.
   * `JOB_PROPERTIES` — свойства задания PySpark.

   {% endcut %}

1. Загрузите DAG в кластер {{ AF }}: создайте в бакете папку `dags` и загрузите в нее файл `dag.py`.
1. Откройте [веб-интерфейс {{ AF }}](../../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый DAG `example_spark`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Запустите DAG, для этого в строке с его именем нажмите кнопку ![image](../../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-out}

1. В [веб-интерфейсе {{ AF }}](../../../managed-airflow/operations/af-interfaces.md#web-gui) нажмите на название DAG `example_spark` и отслеживайте выполнение задач.
1. Дождитесь, когда все три задачи в DAG перейдут в статус **Success**. 
1. Перейдите на вкладку `Graph`.
1. В открывшемся графе нажмите на задачу `run_spark_job` и перейдите на вкладку `Logs`.
1. Проверьте, что [PySpark-задание](#prepare-a-job) выполнило корректный вывод в лог. Для этого найдите в логе строки:

   ```
   Row count: 10
   ```

   ```
   +---+
   |id |
   +---+
   |0  |
   |1  |
   |2  |
   |3  |
   |4  |
   +---+
   ```

{% note info %}

В [консоли управления]({{ link-console-main }}) вы можете следить за созданием кластера {{ msp-full-name }}, выполнением задания PySpark и удалением кластера.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../../iam/operations/sa/delete.md).
1. [Бакет {{ objstorage-name }}](../../../storage/operations/buckets/delete.md).
1. [Кластер {{ AF }}](../../../managed-airflow/operations/cluster-delete.md).
1. [Группу безопасности](../../../vpc/operations/security-group-delete.md), созданную по умолчанию в сети `datalake-network`.
1. [Облачные подсети](../../../vpc/operations/subnet-delete.md), созданные по умолчанию в сети `datalake-network`.
1. [Облачную сеть](../../../vpc/operations/network-delete.md) `datalake-network`.
