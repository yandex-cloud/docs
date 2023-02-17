В кластер {{ mch-name }} можно в реальном времени поставлять данные из топиков {{ KF }}. Эти данные будут автоматически вставлены в таблицы {{ CH }} на [движке `Kafka`]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

Чтобы настроить поставку данных из {{ mkf-name }} в {{ mch-name }}:

1. [Настройте интеграцию с {{ KF }} для кластера {{ mch-name }}](#configure-mch-for-kf).
1. [Создайте в кластере {{ mch-name }} таблицы на движке Kafka](#create-kf-table).
1. [Отправьте тестовые данные в топики {{ mkf-name }}](#send-sample-data-to-kf).
1. [Проверьте наличие тестовых данных в таблицах кластера {{ mch-name }}](#fetch-sample-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

    1. [Создайте необходимое количество кластеров {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей вам [конфигурации](../../managed-kafka/concepts/instance-types.md). Для подключения к кластерам с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к кластерам при их создании.

    1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) с одним шардом и базой данных `db1`. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к кластеру при его создании.

        {% note info %}

        Интеграцию с {{ KF }} можно настроить уже на этапе [создания кластера](../../managed-clickhouse/operations/cluster-create.md). В этом практическом руководстве интеграция будет настроена [позже](#configure-mch-for-kf).

        {% endnote %}

    1. [Создайте необходимое количество топиков](../../managed-kafka/operations/cluster-topics.md#create-topic) в кластерах {{ mkf-name }}. Имена топиков не должны повторяться.

    1. Чтобы [производитель и потребитель](../../managed-kafka/concepts/producers-consumers.md) могли работать с топиками, [создайте](../../managed-kafka/operations/cluster-accounts.md#create-account) в каждом кластере {{ mkf-name }} по два пользователя:

        - пользователь с ролью `ACCESS_ROLE_PRODUCER` для производителя;
        - пользователь с ролью `ACCESS_ROLE_CONSUMER` для потребителя.

        Имена пользователей в разных кластерах могут быть одинаковыми.

- С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [data-from-kafka-to-clickhouse.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-from-kafka-to-clickhouse/data-from-kafka-to-clickhouse.tf).

        В этом файле описаны:

        * Сеть.
        * Подсеть.
        * Группа безопасности по умолчанию и правила, необходимые для подключения к кластерам из интернета.
        * Кластер {{ mkf-name }} с описанием одного топика и двух пользователей, от имени которых к топику будут подключаться производитель и потребитель, соответственно. Для создания нескольких топиков или кластеров продублируйте блоки с их описанием и укажите новые уникальные имена. Имена пользователей в разных кластерах могут быть одинаковыми.
        * Кластер {{ mch-name }} с одним шардом и базой данных `db1`.

    1. Укажите в файле `data-from-kafka-to-clickhouse.tf`:

        * имена и пароли пользователей с ролями `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_CONSUMER` кластеров {{ mkf-name }};
        * имена топиков кластеров {{ mkf-name }};
        * имя пользователя и пароль, которые будут использоваться для доступа к кластеру {{ mch-name }}.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

       ```bash
       terraform validate
       ```

       Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Выполните дополнительные настройки {#additional-settings}

1. Установите утилиты:

    - [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики {{ KF }}.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластерам {{ mkf-name }} через SSL](../../managed-kafka/operations/connect.md#connection-string).

    - [clickhouse-client]({{ ch.docs }}/interfaces/cli/) — для подключения к базе данных в кластере {{ mch-name }}.

        1. Подключите [DEB-репозиторий]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

            ```bash
            sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
            echo "deb https://repo.{{ ch-domain }}/deb/stable/ main/" | sudo tee \
            /etc/apt/sources.list.d/clickhouse.list
            ```

        1. Установите зависимости:

            ```bash
            sudo apt update && sudo apt install --yes clickhouse-client
            ```

        1. Загрузите файл конфигурации для `clickhouse-client`:

            ```bash
            mkdir --parents ~/.clickhouse-client && wget "https://{{ s3-storage-host }}/mdb/clickhouse-client.conf.example" \
                --output-document ~/.clickhouse-client/config.xml
            ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру {{ mch-name }} через SSL](../../managed-clickhouse/operations/connect.md#connection-string).

    - [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Настройте интеграцию с {{ KF }} для кластера {{ mch-name }} {#configure-mch-for-kf}

{% list tabs %}

- Вручную

    В зависимости от количества кластеров {{ mkf-name }}:

    - Если кластер {{ KF }} один, [укажите данные для аутентификации](../../managed-clickhouse/operations/update.md#change-clickhouse-config) в секции **Настройки СУБД** → **Kafka**. В этом случае кластер {{ mch-name }} будет использовать эти данные для аутентификации при обращении к любому топику.
    - Если кластеров {{ KF }} несколько, укажите данные для аутентификации каждого топика {{ mkf-name }} в [настройках кластера {{ mch-name }}](../../managed-clickhouse/operations/update.md#change-clickhouse-config) в секции **Настройки СУБД** → **Kafka topics**.

    Данные для аутентификации:

    - **Name** — имя топика (для нескольких кластеров {{ KF }}).
    - **Sasl mechanism** — `SCRAM-SHA-512`.
    - **Sasl password** — [пароль пользователя для потребителя](#before-you-begin).
    - **Sasl username** — [имя пользователя для потребителя](#before-you-begin).
    - **Security protocol** — `SASL_SSL`.

- С помощью {{ TF }}

    1. В зависимости от количества кластеров {{ mkf-name }}:

        - Если кластер {{ KF }} один, укажите данные для аутентификации в блоке `clickhouse.config.kafka`:

            ```hcl
            resource "yandex_mdb_clickhouse_cluster" "clickhouse-cluster" {
            clickhouse {
                ...
                config {
                kafka {
                    security_protocol = "SECURITY_PROTOCOL_SASL_SSL"
                    sasl_mechanism    = "SASL_MECHANISM_SCRAM_SHA_512"
                    sasl_username     = "<имя пользователя для потребителя>"
                    sasl_password     = "<пароль пользователя для потребителя>"
                }
                }
            }
            }
            ```

        - Если кластеров {{ KF }} несколько, укажите данные для аутентификации каждого топика {{ mkf-name }} в блоке `clickhouse.config.kafka_topic`:

            ```hcl
            resource "yandex_mdb_clickhouse_cluster" "clickhouse-cluster" {
            clickhouse {
                ...
                config {
                kafka_topic {
                    name = "<имя топика>"
                    settings {
                    security_protocol = "SECURITY_PROTOCOL_SASL_SSL"
                    sasl_mechanism    = "SASL_MECHANISM_SCRAM_SHA_512"
                    sasl_username     = "<имя пользователя для потребителя>"
                    sasl_password     = "<пароль пользователя для потребителя>"
                    }
                }
                ...
                }
            }
            }
            ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Создайте в кластере {{ mch-name }} таблицы на движке Kafka {#create-kf-table}

Пусть в топики {{ KF }} поступают данные от сенсоров автомобиля в формате JSON:

- строковый идентификатор устройства `device_id`;
- дата и время формирования данных `datetime` в формате `YYYY-MM-DD HH:MM:SS`;
- координаты автомобиля:

    - широта `latitude`;
    - долгота `longitude`;
    - высота над уровнем моря `altitude`;

- текущая скорость `speed`;
- напряжение батарей `battery_voltage` (для электромобиля, для автомобиля с ДВС значение этого параметра — `null`);
- температура в салоне `cabin_temperature`;
- уровень топлива `fuel_level` (для автомобиля с ДВС, для электромобиля значение этого параметра — `null`).

Эти данные будут передаваться в виде сообщений {{ KF }}, каждое из которых будет содержать строчку вида:

```json
{"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

Кластер {{ mch-name }} будет использовать при вставке в таблицы на движке `Kafka` [формат данных JSONEachRow]({{ ch.docs }}/interfaces/formats/#jsoneachrow), который преобразует строки из сообщения {{ KF }} в нужные значения столбцов.

Для каждого из топиков {{ KF }} создайте в кластере {{ mch-name }} отдельную таблицу, куда будут заноситься поступающие данные:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.
1. Выполните запрос:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.<имя таблицы для топика>
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
        kafka_broker_list = '<FQDN хоста-брокера>:9091',
        kafka_topic_list = '<имя топика>',
        kafka_group_name = 'sample_group',
        kafka_format = 'JSONEachRow';
    ```

Созданные таблицы будут автоматически наполняться сообщениями, считываемыми из топиков {{ mkf-name }}. При чтении данных {{ mch-name }} использует [указанные ранее настройки](#configure-mch-for-kf) для [пользователей с ролью `ACCESS_ROLE_CONSUMER`](#before-you-begin).

Подробнее о создании таблиц на движке `Kafka` см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

## Отправьте тестовые данные в топики {{ mkf-name }} {#send-sample-data-to-kf}

1. Создайте файл `sample.json` с тестовыми данными:

    ```json
    {
        "device_id": "iv9a94th6rztooxh5ur2",
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
        "device_id": "rhibbh3y08qmz3sdbrbu",
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
        "device_id": "iv9a94th6rztooxh5ur2",
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

1. Отправьте данные из файла `sample.json` в каждый топик {{ mkf-name }} с помощью `jq` и `kafkacat`:

    ```bash
    jq -rc . sample.json | kafkacat -P \
       -b <FQDN хоста-брокера>:9091 \
       -t <имя топика> \
       -k key \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username="<имя пользователя для производителя>" \
       -X sasl.password="<пароль пользователя для производителя>" \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
    ```

Данные отправляются от имени пользователей [с ролью `ACCESS_ROLE_PRODUCER`](#before-you-begin). Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [{#T}](../../managed-kafka/operations/connect.md).

## Проверьте наличие тестовых данных в таблицах кластера {{ mch-name }} {#fetch-sample-data}

Для доступа к данным используйте материализованное представление. Когда к таблице на движке `Kafka` присоединяется материализованное представление, оно начинает в фоновом режиме собирать данные. Это позволяет непрерывно получать сообщения от {{ KF }} и преобразовывать их в необходимый формат с помощью `SELECT`.

{% note info %}

Сообщение из топика может быть прочитано {{ CH }} только один раз, поэтому не рекомендуется считывать данные из таблицы напрямую.

{% endnote %}

Чтобы создать такое представление:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.
1. Для каждой таблицы на движке `Kafka` выполните запросы:

    ```sql
    CREATE TABLE db1.temp_<имя таблицы для топика>
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
    CREATE MATERIALIZED VIEW db1.<имя представления> TO db1.temp_<имя таблицы для топика>
        AS SELECT * FROM db1.<имя таблицы для топика>;
    ```

Чтобы получить все данные из нужного материализованного представления:

1. [Подключитесь](../../managed-clickhouse/operations/connect.md#connection-string) к базе данных `db1` кластера {{ mch-name }} с помощью `clickhouse-client`.
1. Выполните запрос:

    ```sql
    SELECT * FROM db1.<имя представления>;
    ```

Запрос вернет таблицу с данными, отправленными в соответствующий топик {{ mkf-name }}.

Подробнее о работе с данными, поставляемыми из {{ KF }}, см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

{% list tabs %}

- Вручную

    - Удалите кластеры:

        - [{{ mch-full-name }}](../../managed-clickhouse/operations/cluster-delete.md);
        - [{{ mkf-full-name }}](../../managed-kafka/operations/cluster-delete.md).

    
    - Если вы зарезервировали для кластеров публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).


- С помощью {{ TF }}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-from-kafka-to-clickhouse.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-from-kafka-to-clickhouse.tf`, будут удалены.

{% endlist %}
