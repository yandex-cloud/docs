# Поставка данных из очереди {{ KF }} в {{ PG }} с помощью {{ data-transfer-full-name }}

Вы можете настроить перенос данных из топика {{ mkf-name }} в {{ mpg-name }} с помощью сервиса {{ data-transfer-full-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер-источник {{ mkf-name }}](../../../managed-kafka/operations/cluster-create.md#create-cluster) в любой [зоне доступности](../../../overview/concepts/geo-scope.md), любой подходящей конфигурации и с публичным доступом.

        1. [Создайте в кластере-источнике топик](../../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `sensors`.

        1. [Создайте в кластере-источнике пользователя](../../../managed-kafka/operations/cluster-accounts.md#create-user) с именем `mkf-user` и правами доступа к созданному топику `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_CONSUMER`.

        1. В той же зоне доступности [создайте кластер-приемник {{ mpg-name }}](../../../managed-postgresql/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с именем пользователя-администратора `pg-user` и хостами в публичном доступе.

        1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:
            * [{{ mkf-name }}](../../../managed-kafka/operations/connect.md#configuring-security-groups).
            * [{{ mpg-name }}](../../../managed-postgresql/operations/connect.md#configuring-security-groups).

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-postgresql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/kafka-postgresql.tf).

            В этом файле описаны:

            * [сети](../../../vpc/concepts/network.md#network) и [подсети](../../../vpc/concepts/network.md#subnet) для размещения кластеров;
            * [группы безопасности](../../../vpc/concepts/security-groups.md) для подключения к кластерам;
            * кластер-источник {{ mkf-name }};
            * кластер-приемник {{ mpg-name }};
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `kafka-postgresql.tf`:

            * Версии {{ KF }} и {{ PG }}.
            * Пароли пользователей {{ KF }} и {{ PG }}.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Установите утилиты:

    * [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики {{ KF }}.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику {{ mkf-name }} через SSL](../../../managed-kafka/operations/connect.md#connection-string).

    * [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq

## Подготовьте тестовые данные {#prepare-data}

Пусть в качестве сообщения в топик {{ KF }} `sensors` кластера-источника поступают данные от сенсоров автомобиля в формате JSON.

Создайте локально файл `sample.json` с тестовыми данными:

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

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../../data-transfer/operations/endpoint/source/kafka.md) типа `{{ KF }}` и задайте для него:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}** — `sensors`.
    * Правила конвертации типа `json`. В поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}` и в открывшуюся форму скопируйте следующую спецификацию полей:

    {% cut "sensors-specification" %}

    ```json
    [
        {
            "name": "device_id",
            "type": "utf8",
            "key": true
        },
        {
            "name": "datetime",
            "type": "utf8"
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
            "type": "double"
        },
        {
            "name": "cabin_temperature",
            "type": "uint16"
        },
        {
            "name": "fuel_level",
            "type": "uint16"
        }
    ]
    ```

    {% endcut %}

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../../../data-transfer/operations/endpoint/target/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-приемника_{{ PG }}>` из выпадающего списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}** — `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}** — `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}** — `<пароль_пользователя>`.
        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - {{ TF }} {#tf}

        1. Укажите в файле `kafka-postgresql.tf` переменные:

            * `kf_source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `transfer_enabled` — значение `1` для создания эндпоинта-приемника и трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. Трансфер активируется автоматически. Дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Убедитесь, что в базу данных {{ mpg-name }} переносятся данные из топика кластера-источника {{ mkf-name }}:

1. Отправьте данные из файла `sample.json` в топик `sensors` {{ mkf-name }} с помощью утилит `jq` и `kafkacat`:

    ```bash
    jq -rc . sample.json | kafkacat -P \
        -b <FQDN_хоста-брокера>:9091 \
        -t sensors \
        -k key \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username="mkf-user" \
        -X sasl.password="<пароль_пользователя_в_кластере-источнике>" \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
    ```

    Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [{#T}](../../../managed-kafka/operations/connect.md).

1. Проверьте, что в базу данных {{ mpg-name }} перенеслись данные из кластера-источника {{ mkf-name }}:

    1. [Подключитесь к базе данных {{ mpg-name }}](../../../managed-postgresql/operations/connect.md).
    1. Проверьте, что таблица `sensors` содержит отправленные данные:

        ```sql
        SELECT * FROM sensors;
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт-источник](../../../data-transfer/operations/endpoint/index.md#delete).
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        * [Эндпоинт-приемник](../../../data-transfer/operations/endpoint/index.md#delete).
        * [{{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md).
        * [{{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `kafka-postgresql.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `kafka-postgresql.tf`, будут удалены.

    {% endlist %}
