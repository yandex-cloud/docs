# Поставка данных из {{ mkf-full-name }} в {{ ydb-full-name }}

В кластер {{ ydb-name }} можно в реальном времени поставлять данные из топиков {{ KF }}. Эти данные будут автоматически добавлены в таблицы {{ ydb-short-name }} с именами топиков.

Чтобы запустить поставку данных:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

   {% list tabs %}

   * Вручную

       1. [Создайте кластер-источник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации.
       1. [Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.
       1. [Создайте в кластере-источнике топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `sensors`.
       1. [Создайте в кластере-источнике пользователя](../../managed-kafka/operations/cluster-accounts.md#create-user) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` к созданному топику.

   * С помощью {{ TF }}

       1. Если у вас еще нет {{ TF }}, [установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
       1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
       1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-ydb.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mkf-ydb.tf).

           В этом файле описаны:

           * [сеть](../../vpc/concepts/network.md#network);
           * [подсеть](../../vpc/concepts/network.md#subnet);
           * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру {{ mkf-name }};
           * кластер-источник {{ mkf-name }};
           * топик {{ KF }};
           * база данных {{ ydb-name }};
           * трансфер.

       1. Укажите в файле `data-transfer-mkf-ydb.tf` переменные:

           * `source_kf_version` – версия {{ KF }} в кластере-источнике;
           * `source_user_name` – имя пользователя для подключения к топику {{ KF }};
           * `source_user_password` – пароль пользователя;
           * `target_db_name` — имя базы данных {{ ydb-name }};
           * `transfer_enabled` – значение `0`, чтобы не создавать трансфер до [создания эндпоинта-приемника вручную](#prepare-transfer).

       1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
       1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

           ```bash
           terraform validate
           ```

           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

       1. Создайте необходимую инфраструктуру:

           {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

           {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

   В созданный топик {{ KF }} `sensors` кластера-источника будут поступать тестовые данные от сенсоров автомобиля в формате JSON:

   ```json
   {
       "device_id":"iv9a94th6rztooxh5ur2",
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

1. Установите утилиты:

    - [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики {{ KF }}.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику {{ mkf-name }} через SSL](../../managed-kafka/operations/connect.md#connection-string).

    - [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `YDB`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:
           * **База данных** — выберите базу данных {{ ydb-name }} из списка.
           * **ID сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `editor`.

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `{{ KF }}`.
    * **Параметры эндпоинта**:
       * **Настройки подключения** — `Кластер {{ mkf-name }}`.

          Выберите кластер-источник из списка и укажите настройки подключения к нему.
       * **Расширенные настройки** → **Правила конвертации**.
          * **Формат данных** – `JSON`.
          * **Схема данных** –  Вы можете задать схему двумя способами:
            * `Список полей`.

              Задайте список полей топика вручную:

              | Имя | Тип | Ключ |
              | :-- | :-- | :--- |
              |`device_id`|`STRING`| Да|
              |`datetime` |`STRING`|  |
              |`latitude` |`DOUBLE`|  |
              |`longitude`|`DOUBLE`|  |
              |`altitude` |`DOUBLE`|  |
              |`speed`    |`DOUBLE`|  |
              |`battery_voltage`| `DOUBLE`||
              |`cabin_temperature`| `UINT16`||
              | `fuel_level`|`UINT16`||

            * `JSON спецификация`.

              Создайте и загрузите файл схемы данных в формате JSON `json_schema.json`:

              {% cut "json_schema.json" %}

              ```json
              [
                  {
                      "name": "device_id",
                      "type": "string",
                      "key": true
                  },
                  {
                      "name": "datetime",
                      "type": "string"
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

1. Создайте трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-repl }}_, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    * С помощью {{ TF }}

        1. Укажите в файле `data-transfer-mkf-ydb.tf` переменные:

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

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Убедитесь, что в базу данных {{ ydb-name }} переносятся данные из топика кластера-источника {{ mkf-name }}:

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

    1. Отправьте данные из файла `sample.json` в топик `sensors` {{ mkf-name }} с помощью утилит `jq` и `kafkacat`:

        ```bash
        jq -rc . sample.json | kafkacat -P \
           -b <FQDN хоста-брокера>:9091 \
           -t sensors \
           -k key \
           -X security.protocol=SASL_SSL \
           -X sasl.mechanisms=SCRAM-SHA-512 \
           -X sasl.username="<имя пользователя в кластере-источнике>" \
           -X sasl.password="<пароль пользователя в кластере-источнике>" \
           -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
        ```

        Данные отправляются от имени [созданного пользователя](#prepare-source). Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [{#T}](../../managed-kafka/operations/connect.md).

    1. Убедитесь, что в базу данных {{ ydb-name }} перенеслись данные из кластера-источника {{ mkf-name }}:

        {% list tabs %}

        * Консоль управления

           1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
           1. В списке сервисов выберите **{{ ydb-name }}**.
           1. Выберите базу из списка.
           1. Перейдите на вкладку **Навигация**.
           1. Проверьте, что база данных {{ ydb-name }} содержит таблицу `sensors` с тестовыми данными из топика.

        * {{ ydb-short-name }} CLI

           1. [Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md).
           1. Проверьте, что база данных содержит таблицу `sensors` с тестовыми данными из топика:

               ```bash
               ydb table query execute \
                 --query "SELECT * \
                 FROM sensors"
               ```

        {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs %}

* Вручную

    1. [Удалите кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
    1. [Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).

* С помощью {{ TF }}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-transfer-mkf-ydb.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mkf-ydb.tf`, будут удалены.

{% endlist %}
