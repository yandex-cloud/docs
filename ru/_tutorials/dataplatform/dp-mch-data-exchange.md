# Обмен данными между {{ mch-full-name }} и {{ dataproc-full-name }}


С помощью {{ dataproc-name }} вы можете:

* [Загрузить данные из {{ mch-name }} в Spark DataFrame](#export-from-mch).
* [Выгрузить данные из Spark DataFrame в {{ mch-name }}](#import-to-mch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `dataproc-sa` и назначьте ему роль `dataproc.agent`.
    1. {% include [basic-before-buckets](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}
    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `dataproc-network`.
    1. В сети `dataproc-network` [создайте подсеть](../../vpc/operations/subnet-create.md) в любой зоне доступности.
    1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети.
    1. Если вы используете группы безопасности, [создайте группу безопасности](../../vpc/operations/security-group-create.md) с именем `dataproc-sg` в сети `dataproc-network` и добавьте в нее следующие правила:

        * По одному правилу для входящего и исходящего служебного трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-security-group }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

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

    1. [Создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md) с любой [подходящей конфигурацией хостов](../../data-proc/concepts/instance-types.md) и следующими настройками:

        * Компоненты:
            * **SPARK**;
            * **YARN**;
            * **HDFS**.
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `dataproc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — бакет, который вы создали для выходных данных.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}** — `dataproc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `dataproc-sg`.

    1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-clickhouse/concepts/instance-types.md) со следующими настройками:

        * С публичным доступом к хостам кластера.
        * С базой данных `db1`.
        * С пользователем `user1`.

    
    1. Если вы используете группы безопасности в кластере {{ mch-name }}, убедитесь, что они [настроены правильно](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-proc-data-exchange-with-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-proc-data-exchange-with-mch.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * NAT-шлюз и таблица маршрутизации, необходимые для работы {{ dataproc-name }};
        * [группы безопасности](../../vpc/concepts/security-groups.md), необходимые для кластеров {{ dataproc-name }} и {{ mch-name }};
        * сервисный аккаунт, необходимый для работы кластера {{ dataproc-name }};
        * сервисный аккаунт, необходимый для создания бакетов в {{ objstorage-name }};
        * бакеты для входных и выходных данных;
        * кластер {{ dataproc-name }};
        * кластер {{ mch-name }}.

    1. Укажите в файле `data-proc-data-exchange-with-mch.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же как в настройках провайдера.
        * `input_bucket` — имя бакета для входных данных.
        * `output_bucket` — имя бакета для выходных данных.
        * `dp_ssh_key` — абсолютный путь к публичному ключу для кластера {{ dataproc-name }}. Подробнее см. в разделе [{#T}](../../data-proc/operations/connect.md#data-proc-ssh).
        * `ch_password` — пароль пользователя {{ CH }}.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Загрузите данные из {{ mch-name }} {#export-from-mch}

### Подготовьте таблицу в кластере {{ mch-name }} {#prepare-mch}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` кластера {{ mch-name }} от имени пользователя `user1`.
1. Наполните базу тестовыми данными. В качестве примера используется простая таблица с именами и возрастом людей.

    1. Создайте таблицу:

        ```sql
        CREATE TABLE persons (
            `name` String,
            `age` UInt8) ENGINE = MergeTree ()
        ORDER BY
            `name`;
        ```

    1. Наполните таблицу данными:

        ```sql
        INSERT INTO persons VALUES
           ('Anna', 19),
           ('Michael', 65),
           ('Alvar', 28),
           ('Lilith', 50),
           ('Max', 27),
           ('Jaimey', 34),
           ('Dmitry', 42),
           ('Qiang', 19),
           ('Augustyna', 20),
           ('Maria', 28);
        ```

    1. Проверьте результат:

        ```sql
        SELECT * FROM persons;
        ```

### Перенесите таблицу из {{ mch-name }} {#start-mch-export}

1. Подготовьте файл скрипта:

    1. Создайте локальный файл с именем `ch-to-dataproc.py` и скопируйте в него следующий скрипт:

        {% cut "ch-to-dataproc.py" %}

        ```python
        from pyspark.sql import SparkSession

        # Создание Spark-сессии
        spark = SparkSession.builder.appName("ClickhouseDataproc").getOrCreate()

        # Указание порта и параметров кластера {{ CH }}
        jdbcPort = 8443
        jdbcHostname = "c-<идентификатор_кластера_{{ CH }}>.rw.mdb.yandexcloud.net"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Перенос таблицы persons из {{ CH }} в DataFrame
        df = spark.read.format("jdbc") \
        .option("url", jdbcUrl) \
        .option("user","user1") \
        .option("password","<пароль_пользователя_user1>") \
        .option("dbtable","persons") \
        .load()

        # Перенос DataFrame в бакет для проверки
        df.repartition(1).write.mode("overwrite") \
        .csv(path='s3a://<имя_выходного_бакета>/csv', header=True, sep=',')
        ```

        {% endcut %}

    1. Укажите в скрипте:

        * Идентификатор кластера {{ mch-name }}.
        * Пароль пользователя `user1`.
        * Имя выходного бакета.

    1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `ch-to-dataproc.py`.

1. [Создайте задание PySpark](../../data-proc/operations/jobs-pyspark.md#create), указав в поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/ch-to-dataproc.py`.

1. Дождитесь завершения задания и проверьте, что в папке `csv` выходного бакета появилась исходная таблица.

## Выгрузите данные в {{ mch-name }} {#import-to-mch}

1. Подготовьте файл скрипта:

    1. Создайте локальный файл с именем `dataproc-to-ch.py` и скопируйте в него следующий скрипт:

        {% cut "dataproc-to-ch.py" %}

        ```python
        from pyspark.sql import SparkSession
        from pyspark.sql.types import *

        # Создание Spark-сессии
        spark = SparkSession.builder.appName("DataprocClickhouse").getOrCreate()

        # Создание схемы данных
        schema = StructType([StructField('name', StringType(), True),
        StructField('age', IntegerType(), True)])

        # Создание DataFrame
        df = spark.createDataFrame([('Alim', 19),
                                    ('Fred' ,65),
                                    ('Guanmin' , 28),
                                    ('Till', 60),
                                    ('Almagul', 27),
                                    ('Mary', 34),
                                    ('Dmitry', 42)], schema)

        # Указание порта и параметров кластера {{ CH }}
        jdbcPort = 8443
        jdbcHostname = "c-<идентификатор_кластера_{{ CH }}>.rw.mdb.yandexcloud.net"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Перенос DataFrame в {{ CH }}
        df.write.format("jdbc") \
        .mode("error") \
        .option("url", jdbcUrl) \
        .option("dbtable", "people") \
        .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
        .option("user","user1") \
        .option("password","<пароль_к_базе_данных_{{ CH }}>") \
        .save()
        ```

        {% endcut %}

    1. Укажите в скрипте:

        * Идентификатор кластера {{ mch-name }}.
        * Пароль пользователя `user1`.

    1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `dataproc-to-ch.py`.

1. [Создайте задание PySpark](../../data-proc/operations/jobs-pyspark.md#create), указав в поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/dataproc-to-ch.py`.

1. Дождитесь завершения задания и проверьте, что данные перенеслись в {{ mch-name }}:

    1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` кластера {{ mch-name }} от имени пользователя `user1`.
    1. Выполните запрос:

        ```sql
        SELECT * FROM people;
        ```

    Если выгрузка прошла успешно, ответ на запрос будет содержать таблицу с данными.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).
    1. [Кластер {{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).
    1. [Бакеты {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
    1. [Облачную сеть](../../vpc/operations/network-delete.md).
    1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакетов.
    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-proc-data-exchange-with-mch.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-proc-data-exchange-with-mch.tf`, будут удалены.

{% endlist %}
