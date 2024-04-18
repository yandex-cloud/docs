# Поставка данных из {{ mkf-full-name }} в {{ ydb-full-name }}


Вы можете отслеживать изменения данных в _источнике_ {{ ydb-name }} и отправлять их в _кластер-приемник_ {{ mkf-name }} с помощью технологии [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC). Эти данные будут автоматически добавлены в топики {{ mkf-short-name }} с именами таблиц {{ ydb-name }}.

{% include [CDC-YDB](../../_includes/data-transfer/note-ydb-cdc.md) %}

Чтобы запустить поставку данных:

1. [Подготовьте источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

       1. Если вы выбрали режим БД {{ dd }}, [создайте](../../vpc/operations/security-group-create.md) и [настройте](../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.

       1. [Создайте кластер-приемник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

       
        1. Если вы используете группы безопасности, [настройте их так, чтобы к кластеру можно было подключаться из интернета](../../managed-kafka/operations/connect/index.md#configuring-security-groups).


       1. Настройте в кластере-приемнике топики {{ KF }}. Настройки различаются в зависимости от используемого [способа управления топиками](../../managed-kafka/concepts/topics.md#management). Имена топиков для данных формируются как `<префикс_топика>.<имя_таблицы_{{ ydb-short-name}}>`. В этом руководстве в качестве примера используется префикс `cdc`.

          * Если выбрано управление топиками через стандартные интерфейсы {{ yandex-cloud }} (Консоль управления, CLI, API):

              1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `cdc.sensors`.

                 Для отслеживания изменений в нескольких таблицах создайте для каждой из них отдельный топик с префиксом `cdc`.

              1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-user) с ролями `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` для топика `cdc.sensors`. Чтобы включить все созданные топики, укажите в имени топика `cdc.*`.

          * Если для управления топиками используется Kafka Admin API:

              1. Создайте [пользователя-администратора](../../managed-kafka/operations/cluster-accounts.md).
              1. Помимо роли `ACCESS_ROLE_ADMIN` назначьте пользователю-администратору роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` для топиков `cdc.*`, имена которых начинаются с префикса `cdc`.

                 Необходимые топики будут созданы автоматически при первом изменении в отслеживаемых таблицах кластера-источника. Такое решение может быть удобным для отслеживания изменений во множестве таблиц, однако, требует запаса свободного места в хранилище кластера. Подробнее см. в разделе [{#T}](../../managed-kafka/concepts/storage.md).

          {% endlist %}

   - {{ TF }} {#tf}

       1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
       1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
       1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
       1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

       1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-ydb-mkf.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-ydb-to-kafka/blob/main/data-transfer-ydb-mkf.tf).

           В этом файле описаны:

           * [сеть](../../vpc/concepts/network.md#network);
           * [подсеть](../../vpc/concepts/network.md#subnet);
           * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру {{ mkf-name }};
           * база данных {{ ydb-name }};
           * кластер-приемник {{ mkf-name }};
           * топик {{ KF }};
           * пользователь {{ KF }};
           * трансфер.

           Выбор [способа управления топиками](../../managed-kafka/concepts/topics.md#management) определяется переменной {{ TF }} `kf_topics_management`. Переменная задается при выполнении команд `terraform plan` и `terraform apply` (см. далее):

           * Если управление топиками осуществляется с помощью стандартных интерфейсов {{ yandex-cloud }} (Консоль управления, CLI, API):
               1. Для отслеживания изменений в нескольких таблицах добавьте в файл конфигурации для каждой из них описание отдельного топика с префиксом `cdc`.
               1. Задайте для переменной {{ TF }} `kf_topics_management` значение `false`.

           * Если для управления топиками используется Kafka Admin API, задайте для переменной {{ TF }} `kf_topics_management` значение `true`.

       1. Укажите в файле `data-transfer-ydb-mkf.tf` переменные:

           * `source_db_name` — имя базы данных {{ ydb-name }};
           * `target_kf_version` – версия {{ KF }} в кластере-приемнике;
           * `target_user_name` – имя пользователя для подключения к топику {{ KF }};
           * `target_user_password` – пароль пользователя;
           * `transfer_enabled` – значение `0`, чтобы не создавать трансфер до [создания эндпоинтов вручную](#prepare-transfer).

       1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

           ```bash
           terraform validate
           ```

           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

       1. Создайте необходимую инфраструктуру:

           {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

           {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. Установите утилиту [kafkacat](https://github.com/edenhill/kcat) для чтения и записи данных в топики {{ KF }}.

    ```bash
    sudo apt update && sudo apt install --yes kafkacat
    ```

    Убедитесь, что можете с ее помощью [подключиться к кластеру-приемнику {{ mkf-name }} через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Подготовьте источник {#prepare-source}

1. [Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md).
1. [Создайте {{ ydb-short-name }}-таблицу](../../ydb/operations/schema.md#create-table). В качестве примера используется таблица `sensors` с информацией, поступающей от условных датчиков автомобиля.

   Добавьте в таблицу колонки вручную:

    | {{ ui-key.yacloud.ydb.browse.info.column_name }} | {{ ui-key.yacloud.ydb.browse.info.column_type }} | {{ ui-key.yacloud.ydb.browse.dialogs.tooltip_create_pk }} |
    |:--------------------|:---------|:---------------|
    | `device_id`         | `String` | Да             |
    | `datetime`          | `String` |                |
    | `latitude`          | `Double` |                |
    | `longitude`         | `Double` |                |
    | `altitude`          | `Double` |                |
    | `speed`             | `Double` |                |
    | `battery_voltage`   | `Double` |                |
    | `cabin_temperature` | `Uint8`  |                |
    | `fuel_level`        | `Uint32` |                |

    Остальные настройки оставьте по умолчанию.

    Также создать таблицу можно YQL-командой:

    ```sql
    CREATE TABLE sensors (
        device_id String,
        datetime String,
        latitude Double,
        longitude Double,
        altitude Double,
        speed Double,
        battery_voltage Double,
        cabin_temperature Uint8,
        fuel_level Uint32,
        PRIMARY KEY (device_id)
    )
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-YDB }}`.
    * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите базу данных {{ ydb-name }} из списка.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `editor`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}** — укажите имена таблиц и директорий базы данных {{ ydb-name }} для переноса.

           {% note warning %}

           Реплицируются только указанные таблицы и директории. Если не указать имен, то никакие таблицы не будут перенесены.

           {% endnote %}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):
    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-KAFKA }}`.
    * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}** — выберите [созданный ранее](#before-you-begin) кластер-источник {{ mkf-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}** — укажите данные [созданного ранее](#before-you-begin) пользователя {{ KF }}.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}** — `cdc.sensors`.

        Если необходимо отслеживать изменения в нескольких таблицах, заполните поля следующим образом:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}** — укажите префикс `cdc`, использованный при формировании имен топиков.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. Укажите в файле `data-transfer-ydb-mkf.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

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
1. В отдельном терминале запустите утилиту `kafkacat` в режиме потребителя:

    ```bash
    kafkacat \
        -C \
        -b <FQDN_хоста-брокера_1>:9091,...,<FQDN_хоста-брокера_N>:9091 \
        -t cdc.sensors \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=kafka-user \
        -X sasl.password=<пароль> \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
        -Z \
        -K:
    ```

    FQDN хостов-брокеров можно получить со [списком хостов в кластере {{ mkf-name }}](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

1. [Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md) и [добавьте тестовые данные](../../ydb/operations/crud.md) в таблицу `sensors`:

    ```sql
    REPLACE INTO sensors (device_id, datetime, latitude, longitude, altitude, speed, battery_voltage, cabin_temperature, fuel_level) VALUES 
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196, 427.5, 0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th6rzt********', '2022-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, NULL, 20.5, 15, 20);
    ```

1. Убедитесь, что в терминале с запущенной утилитой `kafkacat` отобразились схема формата данных таблицы `sensors` и сведения о добавленных строках.

    {% cut "Пример фрагмента сообщения" %}

    ```json
    {
      "payload": {
          "device_id": "aXY5YTk0dGg2cnp0b294********"
        },
        "schema": {
          "fields": [
            {
                "field": "device_id",
                "optional": false,
                "type": "bytes"
            }
          ],
          "name": "cdc..sensors.Key",
          "optional": false,
          "type": "struct"
        }
    }: {
      "payload": {
        "after": {
            "altitude": 378,
            "battery_voltage": 20.5,
            "cabin_temperature": 15,
            "datetime": "MjAyMi0wNi0wOCAxNzo0********",
            "device_id": "aXY5YTk0dGg2cnp0b294********",
            "fuel_level": 20,
            "latitude": 53.70987913,
            "longitude": 36.62549834,
            "speed": null
        },
        "before": null,
        "op": "c",
        "source": {
            "db": "",
            "name": "cdc",
            "snapshot": "false",
            "table": "sensors",
            "ts_ms": 1678642104797,
            "version": "1.1.2.Final"
        },
        "transaction": null,
        "ts_ms": 1678642104797
      },
      "schema": {
        "fields": [
            {
                "field": "before",
                "fields": [
                    {
                        "field": "device_id",
                        "optional": false,
                        "type": "bytes"
                    },
                    ...
                ],
                "name": "cdc..sensors.Value",
                "optional": true,
                "type": "struct"
            },
            {
                "field": "after",
                "fields": [
                    {
                        "field": "device_id",
                        "optional": false,
                        "type": "bytes"
                    },
                    ...
                ],
                "name": "cdc..sensors.Value",
                "optional": true,
                "type": "struct"
            },
            {
                "field": "source",
                "fields": [
                    {
                        "field": "version",
                        "optional": false,
                        "type": "string"
                    },
                    {
                        "field": "connector",
                        "optional": false,
                        "type": "string"
                    },
                    {
                        "field": "name",
                        "optional": false,
                        "type": "string"
                    },
                    {
                        "field": "ts_ms",
                        "optional": false,
                        "type": "int64"
                    },
                    {
                        "default": "false",
                        "field": "snapshot",
                        "name": "io.debezium.data.Enum",
                        "optional": true,
                        "parameters": {
                            "allowed": "true,last,false"
                        },
                        "type": "string",
                        "version": 1
                    },
                    {
                        "field": "db",
                        "optional": false,
                        "type": "string"
                    },
                    {
                        "field": "table",
                        "optional": false,
                        "type": "string"
                    }
                ],
                "optional": false,
                "type": "struct"
            },
            ...,
            {
                "field": "transaction",
                "fields": [
                    {
                        "field": "id",
                        "optional": false,
                        "type": "string"
                    },
                    {
                        "field": "total_order",
                        "optional": false,
                        "type": "int64"
                    },
                    {
                        "field": "data_collection_order",
                        "optional": false,
                        "type": "int64"
                    }
                ],
                "optional": true,
                "type": "struct"
            }
        ],
        "name": "cdc..sensors.Envelope",
        "optional": false,
        "type": "struct"
      }
    }
    ```

    {% endcut %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. Если при создании эндпоинта для источника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
    1. [Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-transfer-ydb-mkf.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mkf-ydb.tf`, будут удалены.

{% endlist %}
