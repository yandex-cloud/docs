# Поставка данных из Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer

# Поставка данных из очереди Apache Kafka® в YDS


В поток данных Data Streams можно в реальном времени поставлять данные из топиков Apache Kafka®.

Чтобы запустить поставку данных:

1. [Создайте поток данных приемника Data Streams](#create-target-yds).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* База данных Managed Service for YDB ([тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
  	* Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Сервис Data Streams ([тарифы Data Streams](../pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.


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

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-yds/blob/main/data-transfer-mkf-ydb.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру Managed Service for Apache Kafka®;
            * кластер-источник Managed Service for Apache Kafka®;
            * топик Apache Kafka®;
            * пользователь Apache Kafka®;
            * база данных Managed Service for YDB;
            * трансфер.

        1. Укажите в файле `data-transfer-mkf-ydb.tf` переменные:

            * `source_kf_version` — версия Apache Kafka® в кластере-источнике;
            * `source_user_name` — имя пользователя для подключения к топику Apache Kafka®;
            * `source_user_password` — пароль пользователя;
            * `target_db_name` — имя базы данных Managed Service for YDB;
            * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов вручную](#prepare-transfer).

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

## Создайте поток данных приемника Data Streams {#create-target-yds}

[Создайте поток данных приемника Data Streams](../operations/aws-cli/create.md) для базы данных Managed Service for YDB.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [источника `Apache Kafka®`](../../data-transfer/operations/endpoint/source/kafka.md):

    **Параметры эндпоинта**:

    * **Тип подключения** — `Кластер Managed Service for Apache Kafka`.

        Выберите кластер-источник из списка и укажите настройки подключения к нему.

    * **Расширенные настройки** → **Правила конвертации**.

        * **Правила конвертации** – `json`.
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

            * `JSON-спецификация`.

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

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [приемника `Yandex Data Streams`](../../data-transfer/operations/endpoint/target/data-streams.md):

    **Настройки подключения**:

    * **База данных** — выберите базу данных Managed Service for YDB из списка.
    * **Поток** — укажите имя потока Data Streams.

    
    * **Идентификатор сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.


1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.

            Если в процессе трансфера вы хотите преобразовать данные, укажите в настройках трансфера нужные трансформеры:

            * [Переименование таблиц](../../data-transfer/concepts/data-transformation.md#rename-tables)
            * [Фильтр колонок](../../data-transfer/concepts/data-transformation.md#columns-filter)
            * [Маскирование данных](../../data-transfer/concepts/data-transformation.md#data-mask)
            * [Разделение на подтаблицы](../../data-transfer/concepts/data-transformation.md#subtable-splitting)
            * [Замена первичных ключей](../../data-transfer/concepts/data-transformation.md#replace-primary-key)
            * [Преобразование значений колонок в строки](../../data-transfer/concepts/data-transformation.md#convert-to-string)
            * [Шардирование](../../data-transfer/concepts/data-transformation.md#shard)
            * [Фильтр строк для APPEND-ONLY источников](../../data-transfer/concepts/data-transformation.md#append-only-sources)

        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Укажите в файле `data-transfer-mkf-ydb.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Если в процессе трансфера вы хотите преобразовать данные, добавьте в ресурс `yandex_datatransfer_transfer` блок `transformation` со списком нужных трансформеров:

            ```hcl
            resource "yandex_datatransfer_transfer" "mkf-ydb-transfer" {
              ...
              transformation {
                transformers{
                  <трансформер_1>
                }
                transformers{
                  <трансформер_2>
                }
                ...
                transformers{
                  <трансформер_N>
                }
              }
            }
            ```

            Доступны следующие типы трансформеров:

            * [Переименование таблиц](../../data-transfer/concepts/data-transformation.md#rename-tables)
            * [Фильтр колонок](../../data-transfer/concepts/data-transformation.md#columns-filter)
            * [Маскирование данных](../../data-transfer/concepts/data-transformation.md#data-mask)
            * [Разделение на подтаблицы](../../data-transfer/concepts/data-transformation.md#subtable-splitting)
            * [Замена первичных ключей](../../data-transfer/concepts/data-transformation.md#replace-primary-key)
            * [Преобразование значений колонок в строки](../../data-transfer/concepts/data-transformation.md#convert-to-string)
            * [Шардирование](../../data-transfer/concepts/data-transformation.md#shard)
            * [Фильтр строк для APPEND-ONLY источников](../../data-transfer/concepts/data-transformation.md#append-only-sources)

            Подробнее о настройке трансформеров см. в [документации провайдера Terraform](../../terraform/resources/datatransfer_transfer.md).

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
1. Убедитесь, что в поток данных Data Streams переносятся данные из топика кластера-источника Managed Service for Apache Kafka®:

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
            "device_id": "iv9a94th6r********",
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

        Данные отправляются от имени [созданного пользователя](#prepare-source). Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [Подключение к кластеру Apache Kafka® из приложений](../../managed-kafka/operations/connect/clients.md).

    Проверьте, что в поток данных Data Streams перенеслись данные из источника:
    
      {% list tabs group=instructions %}
    
      - Консоль управления {#console}
    
          1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
          1. Перейдите в сервис **Data Streams**.
          1. Выберите поток-приемник из списка и перейдите в раздел ![image](../../_assets/console-icons/bars.svg) **Просмотр данных**.
          1. Убедитесь, что в сегменте `shard-000000` появились сообщения, содержащие строки таблицы из источника. Чтобы рассмотреть сообщения подробнее, нажмите на значок ![image](../../_assets/console-icons/eye.svg).
    
      - AWS CLI {#cli}
    
          1. [Установите AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
          1. [Настройте окружение](../quickstart/index.md) для Data Streams.
          1. Прочитайте данные из потока с помощью:
    
              * [AWS CLI](../operations/aws-cli/get-records.md).
              * [AWS SDK](../operations/aws-sdk/get-records.md).
    
      {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.


1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).


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