#|
||Руководство основано на сценарии компании [Data Stories](https://data-stories.ru/) по построению аналитического стека на базе сервисов {{ yandex-cloud }}. Сценарий включал загрузку данных в хранилище, их обработку и трансформацию в единую [витрину](../glossary/datamart.md) для визуализации.
|
<br>![datastories logo](../_assets/logos/datastories_logo.png =300x)||
|#

В качестве примера используются две CSV-таблицы, которые нужно объединить в одну, импортировать в формат Parquet и передать в {{ mch-name }}.

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) с именем `dataproc-s3-sa` и назначьте ему роль `dataproc.agent`.
    1. {% include [basic-before-buckets](../_includes/data-proc/tutorials/basic-before-buckets.md) %}
    1. [Создайте облачную сеть](../vpc/operations/network-create.md) с именем `dataproc-network`.
    1. В сети `dataproc-network` [создайте подсеть](../vpc/operations/subnet-create.md) в любой зоне доступности.
    1. [Настройте NAT-шлюз](../vpc/operations/create-nat-gateway.md) для созданной подсети.
    1. В сети `dataproc-network` [создайте группу безопасности](../vpc/operations/security-group-create.md) с именем `dataproc-sg` и добавьте в нее следующие правила:

        * По одному правилу для входящего и исходящего служебного трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** / **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

        * Правило для исходящего HTTPS-трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

        * Правило для исходящего трафика по протоколу TCP на порт {{ port-mch-http }} для доступа к {{ CH }}:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mch-http }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    1. [Создайте кластер {{ dataproc-name }}](../data-proc/operations/cluster-create.md) с любой [подходящей конфигурацией хостов](../data-proc/concepts/instance-types.md) и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
            * `SPARK`;
            * `YARN`;
            * `HDFS`.
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `dataproc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — бакет, который вы создали для выходных данных.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}** — `dataproc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `dataproc-sg`.
        * Настройка **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** включена.

    1. [Создайте кластер {{ mch-name }}](../managed-clickhouse/operations/cluster-create.md) любой подходящей [конфигурации](../managed-clickhouse/concepts/instance-types.md) со следующими настройками:

        * С публичным доступом к хостам кластера.
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `user1`.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [s3-dataproc-ch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/s3-dataproc-ch.tf).

        В этом файле описаны:

        * [сеть](../vpc/concepts/network.md#network);
        * [подсеть](../vpc/concepts/network.md#subnet);
        * NAT-шлюз и таблица маршрутизации, необходимые для работы {{ dataproc-name }};
        * [группы безопасности](../vpc/concepts/security-groups.md), необходимые для кластеров {{ dataproc-name }} и {{ mch-name }};
        * сервисный аккаунт, необходимый для работы кластера {{ dataproc-name }};
        * сервисный аккаунт, необходимый для создания бакетов в {{ objstorage-name }};
        * бакеты для входных и выходных данных;
        * кластер {{ dataproc-name }};
        * кластер {{ mch-name }}.

    1. Укажите в файле `s3-dataproc-ch.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же как в настройках провайдера.
        * `input-bucket` — имя бакета для входных данных.
        * `output-bucket` — имя бакета для выходных данных.
        * `dp_ssh_key` — абсолютный путь к публичному ключу для кластера {{ dataproc-name }}. Подробнее см. в разделе [{#T}](../data-proc/operations/connect.md#data-proc-ssh).
        * `ch_password` — пароль пользователя {{ CH }}.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

Для примера используются две таблицы в формате CSV:

* `coords.csv` — содержит информацию о географических координатах автомобиля.
* `sensors.csv` — содержит информацию о скорости и рабочих параметрах автомобиля.

Чтобы подготовить тестовые данные к работе:

1. Скопируйте содержимое файлов из примеров ниже и сохраните их локально в формате CSV:

    * {% cut "coords.csv" %}
        ```csv
        vehicle_id,latitude,longitude,altitude
        iv9a94th6rztooxh5ur2,55.70329032,37.65472196,427.5
        022wsiz48h2ljxuz04x8,56.96149325,38.46541766,423.6
        a7fbbqjws4zqw85f6jue,54.99296663,36.79063999,426.2
        l7731117m6r6on4m633n,55.34740545,37.13175678,422.5
        6f9q6ienc4qfpdwd9nef,56.69752218,38.38871530,428.3
        ```
      {% endcut %}
    * {% cut "sensors.csv" %}
        ```csv
        vehicle_id,speed,battery_voltage,cabin_temperature,fuel_level
        iv9a94th6rztooxh5ur2,0.0,25.5,17,5
        022wsiz48h2ljxuz04x8,55.5,54.5,21,22
        a7fbbqjws4zqw85f6jue,80.6,22.1,19,73
        l7731117m6r6on4m633n,40.9,76.0,25,23
        6f9q6ienc4qfpdwd9nef,64.8,90.8,21,32
        ```
      {% endcut %}

1. Создайте в бакете для входных данных папку `csv` и [загрузите](../storage/operations/objects/upload.md#simple) в нее созданные CSV-файлы.

## Обработайте данные в {{ dataproc-name }} {#process-data}

Объедините данные из двух таблиц в одну и загрузите ее в формате Parquet в бакет, который вы ранее создали для результатов обработки:

1. Подготовьте файл скрипта:

    1. Создайте локально файл с именем `join-tables.py` и скопируйте в него следующий скрипт:

        {% cut "join-tables.py" %}
        ```python
        from pyspark.sql import SparkSession

        # Создание Spark-сессии
        spark = SparkSession.builder.appName("JoinExample").getOrCreate()

        # Чтение таблицы из файла coords.csv
        coords_df = spark.read.csv("s3a://<имя_входного_бакета>/csv/coords.csv", header=True)

        # Чтение таблицы из файла sensors.csv
        sensors_df = spark.read.csv("s3a://<имя_входного_бакета>/csv/sensors.csv", header=True)

        # Объединение таблицы по столбцу vehicle_id
        joined_df = coords_df.join(sensors_df, on="vehicle_id", how="inner")

        # Сохранение объединенной таблицы в бакет в формате Parquet
        joined_df.write.parquet("s3a://<имя_выходного_бакета>/parquet/")
        ```
        {% endcut %}

    1. Укажите в скрипте:

        * Имя входного бакета, в котором хранятся исходные CSV-таблицы.
        * Имя выходного бакета, в который будет сохранен Parquet-файл с объединенными данными.

    1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../storage/operations/objects/upload.md#simple) в нее файл `join-tables.py`.

1. [Создайте задание PySpark](../data-proc/operations/jobs-pyspark.md#create), указав в поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/join-tables.py`.

1. Дождитесь завершения задания и проверьте, что в выходном бакете в папке `parquet` появился Parquet-файл `part-00000-***`.

## Экспортируйте данные в {{ CH }} {#export-data}

Перенесите объединенную таблицу из {{ objstorage-name }} в {{ CH }}:

1. Подготовьте файл скрипта:

    1. Создайте локально файл с именем `parquet-to-ch.py` и скопируйте в него следующий скрипт:

        {% cut "parquet-to-ch.py" %}
        ```python
        from pyspark.sql import SparkSession

        # Создание Spark-сессии
        spark = SparkSession.builder.appName("ParquetClickhouse").getOrCreate()

        # Чтение данных из Parquet-файла
        parquetFile = spark.read.parquet("s3a://<имя_выходного_бакета>/parquet/*.parquet")

        # Указание порта и параметров кластера {{ CH }}
        jdbcPort = 8443
        jdbcHostname = "c-<идентификатор_кластера>.rw.mdb.yandexcloud.net"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Перенос таблицы из Parquet-файла в {{ CH }}-таблицу с именем measurements
        parquetFile.write.format("jdbc") \
        .mode("error") \
        .option("url", jdbcUrl) \
        .option("dbtable", "measurements") \
        .option("createTableOptions", "ENGINE = MergeTree() ORDER BY vehicle_id") \
        .option("user","user1") \
        .option("password","<пароль_пользователя_{{ CH }}>") \
        .save()
        ```
        {% endcut %}

    1. Укажите в скрипте:

        * Имя бакета, в котором лежит Parquet-файл.
        * Идентификатор кластера {{ mch-name }}.
        * Пароль пользователя {{ CH }}.

    1. [Загрузите](../storage/operations/objects/upload.md#simple) файл `parquet-to-ch.py` в бакет для входных данных в папку `scripts`.

1. [Создайте задание PySpark](../data-proc/operations/jobs-pyspark.md#create), указав в поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/parquet-to-ch.py`.
1. Дождитесь выполнения задания и убедитесь, что объединенная таблица перенесена в кластер:

    1. [Подключитесь к базе данных](../managed-clickhouse/operations/connect/clients.md) `db1` кластера {{ mch-name }} от имени пользователя `user1`.
    1. Выполните запрос:

        ```sql
        SELECT * FROM measurements;
        ```

    Если экспорт данных прошел успешно, ответом на запрос будет объединенная таблица.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Кластер {{ mch-name }}](../managed-clickhouse/operations/cluster-delete.md).
    1. [Кластер {{ dataproc-name }}](../data-proc/operations/cluster-delete.md).
    1. [Бакеты {{ objstorage-name }}](../storage/operations/buckets/delete.md).
    1. [Облачную сеть](../vpc/operations/network-delete.md).
    1. [Сервисный аккаунт](../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    1. [Удалите объекты](../storage/operations/objects/delete.md) из бакетов.
    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `s3-dataproc-ch.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `s3-dataproc-ch.tf`, будут удалены.

{% endlist %}
