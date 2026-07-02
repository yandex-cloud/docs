[Документация Yandex Cloud](../../index.md) > [Yandex Data Transfer](../index.md) > [Практические руководства](index.md) > Поставка данных из очередей > Apache Kafka® в YDB

# Поставка данных из очереди Apache Kafka® в YDB

# Поставка данных очереди из Apache Kafka® в YDB


В кластер Managed Service for YDB можно в реальном времени поставлять данные из топиков Apache Kafka®. Эти данные будут автоматически добавлены в таблицы YDB с именами топиков.

Чтобы запустить поставку данных:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* База данных Managed Service for YDB ([тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

    * Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
    * Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы Data Transfer](../pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

   {% list tabs group=instructions %}

   - Вручную {#manual}


       1. [Создайте кластер-источник Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации.
       1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.
       1. [Создайте в кластере-источнике топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `sensors`.
       1. [Создайте в кластере-источнике пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` к созданному топику.

   
   - Terraform {#tf}

       1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
       1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
       1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
       1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

       1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-ydb/blob/main/data-transfer-mkf-ydb.tf).

           В этом файле описаны:

           * [сеть](../../vpc/concepts/network.md#network);
           * [подсеть](../../vpc/concepts/network.md#subnet);
           * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру Managed Service for Apache Kafka®;
           * кластер-источник Managed Service for Apache Kafka®;
           * топик Apache Kafka®;
           * пользователь Apache Kafka®;
           * база данных Managed Service for YDB;
           * сервисный аккаунт для подключения к БД Managed Service for YDB;
           * эндпоинт Apache Kafka®;
           * эндпоинт Managed Service for YDB;
           * трансфер.

       1. Укажите в файле `data-transfer-mkf-ydb.tf` переменные:

           * `folder_id` — идентификатор каталога, в котором будут созданы необходимые ресурсы;
           * `source_kf_version` – версия Apache Kafka® в кластере-источнике;
           * `source_user_name` – имя пользователя для подключения к топику Apache Kafka®;
           * `source_user_password` – пароль пользователя;
           * `target_db_name` — имя базы данных Managed Service for YDB.

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

   В созданный топик Apache Kafka® `sensors` кластера-источника будут поступать тестовые данные от сенсоров автомобиля в формате JSON:

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

1. Установите утилиты:

    - [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики Apache Kafka®.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику Managed Service for Apache Kafka® через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    - [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт для приемника](../operations/endpoint/index.md#create):

        * **Тип базы данных** — `YDB`.
        * **Параметры эндпоинта**:

            * **Настройки подключения**:
                * **База данных** — выберите базу данных Managed Service for YDB из списка.

                
                * **Идентификатор сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.


    1. [Создайте эндпоинт для источника](../operations/endpoint/index.md#create):

        * **Тип базы данных** — `Kafka`.
        * **Параметры эндпоинта**:
            * **Тип подключения** — `Кластер Managed Service for Apache Kafka`.

                Выберите кластер-источник из списка и укажите настройки подключения к нему.

            * **Расширенные настройки** → **Правила конвертации**:
                * **Формат данных** – `JSON`.
                * **Схема данных** – вы можете задать схему двумя способами:

                    * `Список полей`.

                        Задайте список полей топика вручную:

                       | Имя                 | Тип      | Ключ |
                       |:--------------------|:---------|:-----|
                       | `device_id`         | `STRING` | Да   |
                       | `datetime`          | `STRING` |      |
                       | `latitude`          | `DOUBLE` |      |
                       | `longitude`         | `DOUBLE` |      |
                       | `altitude`          | `DOUBLE` |      |
                       | `speed`             | `DOUBLE` |      |
                       | `battery_voltage`   | `DOUBLE` |      |
                       | `cabin_temperature` | `UINT16` |      |
                       | `fuel_level`        | `UINT16` |      |

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

    1. [Создайте трансфер](../operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.
    1. [Активируйте](../operations/transfer.md#activate) трансфер.


- Terraform {#tf}

    1. Укажите в файле `data-transfer-mkf-ydb.tf` значение `1` для переменной `transfer_enabled`, чтобы создать эндпоинты и трансфер.

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
1. Убедитесь, что в базу данных Managed Service for YDB переносятся данные из топика кластера-источника Managed Service for Apache Kafka®:

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

    1. Отправьте данные из файла `sample.json` в топик `sensors` Managed Service for Apache Kafka® с помощью утилит `jq` и `kafkacat`:

        ```bash
        jq -rc . sample.json | kafkacat -P \
           -b <FQDN_хоста-брокера>:9091 \
           -t sensors \
           -k key \
           -X security.protocol=SASL_SSL \
           -X sasl.mechanisms=SCRAM-SHA-512 \
           -X sasl.username="<имя_пользователя_в_кластере-источнике>" \
           -X sasl.password="<пароль_пользователя_в_кластере-источнике>" \
           -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z
        ```

        Данные отправляются от имени [созданного пользователя](#prepare-source). Подробнее о настройке SSL-сертификата и работе с `kafkacat` смотрите в разделе [Подключение к кластеру Apache Kafka® из приложений](../../managed-kafka/operations/connect/clients.md).

    1. Убедитесь, что в базу данных Managed Service for YDB перенеслись данные из кластера-источника Managed Service for Apache Kafka®:

        {% list tabs group=instructions %}

        - Консоль управления {#console}

           1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужная база данных.
           1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
           1. Выберите базу из списка.
           1. Перейдите на вкладку **Навигация**.
           1. Проверьте, что база данных Managed Service for YDB содержит таблицу `sensors` с тестовыми данными из топика.

        - YDB CLI {#cli}

           1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
           1. Проверьте, что база данных содержит таблицу `sensors` с тестовыми данными из топика:

               ```bash
               ydb table query execute \
                 --query "SELECT * \
                 FROM sensors"
               ```

        {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите трансфер](../operations/transfer.md#delete).
    1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.

    
    1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).


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