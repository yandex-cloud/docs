[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Практические руководства](index.md) > Получение данных из Managed Service for Apache Kafka®

# Получение данных из Managed Service for Apache Kafka® в Managed Service for ClickHouse®

В кластер Managed Service for ClickHouse® можно в реальном времени поставлять данные из топиков Apache Kafka®. Эти данные будут автоматически вставлены в таблицы ClickHouse® на [движке `Kafka`](https://clickhouse.com/docs/ru/engines/table-engines/integrations/kafka).

Чтобы настроить поставку данных из Managed Service for Apache Kafka® в Managed Service for ClickHouse®:

1. [Настройте интеграцию с Apache Kafka® для кластера Managed Service for ClickHouse®](#configure-mch-for-kf).
1. [Создайте в кластере Managed Service for ClickHouse® таблицы на движке Kafka](#create-kf-table).
1. [Отправьте тестовые данные в топики Managed Service for Apache Kafka®](#send-sample-data-to-kf).
1. [Проверьте наличие тестовых данных в таблицах кластера Managed Service for ClickHouse®](#fetch-sample-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note warning %}

В руководстве используется однохостовый кластер ClickHouse®. Если в вашем кластере больше одного хоста ClickHouse®, в SQL-запросах, представленных ниже, используйте [распределенный запрос](https://clickhouse.com/docs/ru/sql-reference/statements/create/table) с подстановкой имени кластера: `CREATE ... ON CLUSTER '{cluster}'`. Также в запросах, где указан табличный движок `MergeTree`, используйте вместо него `ReplicatedMergeTree`.

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластеры Managed Service for Apache Kafka®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства ([тарифы Apache Kafka®](../../managed-kafka/pricing.md)).
* Плата за кластер Managed Service for ClickHouse®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства ([тарифы Managed Service for ClickHouse®](../pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластеров включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте необходимое количество кластеров Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md) любой подходящей вам [конфигурации](../../managed-kafka/concepts/instance-types.md). Для подключения к кластерам с локальной машины пользователя, а не из облачной сети Yandex Cloud, включите публичный доступ к кластерам при их создании.

    1. [Создайте кластер Managed Service for ClickHouse®](../operations/cluster-create.md) с одним шардом и базой данных `db1`. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети Yandex Cloud, включите публичный доступ к кластеру при его создании.

        {% note info %}

        Интеграцию с Apache Kafka® можно настроить уже на этапе [создания кластера](../operations/cluster-create.md). В этом практическом руководстве интеграция будет настроена [позже](#configure-mch-for-kf).

        {% endnote %}

    
    1. Если вы используете группы безопасности, настройте их так, чтобы к кластерам можно было подключаться из интернета:

        * [Инструкция для Managed Service for Apache Kafka®](../../managed-kafka/operations/connect/index.md#configuring-security-groups).
        * [Инструкция для Managed Service for ClickHouse®](../operations/connect/index.md#configuring-security-groups).


    1. [Создайте необходимое количество топиков](../../managed-kafka/operations/cluster-topics.md#create-topic) в кластерах Managed Service for Apache Kafka®. Имена топиков не должны повторяться.

    1. Чтобы [производитель и потребитель](../../managed-kafka/concepts/producers-consumers.md) могли работать с топиками, [создайте](../../managed-kafka/operations/cluster-accounts.md#create-account) в каждом кластере Managed Service for Apache Kafka® по два пользователя:

        - пользователь с ролью `ACCESS_ROLE_PRODUCER` для производителя;
        - пользователь с ролью `ACCESS_ROLE_CONSUMER` для потребителя.

        Имена пользователей в разных кластерах могут быть одинаковыми.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-from-kafka-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-fetch-data-from-kafka/blob/main/data-from-kafka-to-clickhouse.tf).

        В этом файле описаны:

        * Сеть.
        * Подсеть.
        * Группа безопасности по умолчанию и правила, необходимые для подключения к кластерам из интернета.
        * Кластер Managed Service for Apache Kafka®.
        * Топик и два пользователя Managed Service for Apache Kafka®, от имени которых к топику будут подключаться производитель и потребитель, соответственно.

            Для создания нескольких топиков или кластеров продублируйте блоки с их описанием и укажите новые уникальные имена. Имена пользователей в разных кластерах могут быть одинаковыми.

        * Кластер Managed Service for ClickHouse® с одним шардом и базой данных `db1`.

    1. Укажите в файле `data-from-kafka-to-clickhouse.tf`:

        * версию Managed Service for Apache Kafka®;
        * имена и пароли пользователей с ролями `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_CONSUMER` кластеров Managed Service for Apache Kafka®;
        * имена топиков кластеров Managed Service for Apache Kafka®;
        * имя пользователя и пароль, которые будут использоваться для доступа к кластеру Managed Service for ClickHouse®.

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

### Выполните дополнительные настройки {#additional-settings}

1. Установите утилиты:

    - [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики Apache Kafka®.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластерам Managed Service for Apache Kafka® через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    - [clickhouse-client](https://clickhouse.com/docs/ru/interfaces/cli) — для подключения к базе данных в кластере Managed Service for ClickHouse®.

        1. Подключите [DEB-репозиторий](https://clickhouse.com/docs/ru/install#install-from-deb-packages) ClickHouse®:

            ```bash
            sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
            echo "deb https://packages.clickhouse.com/deb stable main" | sudo tee \
            /etc/apt/sources.list.d/clickhouse.list
            ```

        1. Установите зависимости:

            ```bash
            sudo apt update && sudo apt install --yes clickhouse-client
            ```

        1. Загрузите файл конфигурации для `clickhouse-client`:

            ```bash
            mkdir -p ~/.clickhouse-client && \
            wget "https://storage.yandexcloud.net/doc-files/clickhouse-client.conf.example" \
              --output-document ~/.clickhouse-client/config.xml
            ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру Managed Service for ClickHouse® через SSL](../operations/connect/clients.md).

    - [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Настройте интеграцию с Apache Kafka® для кластера Managed Service for ClickHouse® {#configure-mch-for-kf}

В зависимости от количества кластеров Managed Service for Apache Kafka®:

* Если кластер Apache Kafka® один:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       Укажите данные для аутентификации в [настройках ClickHouse®](../operations/change-server-level-settings.md#yandex-cloud-interfaces) в секции **Настройки СУБД** → **Kafka**. В этом случае кластер Managed Service for ClickHouse® будет использовать эти данные для аутентификации при обращении к любому топику.

       Данные для аутентификации:

       * **Sasl mechanism** — `SCRAM-SHA-512`.
       * **Sasl password** — [пароль пользователя для потребителя](#before-you-begin).
       * **Sasl username** — [имя пользователя для потребителя](#before-you-begin).
       * **Security protocol** — `SASL_SSL`.

   - Terraform {#tf}

       1. Раскомментируйте в файле `data-from-kafka-to-clickhouse.tf` блок `clickhouse.config.kafka`:

            ```hcl
            config = {
                kafka = {
                    security_protocol = "SECURITY_PROTOCOL_SASL_SSL"
                    sasl_mechanism    = "SASL_MECHANISM_SCRAM_SHA_512"
                    sasl_username     = "<имя_пользователя_для_потребителя>"
                    sasl_password     = "<пароль_пользователя_для_потребителя>"
                }
            }
            ```

       1. Проверьте корректность настроек.

           1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
           1. Выполните команду:
           
              ```bash
              terraform validate
              ```
           
              Если в файлах конфигурации есть ошибки, Terraform на них укажет.

       1. Подтвердите изменение ресурсов.

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

   {% endlist %}

* Если кластеров Apache Kafka® несколько, создайте нужное количество [именованных коллекций](https://clickhouse.com/docs/ru/operations/named-collections) с данными для аутентификации каждого топика Managed Service for Apache Kafka®:

   1. [Подключитесь](../operations/connect/clients.md#clickhouse-client) к базе данных `db1` кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.

   1. Выполните следующий запрос нужное количество раз, указав данные для аутентификации каждого топика:

       ```sql
       CREATE NAMED COLLECTION <имя_коллекции> AS
           kafka_broker_list = '<FQDN_хоста-брокера>:9091',
           kafka_topic_list = '<имя_топика>',
           kafka_group_name = 'sample_group',
           kafka_format = 'JSONEachRow'
           kafka_security_protocol = 'SASL_SSL',
           kafka_sasl_mechanism = 'SCRAM-SHA-512',
           kafka_sasl_username = '<имя_пользователя_для_потребителя>',
           kafka_sasl_password = '<пароль_пользователя_для_потребителя>';
       ```

## Создайте в кластере Managed Service for ClickHouse® таблицы на движке Kafka {#create-kf-table}

Пусть в топики Apache Kafka® поступают некоторые данные от сенсоров автомобиля в формате JSON. Эти данные будут передаваться в виде сообщений Apache Kafka®, каждое из которых будет содержать строчку вида:

```json
{"device_id":"iv9a94th6rzt********","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

Кластер Managed Service for ClickHouse® будет использовать при вставке в таблицы на движке `Kafka` [формат данных JSONEachRow](https://clickhouse.com/docs/ru/interfaces/formats#jsoneachrow), который преобразует строки из сообщения Apache Kafka® в нужные значения столбцов.

Для каждого из топиков Apache Kafka® создайте в кластере Managed Service for ClickHouse® отдельную таблицу, куда будут заноситься поступающие данные:

1. [Подключитесь](../operations/connect/clients.md#clickhouse-client) к базе данных `db1` кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.
1. Выполните запрос:

    {% list tabs group=instructions %}

    - Один кластер Apache Kafka®

        ```sql
        CREATE TABLE IF NOT EXISTS db1.<имя_таблицы_для_топика>
        (
            device_id String,
            datetime DateTime,
            latitude Float32,
            longitude Float32,
            altitude Float32,
            speed Float32,
            battery_voltage Nullable(Float32),
            cabin_temperature Float32,
            fuel_level Nullable(Float32)
        ) ENGINE = Kafka()
        SETTINGS
            kafka_broker_list = '<FQDN_хоста-брокера>:9091',
            kafka_topic_list = '<имя_топика>',
            kafka_group_name = 'sample_group',
            kafka_format = 'JSONEachRow';
        ```

    - Несколько кластеров Apache Kafka®

        ```sql
        CREATE TABLE IF NOT EXISTS db1.<имя_таблицы_для_топика>
        (
            device_id String,
            datetime DateTime,
            latitude Float32,
            longitude Float32,
            altitude Float32,
            speed Float32,
            battery_voltage Nullable(Float32),
            cabin_temperature Float32,
            fuel_level Nullable(Float32)
        ) ENGINE = Kafka(<имя_коллекции_с_данными_аутентификации>);
        ```

    {% endlist %}

Созданные таблицы будут автоматически наполняться сообщениями, считываемыми из топиков Managed Service for Apache Kafka®. При чтении данных Managed Service for ClickHouse® использует [указанные ранее настройки](#configure-mch-for-kf) для [пользователей с ролью `ACCESS_ROLE_CONSUMER`](#before-you-begin).

Подробнее о создании таблиц на движке `Kafka` смотрите в [документации ClickHouse®](https://clickhouse.com/docs/ru/engines/table-engines/integrations/kafka).

## Отправьте тестовые данные в топики Managed Service for Apache Kafka® {#send-sample-data-to-kf}

1. Создайте файл `sample.json` с тестовыми данными:

    ```json
    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-05 17:27:00",
        "latitude": 55.70329032,
        "longitude": 37.65472196,
        "altitude": 427.5,
        "speed": 0,
        "battery_voltage": 23.5,
        "cabin_temperature": 17,
        "fuel_level": null
    }

    {
        "device_id": "rhibbh3y08qm********",
        "datetime": "2020-06-06 09:49:54",
        "latitude": 55.71294467,
        "longitude": 37.66542005,
        "altitude": 429.13,
        "speed": 55.5,
        "battery_voltage": null,
        "cabin_temperature": 18,
        "fuel_level": 32
    }

    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-07 15:00:10",
        "latitude": 55.70985913,
        "longitude": 37.62141918,
        "altitude": 417.0,
        "speed": 15.7,
        "battery_voltage": 10.3,
        "cabin_temperature": 17,
        "fuel_level": null
    }
    ```

1. Отправьте данные из файла `sample.json` в каждый топик Managed Service for Apache Kafka® с помощью `jq` и `kafkacat`:

    ```bash
    jq -rc . sample.json | kafkacat -P \
       -b <FQDN_хоста-брокера>:9091 \
       -t <имя_топика> \
       -k key \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username="<имя_пользователя_для_производителя>" \
       -X sasl.password="<пароль_пользователя_для_производителя>" \
       -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/RootCA.crt -Z
    ```

Данные отправляются от имени пользователей [с ролью `ACCESS_ROLE_PRODUCER`](#before-you-begin). Подробнее о настройке SSL-сертификата и работе с `kafkacat` смотрите в разделе [Подключение к кластеру Apache Kafka® из приложений](../../managed-kafka/operations/connect/clients.md).

## Проверьте наличие тестовых данных в таблицах кластера Managed Service for ClickHouse® {#fetch-sample-data}

Для доступа к данным используйте материализованное представление. Когда к таблице на движке `Kafka` присоединяется материализованное представление, оно начинает в фоновом режиме собирать данные. Это позволяет непрерывно получать сообщения от Apache Kafka® и преобразовывать их в необходимый формат с помощью `SELECT`.

{% note info %}

Сообщение из топика может быть прочитано ClickHouse® только один раз, поэтому не рекомендуется считывать данные из таблицы напрямую.

{% endnote %}

Чтобы создать такое представление:

1. [Подключитесь](../operations/connect/clients.md#clickhouse-client) к базе данных `db1` кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.
1. Для каждой таблицы на движке `Kafka` выполните запросы:

    ```sql
    CREATE TABLE db1.temp_<имя_таблицы_для_топика>
    (
        device_id String,
        datetime DateTime,
        latitude Float32,
        longitude Float32,
        altitude Float32,
        speed Float32,
        battery_voltage Nullable(Float32),
        cabin_temperature Float32,
        fuel_level Nullable(Float32)
    ) ENGINE = MergeTree()
    ORDER BY device_id;
    ```

    ```sql
    CREATE MATERIALIZED VIEW db1.<имя_представления> TO db1.temp_<имя_таблицы_для_топика>
        AS SELECT * FROM db1.<имя_таблицы_для_топика>;
    ```

Чтобы получить все данные из нужного материализованного представления:

1. [Подключитесь](../operations/connect/clients.md#clickhouse-client) к базе данных `db1` кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.
1. Выполните запрос:

    ```sql
    SELECT * FROM db1.<имя_представления>;
    ```

Запрос вернет таблицу с данными, отправленными в соответствующий топик Managed Service for Apache Kafka®.

Подробнее о работе с данными, поставляемыми из Apache Kafka®, смотрите в [документации ClickHouse®](https://clickhouse.com/docs/ru/engines/table-engines/integrations/kafka).

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    - Удалите кластеры:

        - [Yandex Managed Service for ClickHouse®](../operations/cluster-delete.md);
        - [Yandex Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).

    
    - Если вы зарезервировали для кластеров публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).


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