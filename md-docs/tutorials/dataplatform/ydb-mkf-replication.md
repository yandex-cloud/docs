# Поставка данных из Yandex Managed Service for YDB в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer

# Поставка данных из Yandex Managed Service for YDB в Yandex Managed Service for Apache Kafka®


Вы можете отслеживать изменения данных в _источнике_ Managed Service for YDB и отправлять их в _кластер-приемник_ Managed Service for Apache Kafka® с помощью технологии [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC). Эти данные будут автоматически добавлены в топики Managed Service for Apache Kafka® с именами таблиц Managed Service for YDB.

{% note info %}

В YDB CDC-режим поддерживается, начиная с версии 22.5 и выше.

{% endnote %}

Чтобы запустить поставку данных:

1. [Подготовьте источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* База данных Managed Service for YDB ([тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
  	* Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Кластер Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы Data Transfer](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

   {% list tabs group=instructions %}

   - Вручную {#manual}


       1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

       1. Если вы выбрали режим БД Dedicated, [создайте](../../vpc/operations/security-group-create.md) и [настройте](../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.

       1. [Создайте кластер-приемник Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

          {% note info %}
          
          Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
          
          {% endnote %}

       
        1. Если вы используете группы безопасности, [настройте их так, чтобы к кластеру можно было подключаться из интернета](../../managed-kafka/operations/connect/index.md#configuring-security-groups).


       1. Настройте в кластере-приемнике топики Apache Kafka®. Настройки различаются в зависимости от используемого [способа управления топиками](../../managed-kafka/concepts/topics.md#management). Имена топиков для данных формируются как `<префикс_топика>.<имя_таблицы_YDB>`. В этом руководстве в качестве примера используется префикс `cdc`.

          * Если выбрано управление топиками через стандартные интерфейсы Yandex Cloud (Консоль управления, CLI, API):

              1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `cdc.sensors`.

                 Для отслеживания изменений в нескольких таблицах создайте для каждой из них отдельный топик с префиксом `cdc`.

              1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с ролями `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` для топика `cdc.sensors`. Чтобы включить все созданные топики, укажите в имени топика `cdc.*`.

          * Если для управления топиками используется Kafka Admin API:

              1. Создайте [пользователя-администратора](../../managed-kafka/operations/cluster-accounts.md).
              1. Помимо роли `ACCESS_ROLE_ADMIN` назначьте пользователю-администратору роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` для топиков `cdc.*`, имена которых начинаются с префикса `cdc`.

                 Необходимые топики будут созданы автоматически при первом изменении в отслеживаемых таблицах кластера-источника. Такое решение может быть удобным для отслеживания изменений во множестве таблиц, однако, требует запаса свободного места в хранилище кластера. Подробнее в разделе [Хранилище в Managed Service for Apache Kafka®](../../managed-kafka/concepts/storage.md).

   - Terraform {#tf}

       1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
       1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
       1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
       1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

       1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-ydb-mkf.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-ydb-to-kafka/blob/main/data-transfer-ydb-mkf.tf).

           В этом файле описаны:

           * [сеть](../../vpc/concepts/network.md#network);
           * [подсеть](../../vpc/concepts/network.md#subnet);
           * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру Managed Service for Apache Kafka®;
           * база данных Managed Service for YDB;
           * кластер-приемник Managed Service for Apache Kafka®;
           * топик Apache Kafka®;
           * пользователь Apache Kafka®;
           * трансфер.

           Выбор [способа управления топиками](../../managed-kafka/concepts/topics.md#management) определяется переменной Terraform `kf_topics_management`. Переменная задается при выполнении команд `terraform plan` и `terraform apply` (описано далее):

           * Если управление топиками осуществляется с помощью стандартных интерфейсов Yandex Cloud (Консоль управления, CLI, API):
               1. Для отслеживания изменений в нескольких таблицах добавьте в файл конфигурации для каждой из них описание отдельного топика с префиксом `cdc`.
               1. Задайте для переменной Terraform `kf_topics_management` значение `false`.

           * Если для управления топиками используется Kafka Admin API, задайте для переменной Terraform `kf_topics_management` значение `true`.

       1. Укажите в файле `data-transfer-ydb-mkf.tf` переменные:

           * `source_db_name` — имя базы данных Managed Service for YDB;
           * `target_kf_version` – версия Apache Kafka® в кластере-приемнике;
           * `target_user_name` – имя пользователя для подключения к топику Apache Kafka®;
           * `target_user_password` – пароль пользователя;
           * `transfer_enabled` – значение `0`, чтобы не создавать трансфер до [создания эндпоинтов вручную](#prepare-transfer).

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

1. Установите утилиту [kafkacat](https://github.com/edenhill/kcat) для чтения и записи данных в топики Apache Kafka®.

    ```bash
    sudo apt update && sudo apt install --yes kafkacat
    ```

    Убедитесь, что можете с ее помощью [подключиться к кластеру-приемнику Managed Service for Apache Kafka® через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Подготовьте источник {#prepare-source}

1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
1. [Создайте YDB-таблицу](../../ydb/operations/schema.md#create-table). В качестве примера используется таблица `sensors` с информацией, поступающей от условных датчиков автомобиля.

   Добавьте в таблицу колонки вручную:

    | Имя | Тип | Первичный ключ |
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

    * **Тип базы данных** — `YDB`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:
           * **База данных** — выберите базу данных Managed Service for YDB из списка.

           
           * **Идентификатор сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `editor`.


        * **Список включенных путей** — укажите имена таблиц и директорий базы данных Managed Service for YDB для переноса.

           {% note warning %}

           Реплицируются только указанные таблицы и директории. Если не указать имен, то никакие таблицы не будут перенесены.

           {% endnote %}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):
    * **Тип базы данных** — `Kafka`.
    * **Параметры эндпоинта**:
        * **Тип подключения** — `Кластер Managed Service for Apache Kafka`.
            * **Кластер Managed Service for Apache Kafka** — выберите [созданный ранее](#before-you-begin) кластер-источник Managed Service for Apache Kafka®.
            * **Аутентификация** — укажите данные [созданного ранее](#before-you-begin) пользователя Apache Kafka®.

        * **Топик** — `Полное имя топика`.
        * **Полное имя топика** — `cdc.sensors`.

        Если необходимо отслеживать изменения в нескольких таблицах, заполните поля следующим образом:

        * **Топик** — `Префикс топика`.
        * **Префикс топика** — укажите префикс `cdc`, использованный при формировании имен топиков.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Укажите в файле `data-transfer-ydb-mkf.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

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

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **Реплицируется**.
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
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
        -Z \
        -K:
    ```

    FQDN хостов-брокеров можно получить со [списком хостов в кластере Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-hosts.md).

1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md) и [добавьте тестовые данные](../../ydb/operations/crud.md) в таблицу `sensors`:

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

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.


1. Если при создании эндпоинта для источника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).


1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).
       1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).

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