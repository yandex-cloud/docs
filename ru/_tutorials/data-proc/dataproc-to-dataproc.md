Вы можете сохранять данные из кластера {{ dataproc-name }} в бакет {{ objstorage-name }}, используя отдельный кластер [{{ metastore-name }}](../../data-proc/concepts/metastore.md) для хранения метаданных таблиц. Это позволит затем работать с сохраненными данными другому кластеру {{ dataproc-name }}, имеющему доступ к бакету и подключенному к тому же кластеру {{ metastore-name }}.

Чтобы настроить совместное использование таблиц двумя кластерами {{ dataproc-name }} с помощью {{ metastore-name }}:

1. [Подключите {{ dataproc-name }} к {{ metastore-name }}](#connect).
1. [Создайте тестовую таблицу](#create-table).
1. [Получите данные во втором кластере](#test-target).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs %}

- Вручную

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `dataproc-s3-sa` и назначьте ему роль `dataproc.agent`.
    1. {% include [basic-before-buckets](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}
    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `dataproc-network`.
    1. В сети `dataproc-network` [создайте подсеть](../../vpc/operations/subnet-create.md) в любой зоне доступности.
    1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети.
    1. [Создайте два кластера {{ dataproc-name }}](../../data-proc/operations/cluster-create.md) с именами `dataproc-source` и `dataproc-target`, с любой [подходящей конфигурацией хостов](../../data-proc/concepts/instance-types.md) и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
            * `SPARK`;
            * `YARN`.
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `dataproc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — бакет, который вы создали для выходных данных.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}** — `dataproc-network`.

    1. Если в облачной сети используются [группы безопасности](../../vpc/concepts/security-groups.md), [добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности кластеров {{ dataproc-name }} следующее правило для исходящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-metastore }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С помощью {{ TF }}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [dataproc-to-dataproc.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/dataproc-to-dataproc.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [NAT-шлюз](../../vpc/concepts/gateways.md) и таблица маршрутизации, необходимые для работы {{ dataproc-name }};
        * [группы безопасности](../../vpc/concepts/security-groups.md), необходимые для кластеров {{ dataproc-name }};
        * сервисный аккаунт, необходимый для работы кластера {{ dataproc-name }};
        * сервисный аккаунт, необходимый для создания бакетов в {{ objstorage-name }};
        * бакеты для входных и выходных данных;
        * два кластера {{ dataproc-name }}.

    1. Укажите в файле `dataproc-to-dataproc.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же как в настройках провайдера.
        * `input-bucket` — имя бакета для входных данных.
        * `output-bucket` — имя бакета для выходных данных.
        * `dp_ssh_key` — абсолютный путь к публичному ключу для кластеров {{ dataproc-name }}. Подробнее см. в разделе [{#T}](../../data-proc/operations/connect.md#data-proc-ssh).

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подключите {{ dataproc-name }} к {{ metastore-name }} {#connect}

1. [Создайте кластер {{ metastore-name }}](../../data-proc/operations/metastore/cluster-create.md) в сети `dataproc-network`.

1. [Измените настройки](../../data-proc/operations/cluster-update.md) кластеров {{ dataproc-name }}, добавив в них следующее [свойство](../../data-proc/concepts/settings-list.md):

    ```text
    spark:spark.hive.metastore.uris=thrift://<IP-адрес кластера {{ metastore-name }}>:{{ port-metastore }}
    ```

   Чтобы узнать IP-адрес кластера {{ metastore-name }}, в [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** и на левой панели выберите страницу ![image](../../_assets/data-proc/metastore.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**. IP-адрес кластера указан в блоке **{{ ui-key.yacloud.common.section-base }}**.

## Создайте тестовую таблицу {#create-table}

В кластере `dataproc-source` создайте тестовую таблицу `countries` и загрузите ее в {{ objstorage-name }}:

{% list tabs %}

- Spark

    1. Подготовьте файл скрипта:

        1. Создайте локально файл с именем `create-table.py` и скопируйте в него следующий скрипт:

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
            df.write.mode("overwrite").option("path","s3a://<имя выходного бакета>/countries").saveAsTable("countries")
            ```

            {% endcut %}

        1. Укажите в скрипте имя выходного бакета, в который будет сохранен файл с таблицей `countries`.

        1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `create-table.py`.

    1. [Создайте задание PySpark](../../data-proc/operations/jobs-pyspark.md#create), указав в поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** путь к файлу скрипта: `s3a://<имя входного бакета>/scripts/create-table.py`.

    1. Дождитесь завершения задания и проверьте, что в выходном бакете в папке `countries` появился файл `part-00000-...`.

{% endlist %}

Теперь данные из созданной таблицы хранятся в бакете {{ objstorage-name }}, а метаинформация о ней — в кластере {{ metastore-name }}. Кластер `dataproc-source` можно [удалить](../../data-proc/operations/cluster-delete.md).

## Получите данные во втором кластере {#test-target}

Загрузите метаинформацию о таблице `countries` в кластер `dataproc-target` и убедитесь, что таблица стала доступна в кластере для дальнейшей работы:

{% list tabs %}

- Spark

    1. Подготовьте файл скрипта:

        1. Создайте локально файл с именем `obtain-table.py` и скопируйте в него следующий скрипт:

            {% cut "obtain-table.py" %}

            ```python
            from pyspark.sql import SparkSession

            # Создание Spark-сессии
            spark = SparkSession.builder \
                .appName("obtain-table") \
                .enableHiveSupport() \
                .getOrCreate()

            spark.catalog.listDatabases()

            # Получение информации о таблице countries из Metastore
            df = spark.sql("describe extended countries")

            # Запрос данных из таблицы countries
            df = spark.sql("select * from countries")

            # Перенос таблицы в бакет для проверки
            df.repartition(1).write.csv(path='s3a://<имя выходного бакета>/csv', header=True, sep=',')
            ```

            {% endcut %}

        1. Укажите в скрипте имя выходного бакета, в который будет сохранен CSV-файл с таблицей `countries`.
        1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `obtain-table.py` в бакет для входных данных в папку `scripts`.

    1. [Создайте задание PySpark](../../data-proc/operations/jobs-pyspark.md#create), указав в поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** путь к файлу скрипта: `s3a://<имя входного бакета>/scripts/obtain-table.py`.
    1. Дождитесь выполнения задания и убедитесь, что в выходном бакете появилась папка `csv` с таблицей в формате CSV.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Удалите кластер {{ metastore-name }}](../../data-proc/operations/metastore/cluster-delete.md).
1. Удалите остальные ресурсы в зависимости от способа их создания:

    {% list tabs %}

    - Вручную

        1. [Кластеры {{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).
        1. [Бакеты {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
        1. [Облачную сеть](../../vpc/operations/network-delete.md).
        1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).

    - С помощью {{ TF }}

        1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакетов.
        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `dataproc-to-dataproc.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `dataproc-to-dataproc.tf`, будут удалены.

    {% endlist %}
