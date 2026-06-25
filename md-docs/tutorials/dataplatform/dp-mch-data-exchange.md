# Обмен данными между Yandex Managed Service for ClickHouse® и Yandex Data Processing

# Обмен данными между Yandex Managed Service for ClickHouse® и Yandex Data Processing


С помощью Yandex Data Processing вы можете:

* [Загрузить данные из Managed Service for ClickHouse® в Spark DataFrame](#export-from-mch).
* [Выгрузить данные из Spark DataFrame в Managed Service for ClickHouse®](#import-to-mch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../data-proc/pricing.md)).
* Кластер Managed Service for ClickHouse®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Бакеты Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).

## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `dataproc-sa` и назначьте ему роли `dataproc.agent` и `dataproc.provisioner`.
    1. В Object Storage [создайте бакеты](../../storage/operations/buckets/create.md) и [настройте доступ](../../storage/operations/buckets/edit-acl.md) к ним:
       
       1. Создайте бакет для исходных данных и предоставьте сервисному аккаунту кластера разрешение `READ` для этого бакета.
       1. Создайте бакет для результатов обработки и предоставьте сервисному аккаунту кластера разрешение `READ и WRITE` для этого бакета.
    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `dataproc-network`.
    1. В сети `dataproc-network` [создайте подсеть](../../vpc/operations/subnet-create.md) в любой зоне доступности.
    1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети.
    1. Если вы используете группы безопасности, [создайте группу безопасности](../../vpc/operations/security-group-create.md) с именем `dataproc-sg` в сети `dataproc-network` и добавьте в нее следующие правила:

        * По одному правилу для входящего и исходящего служебного трафика:

            * **Диапазон портов** — `0-65535`.
            * **Протокол** — `Любой` (`Any`).
            * **Источник**/**Назначение** — `Группа безопасности`.
            * **Группа безопасности** — `Текущая` (`Self`).

        * Правило для исходящего HTTPS-трафика:

            * **Диапазон портов** — `443`.
            * **Протокол** — `TCP`.
            * **Назначение** — `CIDR`.
            * **CIDR блоки** — `0.0.0.0/0`.

        * Правило для исходящего трафика по протоколу TCP на порт 8443 для доступа к ClickHouse®:

            * **Диапазон портов** — `8443`.
            * **Протокол** — `TCP`.
            * **Назначение** — `CIDR`.
            * **CIDR блоки** — `0.0.0.0/0`.

    1. [Создайте кластер Yandex Data Processing](../../data-proc/operations/cluster-create.md) с любой [подходящей конфигурацией хостов](../../data-proc/concepts/instance-types.md) и следующими настройками:

        * Компоненты:
            * **SPARK**;
            * **YARN**;
            * **HDFS**.
        * **Сервисный аккаунт** — `dataproc-sa`.
        * **Имя бакета** — бакет, который вы создали для выходных данных.
        * **Сеть** — `dataproc-network`.
        * **Группы безопасности** — `dataproc-sg`.

    1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-clickhouse/concepts/instance-types.md) со следующими настройками:

        * С базой данных `db1`.
        * С пользователем `user1`.
        * С публичным доступом к хостам кластера.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

    
    1. Если вы используете группы безопасности в кластере Managed Service for ClickHouse®, убедитесь, что они [настроены правильно](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-proc-data-exchange-with-mch.tf](https://github.com/yandex-cloud-examples/yc-data-proc-clickhouse-data-exchange/blob/main/data-proc-data-exchange-with-mch.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * NAT-шлюз и таблица маршрутизации, необходимые для работы Yandex Data Processing;
        * [группы безопасности](../../vpc/concepts/security-groups.md), необходимые для кластеров Yandex Data Processing и Managed Service for ClickHouse®;
        * сервисный аккаунт, необходимый для работы кластера Yandex Data Processing;
        * сервисный аккаунт, необходимый для создания бакетов в Object Storage;
        * бакеты для входных и выходных данных;
        * кластер Yandex Data Processing;
        * кластер Managed Service for ClickHouse®.

    1. Укажите в файле `data-proc-data-exchange-with-mch.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же как в настройках провайдера.
        * `input_bucket` — имя бакета для входных данных.
        * `output_bucket` — имя бакета для выходных данных.
        * `dp_ssh_key` — абсолютный путь к публичному ключу для кластера Yandex Data Processing. [Подробнее о подключении к хосту Yandex Data Processing по SSH](../../data-proc/operations/connect-ssh.md).
        * `ch_password` — пароль пользователя ClickHouse®.

    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Загрузите данные из Managed Service for ClickHouse® {#export-from-mch}

### Подготовьте таблицу в кластере Managed Service for ClickHouse® {#prepare-mch}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` кластера Managed Service for ClickHouse® от имени пользователя `user1`.
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

### Перенесите таблицу из Managed Service for ClickHouse® {#start-mch-export}

1. Подготовьте файл скрипта:

    1. Создайте локальный файл с именем `ch-to-dataproc.py` и скопируйте в него следующий скрипт:

        {% cut "ch-to-dataproc.py" %}

        ```python
        from pyspark.sql import SparkSession

        # Создание Spark-сессии
        spark = SparkSession.builder.appName("ClickhouseDataproc").getOrCreate()

        # Указание порта и параметров кластера ClickHouse®
        jdbcPort = 8443
        jdbcHostname = "c-<идентификатор_кластера_ClickHouse®>.rw.mdb.yandexcloud.net"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Перенос таблицы persons из ClickHouse® в DataFrame
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

        * Идентификатор кластера Managed Service for ClickHouse®.
        * Пароль пользователя `user1`.
        * Имя выходного бакета.

    1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `ch-to-dataproc.py`.

1. [Создайте задание PySpark](../../data-proc/operations/jobs-pyspark.md#create), указав в поле **Main python файл** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/ch-to-dataproc.py`.

1. Дождитесь завершения задания и проверьте, что в папке `csv` выходного бакета появилась исходная таблица.

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [Yandex Cloud Logging](../../logging/index.md). Подробнее в разделе [Работа с логами](../../data-proc/operations/logging.md).

{% endnote %}

## Выгрузите данные в Managed Service for ClickHouse® {#import-to-mch}

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

        # Указание порта и параметров кластера ClickHouse®
        jdbcPort = 8443
        jdbcHostname = "c-<идентификатор_кластера_ClickHouse®>.rw.mdb.yandexcloud.net"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Перенос DataFrame в ClickHouse®
        df.write.format("jdbc") \
        .mode("error") \
        .option("url", jdbcUrl) \
        .option("dbtable", "people") \
        .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
        .option("user","user1") \
        .option("password","<пароль_к_базе_данных_ClickHouse®>") \
        .save()
        ```

        {% endcut %}

    1. Укажите в скрипте:

        * Идентификатор кластера Managed Service for ClickHouse®.
        * Пароль пользователя `user1`.

    1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `dataproc-to-ch.py`.

1. [Создайте задание PySpark](../../data-proc/operations/jobs-pyspark.md#create), указав в поле **Main python файл** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/dataproc-to-ch.py`.

1. Дождитесь завершения задания и проверьте, что данные перенеслись в Managed Service for ClickHouse®:

    1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` кластера Managed Service for ClickHouse® от имени пользователя `user1`.
    1. Выполните запрос:

        ```sql
        SELECT * FROM people;
        ```

    Если выгрузка прошла успешно, ответ на запрос будет содержать таблицу с данными.

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [Yandex Cloud Logging](../../logging/index.md). Подробнее в разделе [Работа с логами](../../data-proc/operations/logging.md).

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакетов. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
        1. [Кластер Yandex Data Processing](../../data-proc/operations/cluster-delete.md).
        1. [Бакеты Object Storage](../../storage/operations/buckets/delete.md).
        1. [Подсеть](../../vpc/operations/subnet-delete.md).
        1. [Таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
        1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
        1. [Облачную сеть](../../vpc/operations/network-delete.md).
        1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).

    - Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._