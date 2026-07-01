# Импорт данных из Object Storage, обработка и экспорт в Yandex Managed Service for ClickHouse®

#|
||Руководство основано на сценарии компании [Data Stories](https://data-stories.ru/) по построению аналитического стека на базе сервисов Yandex Cloud. Сценарий включал загрузку данных в хранилище, их обработку и трансформацию в единую [витрину](../../glossary/datamart.md) для визуализации.
|
<br>![datastories logo](../../_assets/logos/datastories_logo.png =300x)||
|#

В качестве примера используются две CSV-таблицы, которые нужно объединить в одну, импортировать в формат Parquet и передать в Managed Service for ClickHouse®.

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for ClickHouse®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Кластер Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../data-proc/pricing.md)).
* Бакеты Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `dataproc-s3-sa` и назначьте ему роли `dataproc.agent` и `dataproc.provisioner`.
    1. В Object Storage [создайте бакеты](../operations/buckets/create.md) и [настройте доступ](../operations/buckets/edit-acl.md) к ним:
       
       1. Создайте бакет для исходных данных и предоставьте сервисному аккаунту кластера разрешение `READ` для этого бакета.
       1. Создайте бакет для результатов обработки и предоставьте сервисному аккаунту кластера разрешение `READ и WRITE` для этого бакета.
    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `dataproc-network`.
    1. В сети `dataproc-network` [создайте подсеть](../../vpc/operations/subnet-create.md) в любой зоне доступности.
    1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети.
    1. В сети `dataproc-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) с именем `dataproc-sg` и добавьте в нее следующие правила:

        * По одному правилу для входящего и исходящего служебного трафика:

            * **Диапазон портов** — `0-65535`.
            * **Протокол** — `Любой` (`Any`).
            * **Источник** / **Назначение** — `Группа безопасности`.
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

        * **Окружение** — `PRODUCTION`.
        * **Сервисы**:
            * `SPARK`;
            * `YARN`;
            * `HDFS`.
        * **Сервисный аккаунт** — `dataproc-sa`.
        * **Имя бакета** — бакет, который вы создали для выходных данных.
        * **Сеть** — `dataproc-network`.
        * **Группы безопасности** — `dataproc-sg`.
        * Настройка **UI Proxy** включена.

    1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-clickhouse/concepts/instance-types.md) со следующими настройками:

        * **Имя БД** — `db1`.
        * **Имя пользователя** — `user1`.
        * С публичным доступом к хостам кластера.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [s3-dataproc-ch.tf](https://github.com/yandex-cloud-examples/yc-data-proc-clickhouse-data-export/blob/main/s3-dataproc-ch.tf).

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

    1. Укажите в файле `s3-dataproc-ch.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же как в настройках провайдера.
        * `input-bucket` — имя бакета для входных данных.
        * `output-bucket` — имя бакета для выходных данных.
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

1. Создайте в бакете для входных данных папку `csv` и [загрузите](../operations/objects/upload.md#simple) в нее созданные CSV-файлы.

## Обработайте данные в Yandex Data Processing {#process-data}

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

    1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../operations/objects/upload.md#simple) в нее файл `join-tables.py`.

1. [Создайте задание PySpark](../../data-proc/operations/jobs-pyspark.md#create), указав в поле **Main python файл** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/join-tables.py`.

1. Дождитесь завершения задания и проверьте, что в выходном бакете в папке `parquet` появился Parquet-файл `part-00000-***`.

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [Yandex Cloud Logging](../../logging/index.md). Подробнее в разделе [Работа с логами](../../data-proc/operations/logging.md).

{% endnote %}

## Экспортируйте данные в ClickHouse® {#export-data}

Перенесите объединенную таблицу из Object Storage в ClickHouse®:

1. Подготовьте файл скрипта:

    1. Создайте локально файл с именем `parquet-to-ch.py` и скопируйте в него следующий скрипт:

        {% cut "parquet-to-ch.py" %}
        ```python
        from pyspark.sql import SparkSession

        # Создание Spark-сессии
        spark = SparkSession.builder.appName("ParquetClickhouse").getOrCreate()

        # Чтение данных из Parquet-файла
        parquetFile = spark.read.parquet("s3a://<имя_выходного_бакета>/parquet/*.parquet")

        # Указание порта и параметров кластера ClickHouse®
        jdbcPort = 8443
        jdbcHostname = "c-<идентификатор_кластера>.rw.mdb.yandexcloud.net"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Перенос таблицы из Parquet-файла в ClickHouse®-таблицу с именем measurements
        parquetFile.write.format("jdbc") \
        .mode("error") \
        .option("url", jdbcUrl) \
        .option("dbtable", "measurements") \
        .option("createTableOptions", "ENGINE = MergeTree() ORDER BY vehicle_id") \
        .option("user","user1") \
        .option("password","<пароль_пользователя_ClickHouse®>") \
        .save()
        ```
        {% endcut %}

    1. Укажите в скрипте:

        * Имя бакета, в котором лежит Parquet-файл.
        * Идентификатор кластера Managed Service for ClickHouse®.
        * Пароль пользователя ClickHouse®.

    1. [Загрузите](../operations/objects/upload.md#simple) файл `parquet-to-ch.py` в бакет для входных данных в папку `scripts`.

1. [Создайте задание PySpark](../../data-proc/operations/jobs-pyspark.md#create), указав в поле **Main python файл** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/parquet-to-ch.py`.
1. Дождитесь выполнения задания и убедитесь, что объединенная таблица перенесена в кластер:

    1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` кластера Managed Service for ClickHouse® от имени пользователя `user1`.
    1. Выполните запрос:

        ```sql
        SELECT * FROM measurements;
        ```

    Если экспорт данных прошел успешно, ответом на запрос будет объединенная таблица.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите объекты](../operations/objects/delete.md) из бакетов.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
        1. [Кластер Yandex Data Processing](../../data-proc/operations/cluster-delete.md).
        1. [Бакеты Object Storage](../operations/buckets/delete.md).
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