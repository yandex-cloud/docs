# Автоматизация работы с {{ msp-full-name }} с помощью {{ maf-full-name }}

В сервисе {{ maf-full-name }} можно создать DAG — [направленный ациклический граф задач](../../../managed-airflow/concepts/index.md), который позволит автоматизировать работу с [сервисом {{ msp-full-name }}](../../../managed-spark/index.yaml). Ниже рассматривается DAG, который включает в себя несколько задач:

1. Создать кластер {{ SPRK }}.
1. Запустить задание PySpark.
1. Удалить кластер {{ SPRK }}.

При таком DAG кластер существует непродолжительное время. В кластере можно задействовать ресурсы повышенной мощности и быстро обработать большее количество данных.

В этом DAG создается кластер {{ SPRK }}. Для хранения табличных метаданных в примере ниже используется [кластер {{ metastore-full-name }}](../../../metadata-hub/concepts/metastore.md). Сохраненные метаданные затем может использовать другой кластер {{ SPRK }}.

Для использования {{ msp-full-name }} в сервисе {{ maf-full-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Подготовьте и запустите DAG-файл](#dag).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ AF }}: вычислительные ресурсы компонентов кластера (см. [тарифы {{ maf-full-name }}](../../../managed-airflow/pricing.md)).
* Плата за бакеты {{ objstorage-name }}: хранение данных и выполнение операций с ними (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md)).
* Плата за получение и хранение логов (см. [тарифы {{ cloud-logging-name }}](../../../logging/pricing.md)).


## Подготовьте инфраструктуру {#infra}

В примере ниже рассматривается два сценария. Выберите наиболее подходящий:

* **Высокий уровень безопасности**. Такой сценарий рекомендуемый, так как в нем соблюдается [принцип минимальных привилегий](../../../iam/best-practices/using-iam-securely.md#restrict-access). Сценарий включает в себя следующие особенности:

   * Права доступа разделяются между сервисными аккаунтами. Для каждого кластера вы создаете отдельный сервисный аккаунт и назначаете ему роли, необходимые только для работы кластера этого аккаунта.
   * Используется несколько бакетов для разных задач, различные данные хранятся в разных бакетах. Например, DAG загружается в один бакет, а результаты выполнения PySpark-задания записываются в другой бакет.
   * Настроены группы безопасности. Вы ограничиваете трафик, и в результате доступ получают только разрешенные ресурсы.

* **Упрощенная настройка**. Предусматривает более низкий уровень безопасности:

   * Используется один сервисный аккаунт, который обладает большими привилегиями, чем необходимо.
   * Все данные хранятся только в одном бакете, но в разных папках.
   * Группы безопасности не настраиваются.

{% list tabs group=instructions %}

* Высокий уровень безопасности

  Подготовьте инфраструктуру:

  1. [Создайте сервисные аккаунты](../../../iam/operations/sa/create.md) со следующими ролями:

     #|
     || **Сервисный аккаунт** | **Его роли** ||
     || `airflow-agent` для кластера {{ AF }}. |
     * [{{ roles.maf.integrationProvider }}](../../../iam/roles-reference.md#managed-airflow-integrationProvider) — чтобы кластер {{ AF }} мог [взаимодействовать с другими ресурсами](../../../managed-airflow/concepts/impersonation.md).
     * [managed-spark.editor](../../../iam/roles-reference.md#managed-spark-editor) — чтобы управлять кластером {{ SPRK }} из DAG.
     * [iam.serviceAccounts.user](../../../iam/roles-reference.md#iam-serviceAccounts-user) — чтобы указать сервисный аккаунт `spark-agent` при создании кластера {{ SPRK }}.
     * [{{ roles-vpc-user }}](../../../iam/roles-reference.md#vpc-user) — чтобы в кластере {{ AF }} использовать [подсеть {{ vpc-full-name }}](../../../vpc/concepts/network.md#subnet).
     * [logging.editor](../../../iam/roles-reference.md#logging-editor) — чтобы работать с лог-группами.
     * [logging.reader](../../../iam/roles-reference.md#logging-reader) — чтобы читать логи.
     * [mdb.viewer](../../../iam/roles-reference.md#mdb-viewer) — чтобы получать статусы операций.
     * [{{ roles.metastore.viewer }}](../../../iam/roles-reference.md#managed-metastore-viewer) — чтобы просматривать информацию о кластерах Hive Metastore. ||
     || `metastore-agent` для кластера {{ metastore-name }}. |
     * [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider) — чтобы кластер {{ metastore-name }} мог [взаимодействовать с другими ресурсами](../../../metadata-hub/concepts/metastore-impersonation.md). ||
     || `spark-agent` для кластера {{ SPRK }}. |
     * [managed-spark.integrationProvider](../../../iam/roles-reference.md#managed-spark-integrationProvider) — чтобы кластер {{ SPRK }} мог взаимодействовать с другими ресурсами. ||
     |#

  1. [Создайте бакеты](../../../storage/operations/buckets/create.md):

     * `<бакет_для_исходного_кода_Airflow_DAG>`.
     * `<бакет_для_исходного_кода_PySpark_задания>`.
     * `<бакет_для_выходных_данных_PySpark_задания>`.

     Бакетов нужно несколько, так как на них назначаются различные права доступа.

  1. [Предоставьте разрешения](../../../storage/operations/buckets/edit-acl.md) на следующие бакеты:

     * `<бакет_для_исходного_кода_Airflow_DAG>` — разрешение `READ` для сервисного аккаунта `airflow-agent`.
     * `<бакет_для_исходного_кода_PySpark_задания>` — разрешение `READ` для сервисного аккаунта `spark-agent`.
     * `<бакет_для_выходных_данных_PySpark_задания>` — разрешение `READ и WRITE` для сервисных аккаунтов `spark-agent` и `metastore-agent`.

  1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `datalake-network`.

     Вместе с ней автоматически создадутся три подсети в разных зонах доступности.

  1. Для кластера {{ metastore-name }} [создайте группу безопасности](../../../vpc/operations/security-group-create.md) `metastore-sg` в сети `datalake-network`. Добавьте в группу следующие правила:

     * Для входящего трафика от клиентов:

        * Диапазон портов — `30000-32767`.
        * Протокол — `Любой` (`Any`).
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`.

     * Для входящего трафика от балансировщика:

        * Диапазон портов — `10256`.
        * Протокол — `Любой` (`Any`).
        * Источник — `Проверки состояния балансировщика`.

  1. Для кластера {{ AF }} создайте группу безопасности `airflow-sg` в сети `datalake-network`. Добавьте в группу следующее правило:

     * Для исходящего HTTPS-трафика:

        * Диапазон портов — `{{ port-https }}`.
        * Протокол — `TCP`.
        * Назначение — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`.

  1. Для кластера {{ SPRK }} создайте группу безопасности `spark-sg` в сети `datalake-network`. Добавьте в группу следующее правило:

     * Для исходящего трафика, чтобы разрешить подключение кластера {{ SPRK }} к {{ metastore-name }}:

        * Диапазон портов — `{{ port-metastore }}`.
        * Протокол — `Любой` (`Any`).
        * Назначение — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`.

  1. [Создайте кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-create.md) с параметрами:

     * **Сервисный аккаунт** — `metastore-agent`.
     * **Сеть** — `datalake-network`.
     * **Подсеть** — `datalake-network-{{ region-id }}-a`.
     * **Группа безопасности** — `metastore-sg`.

     {% note info %}
   
     Дождитесь завершения операции.
   
     {% endnote %}

  1. [Создайте кластер {{ maf-name }}](../../../managed-airflow/operations/cluster-create.md) с параметрами:

     * **Сервисный аккаунт** — `airflow-agent`.
     * **Зона доступности** — `{{ region-id }}-a`.
     * **Сеть** — `datalake-network`.
     * **Подсеть** — `datalake-network-{{ region-id }}-a`.
     * **Группа безопасности** — `airflow-sg`.
     * **Имя бакета** — `<бакет_для_исходного_кода_Airflow_DAG>`.

* Упрощенная настройка

  Подготовьте инфраструктуру:

  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `integration-agent` со следующими ролями:

     * [{{ roles.maf.integrationProvider }}](../../../iam/roles-reference.md#managed-airflow-integrationProvider) — чтобы кластер {{ AF }} мог [взаимодействовать с другими ресурсами](../../../managed-airflow/concepts/impersonation.md).
     * [managed-spark.editor](../../../iam/roles-reference.md#managed-spark-editor) — чтобы управлять кластером {{ SPRK }} из DAG.
     * [iam.serviceAccounts.user](../../../iam/roles-reference.md#iam-serviceAccounts-user) — чтобы указать сервисный аккаунт `spark-agent` при создании кластера {{ SPRK }}.
     * [{{ roles-vpc-user }}](../../../iam/roles-reference.md#vpc-user) — чтобы в кластере {{ AF }} использовать [подсеть {{ vpc-full-name }}](../../../vpc/concepts/network.md#subnet).
     * [logging.editor](../../../iam/roles-reference.md#logging-editor) — чтобы работать с лог-группами.
     * [logging.reader](../../../iam/roles-reference.md#logging-reader) — чтобы читать логи.
     * [mdb.viewer](../../../iam/roles-reference.md#mdb-viewer) — чтобы получать статусы операций.
     * [{{ roles.metastore.viewer }}](../../../iam/roles-reference.md#managed-metastore-viewer) — чтобы просматривать информацию о кластерах Hive Metastore.
     * [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider) — чтобы кластер {{ metastore-name }} мог [взаимодействовать с другими ресурсами](../../../metadata-hub/concepts/metastore-impersonation.md).
     * [managed-spark.integrationProvider](../../../iam/roles-reference.md#managed-spark-integrationProvider) — чтобы кластер {{ SPRK }} мог взаимодействовать с другими ресурсами. 

  1. [Создайте бакет](../../../storage/operations/buckets/create.md) `<бакет_для_заданий_и_данных>` и [предоставьте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` для сервисного аккаунта `integration-agent`.

  1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `datalake-network`.

      Вместе с ней автоматически создадутся три подсети в разных зонах доступности и группа безопасности.

  1. [Создайте кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-create.md) с параметрами:

     * **Сервисный аккаунт** — `integration-agent`.
     * **Сеть** — `datalake-network`.
     * **Подсеть** — `datalake-network-{{ region-id }}-a`.
     * **Группа безопасности** — группа по умолчанию в сети `datalake-network`.

     {% note info %}
   
     Дождитесь завершения операции.
   
     {% endnote %}

  1. [Создайте кластер {{ maf-name }}](../../../managed-airflow/operations/cluster-create.md) с параметрами:

     * **Сервисный аккаунт** — `integration-agent`.
     * **Зона доступности** — `{{ region-id }}-a`.
     * **Сеть** — `datalake-network`.
     * **Подсеть** — `datalake-network-{{ region-id }}-a`.
     * **Группа безопасности** — группа по умолчанию в сети `datalake-network`.
     * **Имя бакета** — `<бакет_для_заданий_и_данных>`.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-a-job}

Для PySpark-задания будет использован Python-скрипт, который создает таблицу и хранится в бакете {{ objstorage-name }}. Подготовьте файл скрипта:

{% list tabs group=instructions %}

* Высокий уровень безопасности

  1. Создайте локально файл с именем `job_with_table.py` и скопируйте в него скрипт:

     {% cut "job_with_table.py" %}

     {% include [pyspark](../../_tutorials_includes/spark/job-with-table-pyspark.md) %}

     { % endcut %}

  1. Создайте в бакете `<бакет_для_исходного_кода_PySpark_задания>` папку `scripts` и [загрузите](../../../storage/operations/objects/upload.md#simple) в нее файл `job_with_table.py`.

* Упрощенная настройка

  1. Создайте локально файл с именем `job_with_table.py` и скопируйте в него скрипт:

     {% cut "job_with_table.py" %}

     {% include [pyspark](../../_tutorials_includes/spark/job-with-table-pyspark.md) %}

     { % endcut %}

  1. Создайте в бакете `<бакет_для_заданий_и_данных>` папку `scripts` и [загрузите](../../../storage/operations/objects/upload.md#simple) в нее файл `job_with_table.py`.

{% endlist %}

## Подготовьте и запустите DAG-файл {#dag}

DAG будет состоять из нескольких вершин, которые формируют цепочку последовательных действий:

1. {{ maf-full-name }} создает временный кластер {{ SPRK }} с настройками, заданными в DAG. Этот кластер автоматически подключается к созданному ранее кластеру {{ metastore-name }}.
1. Когда кластер {{ SPRK }} готов, запускается задание PySpark.
1. После выполнения задания временный кластер {{ SPRK }} удаляется.

Чтобы подготовить DAG:

{% list tabs group=instructions %}

* Высокий уровень безопасности

  1. Создайте локально файл с именем `dag.py`, скопируйте в него скрипт и подставьте данные вашей инфраструктуры в переменные:

     {% cut "dag.py" %}

     ```python
     import logging
     import pendulum
     from airflow.models.dag import DAG
     from airflow.decorators import task
     from airflow.providers.yandex.hooks.yandex import YandexCloudBaseHook

     from yandexcloud.operations import OperationError


     YANDEX_CONN_ID = '<идентификатор_подключения>'

     # Данные вашей инфраструктуры
     FOLDER_ID = '<идентификатор_каталога>'
     SERVICE_ACCOUNT_ID = '<идентификатор_сервисного_аккаунта_spark-agent>'
     SUBNET_IDS = [<идентификатор_подсети>]
     SECURITY_GROUP_IDS = [<идентификатор_группы_безопасности>]
     METASTORE_CLUSTER_ID = '<идентификатор_кластера_Metastore>'

     JOB_NAME = 'job_with_table'
     JOB_SCRIPT = 's3a://<бакет_для_исходного_кода_PySpark_задания>/scripts/job_with_table.py'
     JOB_ARGS = []
     JOB_PROPERTIES = {
         'spark.executor.instances': '1',
         'spark.sql.warehouse.dir': 's3a://<бакет_для_выходных_данных_PySpark_задания>/warehouse',
     }


     @task
     # 1 этап: создание кластера {{ SPRK }}
     def create_cluster(yc_hook, cluster_spec):
         spark_client = yc_hook.sdk.wrappers.Spark()
         try:
             spark_client.create_cluster(cluster_spec)
         except OperationError as job_error:
             cluster_id = job_error.operation_result.meta.cluster_id
             if cluster_id:
                 spark_client.delete_cluster(cluster_id=cluster_id)
             raise
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
     # 3 этап: удаление кластера {{ SPRK }}
     def delete_cluster(yc_hook, cluster_id):
         if cluster_id:
             spark_client = yc_hook.sdk.wrappers.Spark()
             spark_client.delete_cluster(cluster_id=cluster_id)


     # Настройки DAG
     with DAG(
         dag_id="example_spark",
         start_date=pendulum.datetime(2025, 1, 1),
         schedule=None,
     ):
         yc_hook = YandexCloudBaseHook(yandex_conn_id=YANDEX_CONN_ID)

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
             metastore_cluster_id=METASTORE_CLUSTER_ID,
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

     * `YANDEX_CONN_ID` — идентификатор подключения.
     * `FOLDER_ID` — идентификатор каталога, в котором будет создан кластер {{ SPRK }}.
     * `SERVICE_ACCOUNT_ID` — идентификатор сервисного аккаунта, который будет использоваться для создания кластера {{ SPRK }}.
     * `SUBNET_IDS` — идентификатор подсети.

        {% note info %}
      
        Подсеть для {{ SPRK }} и {{ metastore-name }} должна совпадать.
      
        {% endnote %}

     * `SECURITY_GROUP_IDS` — идентификатор группы безопасности для кластера {{ SPRK }}.
     * `METASTORE_CLUSTER_ID` — идентификатор кластера {{ metastore-name }}.
     * `JOB_NAME` — имя задания PySpark.
     * `JOB_SCRIPT` — путь к файлу с заданием PySpark.
     * `JOB_ARGS` — аргументы задания PySpark.
     * `JOB_PROPERTIES` — свойства задания PySpark.

     { % endcut %}

  1. Загрузите DAG в кластер {{ AF }}: создайте в бакете `<бакет_для_исходного_кода_Airflow_DAG>` папку `dags` и загрузите в нее файл `dag.py`.
  1. Откройте веб-интерфейс {{ AF }}.
  1. Убедитесь, что в разделе **DAGs** появился новый DAG `example_spark`.

     Загрузка DAG-файла из бакета может занять несколько минут.

  1. Чтобы запустить DAG, в строке с его именем нажмите кнопку ![image](../../../_assets/managed-airflow/trigger-dag.png =18x).

* Упрощенная настройка

  1. Создайте локально файл с именем `dag.py`, скопируйте в него скрипт и подставьте данные вашей инфраструктуры в переменные:

     {% cut "dag.py" %}

     ```python
     import logging
     import pendulum
     from airflow.models.dag import DAG
     from airflow.decorators import task
     from airflow.providers.yandex.hooks.yandex import YandexCloudBaseHook

     from yandexcloud.operations import OperationError


     YANDEX_CONN_ID = '<идентификатор_подключения>'

     # Данные вашей инфраструктуры
     FOLDER_ID = '<идентификатор_каталога>'
     SERVICE_ACCOUNT_ID = '<идентификатор_сервисного_аккаунта_integration-agent>'
     SUBNET_IDS = [<идентификатор_подсети>]
     SECURITY_GROUP_IDS = [<идентификатор_группы_безопасности>]
     METASTORE_CLUSTER_ID = '<идентификатор_кластера_Metastore>'

     JOB_NAME = 'job_with_table'
     JOB_SCRIPT = 's3a://<бакет_для_заданий_и_данных>/scripts/job_with_table.py'
     JOB_ARGS = []
     JOB_PROPERTIES = {
         'spark.executor.instances': '1',
         'spark.sql.warehouse.dir': 's3a://<бакет_для_заданий_и_данных>/warehouse',
     }


     @task
     # 1 этап: создание кластера {{ SPRK }}
     def create_cluster(yc_hook, cluster_spec):
         spark_client = yc_hook.sdk.wrappers.Spark()
         try:
             spark_client.create_cluster(cluster_spec)
         except OperationError as job_error:
             cluster_id = job_error.operation_result.meta.cluster_id
             if cluster_id:
                 spark_client.delete_cluster(cluster_id=cluster_id)
             raise
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
     # 3 этап: удаление кластера {{ SPRK }}
     def delete_cluster(yc_hook, cluster_id):
         if cluster_id:
             spark_client = yc_hook.sdk.wrappers.Spark()
             spark_client.delete_cluster(cluster_id=cluster_id)


     # Настройки DAG
     with DAG(
         dag_id="example_spark",
         start_date=pendulum.datetime(2025, 1, 1),
         schedule=None,
     ):
         yc_hook = YandexCloudBaseHook(yandex_conn_id=YANDEX_CONN_ID)

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
             metastore_cluster_id=METASTORE_CLUSTER_ID,
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

     * `YANDEX_CONN_ID` — идентификатор подключения.
     * `FOLDER_ID` — идентификатор каталога, в котором будет создан кластер {{ SPRK }}.
     * `SERVICE_ACCOUNT_ID` — идентификатор сервисного аккаунта, который будет использоваться для создания кластера {{ SPRK }}.
     * `SUBNET_IDS` — идентификатор подсети.

        {% note info %}
      
        Подсеть для {{ SPRK }} и {{ metastore-name }} должна совпадать.
      
        {% endnote %}

     * `SECURITY_GROUP_IDS` — идентификатор группы безопасности для кластера {{ SPRK }}.
     * `METASTORE_CLUSTER_ID` — идентификатор кластера {{ metastore-name }}.
     * `JOB_NAME` — имя задания PySpark.
     * `JOB_SCRIPT` — путь к файлу с заданием PySpark.
     * `JOB_ARGS` — аргументы задания PySpark.
     * `JOB_PROPERTIES` — свойства задания PySpark.

     { % endcut %}

  1. Загрузите DAG в кластер {{ AF }}: создайте в бакете `<бакет_для_заданий_и_данных>` папку `dags` и загрузите в нее файл `dag.py`.
  1. Откройте веб-интерфейс {{ AF }}.
  1. Убедитесь, что в разделе **DAGs** появился новый DAG `example_spark`.

     Загрузка DAG-файла из бакета может занять несколько минут.

  1. Чтобы запустить DAG, в строке с его именем нажмите кнопку ![image](../../../_assets/managed-airflow/trigger-dag.png =18x).

{% endlist %}

## Проверьте результат {#check-out}

{% list tabs group=instructions %}

* Высокий уровень безопасности

  1. Чтобы отслеживать результаты выполнения задач, нажмите на название DAG.
  1. Дождитесь, когда все три задачи в DAG перейдут в статус **Success**. Параллельно вы можете проверить, что в [консоли управления]({{ link-console-main }}) создается кластер {{ SPRK }}, выполняется задание PySpark и удаляется тот же кластер.
  1. Убедитесь, что в бакете `<бакет_для_выходных_данных_PySpark_задания>` появилась БД `database_1`. Теперь данные из созданной БД хранятся в бакете {{ objstorage-name }}, а метаинформация о ней — в кластере {{ metastore-name }}.

* Упрощенная настройка

  1. Чтобы отслеживать результаты выполнения задач, нажмите на название DAG.
  1. Дождитесь, когда все три задачи в DAG перейдут в статус **Success**. Параллельно вы можете проверить, что в [консоли управления]({{ link-console-main }}) создается кластер {{ SPRK }}, выполняется задание PySpark и удаляется тот же кластер.
  1. Убедитесь, что в бакете `<бакет_для_заданий_и_данных>` появилась БД `database_1`. Теперь данные из созданной БД хранятся в бакете {{ objstorage-name }}, а метаинформация о ней — в кластере {{ metastore-name }}.

{% endlist %}
 
## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

* Высокий уровень безопасности

  1. [Сервисные аккаунты](../../../iam/operations/sa/delete.md).
  1. [Бакеты {{ objstorage-name }}](../../../storage/operations/buckets/delete.md).
  1. [Кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-delete.md).
  1. [Кластер {{ AF }}](../../../managed-airflow/operations/cluster-delete.md).
  1. [Группы безопасности](../../../vpc/operations/security-group-delete.md).
  1. [Облачные подсети](../../../vpc/operations/subnet-delete.md), созданные по умолчанию в сети `datalake-network`.
  1. [Облачную сеть](../../../vpc/operations/network-delete.md).

* Упрощенная настройка

  1. [Сервисный аккаунт](../../../iam/operations/sa/delete.md).
  1. [Бакет {{ objstorage-name }}](../../../storage/operations/buckets/delete.md).
  1. [Кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-delete.md).
  1. [Кластер {{ AF }}](../../../managed-airflow/operations/cluster-delete.md).
  1. [Группу безопасности](../../../vpc/operations/security-group-delete.md), созданную по умолчанию в сети `datalake-network`.
  1. [Облачные подсети](../../../vpc/operations/subnet-delete.md), созданные по умолчанию в сети `datalake-network`.
  1. [Облачную сеть](../../../vpc/operations/network-delete.md).

{% endlist %}

