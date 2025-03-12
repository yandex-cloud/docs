Вы можете сохранять данные из [кластера {{ dataproc-full-name }}](../../../data-proc/concepts/index.md) в [бакет {{ objstorage-full-name }}](../../../storage/concepts/bucket.md), используя отдельный [кластер {{ metastore-full-name }}](../../../metadata-hub/concepts/metastore.md) для хранения метаданных таблиц. Это позволит затем работать с сохраненными данными другому кластеру {{ dataproc-name }}, имеющему доступ к бакету и подключенному к тому же кластеру {{ metastore-name }}.

Чтобы настроить совместное использование таблиц двумя кластерами {{ dataproc-name }} с помощью {{ metastore-name }}:

1. [Подключите {{ dataproc-name }} к {{ metastore-name }}](#connect).
1. [Создайте тестовую таблицу](#create-table).
1. [Получите данные во втором кластере](#test-target).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Если в кластере {{ dataproc-name }} есть таблицы, которые должны быть доступны в другом кластере {{ dataproc-name }}, [перенесите таблицы](../../../data-proc/tutorials/metastore-import.md) в нужный кластер с помощью {{ metastore-name }}.

{% note warning %}

{% include [connect-metastore-to-s3-with-policy](../../_tutorials_includes/metastore-to-s3-with-policy.md) %}

{% endnote %}

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за вычислительные ресурсы кластера {{ dataproc-name }} и объем хранилища (см. [тарифы {{ dataproc-name }}](../../../data-proc/pricing.md));
* плата за хранение данных и операции с данными в бакете (см. [тарифы {{ objstorage-full-name }}](../../../storage/pricing.md));
* плата за использование NAT-шлюза и исходящий через шлюз трафик (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md#nat-gateways)).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с именем `dataproc-s3-sa` и назначьте ему роли `dataproc.agent` и `dataproc.provisioner`.
    1. {% include [basic-before-buckets](../../../_includes/data-processing/tutorials/basic-before-buckets.md) %}
    1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `dataproc-network`.
    1. В сети `dataproc-network` [создайте подсеть](../../../vpc/operations/subnet-create.md) в любой зоне доступности.
    1. [Настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) для созданной подсети.
    1. [Создайте два кластера {{ dataproc-name }}](../../../data-proc/operations/cluster-create.md) с именами `dataproc-source` и `dataproc-target`, с любой [подходящей конфигурацией хостов](../../../data-proc/concepts/instance-types.md) и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** — `PRODUCTION`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
            * `SPARK`;
            * `YARN`.
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `dataproc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_properties }}** — `spark:spark.sql.hive.metastore.sharedPrefixes` со значением `com.amazonaws,ru.yandex.cloud`. Нужно для выполнения заданий PySpark и для интеграции с {{ metastore-name }}.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — бакет, который вы создали для выходных данных.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}** — `dataproc-network`.

    1. Если в облачной сети используются [группы безопасности](../../../vpc/concepts/security-groups.md), [добавьте](../../../vpc/operations/security-group-add-rule.md) в группу безопасности кластеров {{ dataproc-name }} следующее правило для исходящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-metastore }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [dataproc-to-dataproc.tf](https://github.com/yandex-cloud-examples/yc-data-proc-to-data-proc/blob/main/dataproc-to-dataproc.tf).

        В этом файле описаны:

        * [сеть](../../../vpc/concepts/network.md#network);
        * [подсеть](../../../vpc/concepts/network.md#subnet);
        * [NAT-шлюз](../../../vpc/concepts/gateways.md) и таблица маршрутизации, необходимые для работы {{ dataproc-name }};
        * [группы безопасности](../../../vpc/concepts/security-groups.md), необходимые для кластеров {{ dataproc-name }};
        * сервисный аккаунт, необходимый для работы кластера {{ dataproc-name }};
        * сервисный аккаунт, необходимый для создания бакетов в {{ objstorage-name }};
        * бакеты для входных и выходных данных;
        * два кластера {{ dataproc-name }}.

    1. Укажите в файле `dataproc-to-dataproc.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же как в настройках провайдера.
        * `input-bucket` — имя бакета для входных данных.
        * `output-bucket` — имя бакета для выходных данных.
        * `dp_ssh_key` — абсолютный путь к публичному ключу для кластеров {{ dataproc-name }}. Подробнее см. в разделе [{#T}](../../../data-proc/operations/connect.md#data-proc-ssh).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подключите {{ dataproc-name }} к {{ metastore-name }} {#connect}

1. [Создайте кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-create.md) в сети `dataproc-network`.

1. [Добавьте в настройки кластеров](../../../data-proc/operations/cluster-update.md) {{ dataproc-name }} свойство `spark:spark.hive.metastore.uris` со значением `thrift://<IP-адрес_кластера_{{ metastore-name }}>:{{ port-metastore }}`.

   Чтобы узнать IP-адрес кластера {{ metastore-name }}, в [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** и на левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**. Для нужного кластера скопируйте значение из колонки **{{ ui-key.yacloud.metastore.field_metastore-endpoint-ip }}**.

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
            df.write.mode("overwrite").option("path","s3a://<имя_выходного_бакета>/countries").saveAsTable("countries")
            ```

            {% endcut %}

        1. Укажите в скрипте имя выходного бакета, в который будет сохранен файл с таблицей `countries`.

        1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../../../storage/operations/objects/upload.md#simple) в нее файл `create-table.py`.

    1. [Создайте задание PySpark](../../../data-proc/operations/jobs-pyspark.md#create), указав в поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/create-table.py`.

    1. Дождитесь завершения задания и проверьте, что в выходном бакете в папке `countries` появился файл `part-00000-...`.

{% endlist %}

Теперь данные из созданной таблицы хранятся в бакете {{ objstorage-name }}, а метаинформация о ней — в кластере {{ metastore-name }}. Кластер `dataproc-source` можно [удалить](../../../data-proc/operations/cluster-delete.md).

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
            df.repartition(1).write.csv(path='s3a://<имя_выходного_бакета>/csv', header=True, sep=',')
            ```

            {% endcut %}

        1. Укажите в скрипте имя выходного бакета, в который будет сохранен CSV-файл с таблицей `countries`.
        1. [Загрузите](../../../storage/operations/objects/upload.md#simple) файл `obtain-table.py` в бакет для входных данных в папку `scripts`.

    1. [Создайте задание PySpark](../../../data-proc/operations/jobs-pyspark.md#create), указав в поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/obtain-table.py`.
    1. Дождитесь выполнения задания и убедитесь, что в выходном бакете появилась папка `csv` с таблицей в формате CSV.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Удалите кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-delete.md).
1. [Удалите объекты](../../../storage/operations/objects/delete.md) из бакетов.
1. Удалите остальные ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Кластеры {{ dataproc-name }}](../../../data-proc/operations/cluster-delete.md).
        1. [Бакеты {{ objstorage-name }}](../../../storage/operations/buckets/delete.md).
        1. [Подсеть](../../../vpc/operations/subnet-delete.md).
        1. [Таблицу маршрутизации](../../../vpc/operations/delete-route-table.md).
        1. [NAT-шлюз](../../../vpc/operations/delete-nat-gateway.md).
        1. [Облачную сеть](../../../vpc/operations/network-delete.md).
        1. [Сервисный аккаунт](../../../iam/operations/sa/delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
