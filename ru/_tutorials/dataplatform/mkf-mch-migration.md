# Поставка данных из очереди {{ KF }} в {{ CH }} с помощью {{ data-transfer-full-name }}


В кластер {{ mch-name }} можно в реальном времени поставлять данные из топиков {{ KF }}. Эти данные будут автоматически вставлены в таблицы {{ CH }} на [движке `Kafka`]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

Чтобы настроить поставку данных из {{ mkf-name }} в {{ mch-name }}:

1. [Отправьте тестовые данные в топик {{ mkf-name }}](#send-sample-data-to-kf).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-kafka/concepts/instance-types.md). Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к кластеру при его создании.

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) в кластере {{ mkf-name }}.

    1. Чтобы [производитель и потребитель](../../managed-kafka/concepts/producers-consumers.md) могли работать с топиком в кластере {{ mkf-name }}, [создайте пользователей](../../managed-kafka/operations/cluster-accounts.md#create-account):

        * с ролью `ACCESS_ROLE_PRODUCER` для производителя;
        * с ролью `ACCESS_ROLE_CONSUMER` для потребителя.

    1. [Создайте кластер-приемник {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-clickhouse/concepts/instance-types.md). Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к кластеру при его создании.

    
    1. Если вы используете группы безопасности, настройте их так, чтобы к кластерам можно было подключаться из интернета:

        * [{{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups).
        * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-clickhouse/blob/main/data-transfer-mkf-mch.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластерам из интернета;
        * кластер-источник {{ mkf-name }} с описанием топика и двух пользователей, от имени которых к топику будут подключаться производитель и потребитель;
        * кластер-приемник {{ mch-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-mkf-mch.tf`:

        * параметры кластера-источника {{ mkf-name }}:

            * `source_user_producer` и `source_password_producer` — имя и пароль пользователя производителя;
            * `source_user_consumer` и `source_password_consumer` — имя и пароль пользователя потребителя;
            * `source_topic_name` — имя топика;

        * параметры кластера-приемника {{ mch-name }}, которые будут использоваться как [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

            * `target_db_name` — имя базы данных {{ mch-name }};
            * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

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

    * [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топик {{ KF }}.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластерам {{ mkf-name }} через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    * [clickhouse-client]({{ ch.docs }}/interfaces/cli/) — для подключения к базе данных в кластере {{ mch-name }}.

        1. Подключите [DEB-репозиторий]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

            ```bash
            sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
            echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
            /etc/apt/sources.list.d/clickhouse.list
            ```

        1. Установите зависимости:

            ```bash
            sudo apt update && sudo apt install --yes clickhouse-client
            ```

        1. Загрузите файл конфигурации для `clickhouse-client`:

            {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

        Убедитесь, что можете с ее помощью [подключиться к кластеру {{ mch-name }} через SSL](../../managed-clickhouse/operations/connect/clients.md).

    * [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Отправьте тестовые данные в топик {{ mkf-name }} {#send-sample-data-to-kf}

Пусть в топик {{ KF }} поступают данные от сенсоров автомобиля. Эти данные будут передаваться в виде сообщений {{ KF }} в формате JSON:

```json
{
    "device_id":"iv9a94th6rzt********",
    "datetime":"2020-06-05 17:27:00",
    "latitude":"55.70329032",
    "longitude":"37.65472196",
    "altitude":"427.5",
    "speed":"0",
    "battery_voltage":"23.5",
    "cabin_temperature":"17",
    "fuel_level":null
}
```

Кластер {{ mch-name }} будет использовать [формат данных JSONEachRow]({{ ch.docs }}/interfaces/formats/#jsoneachrow) при вставке в таблицы на движке `Kafka`. Этот формат преобразует строки из сообщения {{ KF }} в нужные значения столбцов.

1. Создайте файл `sample.json` с тестовыми данными:

    {% cut "sample.json" %}

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

    {% endcut %}

1. Отправьте данные из файла `sample.json` в топик {{ mkf-name }} с помощью `jq` и `kafkacat`:

    ```bash
    jq -rc . sample.json | kafkacat -P \
       -b <FQDN_хоста-брокера>:9091 \
       -t <имя_топика> \
       -k key \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username="<имя_пользователя_для_производителя>" \
       -X sasl.password="<пароль_пользователя_для_производителя>" \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file-root }} -Z
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Kafka`.
    * **Параметры эндпойнта** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.connection.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}** — выберите кластер-источник из списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.user.title }}** — укажите имя пользователя потребителя.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.password.title }}** — укажите пароль пользователя потребителя.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}** — укажите имя топика в кластере {{ mkf-name }}.

        * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.advanced_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}** — `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`:

                Создайте и загрузите файл схемы данных в формате JSON `json_schema.json`:

                {% cut "json_schema.json" %}

                ```json
                [
                    {
                        "name": "device_id",
                        "type": "string"
                    },
                    {
                        "name": "datetime",
                        "type": "datetime"
                    },
                    {
                        "name": "latitude",
                        "type": "double"
                    },
                    {
                        "name": "longitude",
                        "type": "double"
                    },
                    {
                        "name": "altitude",
                        "type": "double"
                    },
                    {
                        "name": "speed",
                        "type": "double"
                    },
                    {
                        "name": "battery_voltage",
                        "type": "any"
                    },
                    {
                        "name": "cabin_temperature",
                        "type": "double"
                    },
                    {
                        "name": "fuel_level",
                        "type": "any"
                    }
                ]
                ```

                {% endcut %}

1. Создайте эндпоинт для приемника и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
            * **Параметры эндпойнта**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.connection.title }}**:

                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.

                        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}** — выберите кластер-приемник из списка.

                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных.
                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}** — укажите имя и пароль пользователя с доступом к базе, например, владельца базы данных.

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.advanced_settings.title }}** → **Загружать данные в формате JSON** — включите эту опцию, если в расширенных настройках эндпоинта источника включили опцию **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}**.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. Раскомментируйте в файле `data-transfer-mkf-mch.tf`:

            * переменную `source_endpoint_id` и задайте ей значение идентификатора эндпоинта для источника, созданного на предыдущем шаге;
            * ресурсы `yandex_datatransfer_endpoint` и `yandex_datatransfer_transfer`.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Убедитесь, что в базу данных {{ mch-name }} перенеслись данные из кластера-источника {{ mkf-name }}:

    1. [Подключитесь к кластеру](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью `clickhouse-client`.

    1. Выполните запрос:

        ```sql
        SELECT * FROM <имя_базы_данных_{{ CH }}>.<имя_топика_Apache_Kafka>
        ```

1. Измените значения в файле `sample.json` и отправьте данные из него в топик {{ mkf-name }}:

    ```bash
    jq -rc . sample.json | kafkacat -P \
       -b <FQDN_хоста-брокера>:9091 \
       -t <имя_топика> \
       -k key \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username="<имя_пользователя_для_производителя>" \
       -X sasl.password="<пароль_пользователя_для_производителя>" \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file-root }} -Z
    ```

1. Убедитесь, что в базе данных {{ mch-name }} отобразились новые значения:

    1. [Подключитесь к кластеру](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью `clickhouse-client`.

    1. Выполните запрос:

        ```sql
        SELECT * FROM <имя_базы_данных_{{ CH }}>.<имя_топика_Apache_Kafka>
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
    * [Удалите кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
    * [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).

- {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-transfer-mkf-mch.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mkf-mch.tf`, будут удалены.

{% endlist %}
