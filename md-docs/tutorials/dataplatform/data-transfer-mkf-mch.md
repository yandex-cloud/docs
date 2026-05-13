# Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer

# Поставка данных из очереди Apache Kafka® в ClickHouse® с помощью Yandex Data Transfer


В кластер Managed Service for ClickHouse® можно в реальном времени поставлять данные из топиков Apache Kafka®. Эти данные будут автоматически вставлены в таблицы ClickHouse® на [движке `Kafka`](https://clickhouse.com/docs/ru/engines/table-engines/integrations/kafka/).

Чтобы настроить поставку данных из Managed Service for Apache Kafka® в Managed Service for ClickHouse®:

1. [Отправьте тестовые данные в топик Managed Service for Apache Kafka®](#send-sample-data-to-kf).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Кластер Managed Service for ClickHouse®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте кластер-источник Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-kafka/concepts/instance-types.md). Для подключения к кластеру с локальной машины пользователя, а не из облачной сети Yandex Cloud, включите публичный доступ к кластеру при его создании.

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) в кластере Managed Service for Apache Kafka®.

    1. Чтобы [производитель и потребитель](../../managed-kafka/concepts/producers-consumers.md) могли работать с топиком в кластере Managed Service for Apache Kafka®, [создайте пользователей](../../managed-kafka/operations/cluster-accounts.md#create-account):

        * с ролью `ACCESS_ROLE_PRODUCER` для производителя;
        * с ролью `ACCESS_ROLE_CONSUMER` для потребителя.

    1. [Создайте кластер-приемник Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-clickhouse/concepts/instance-types.md). Для подключения к кластеру с локальной машины пользователя, а не из облачной сети Yandex Cloud, включите публичный доступ к кластеру при его создании.

    
    1. Если вы используете группы безопасности, настройте их так, чтобы к кластерам можно было подключаться из интернета:

        * [Managed Service for Apache Kafka®](../../managed-kafka/operations/connect/index.md#configuring-security-groups).
        * [Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-clickhouse/blob/main/data-transfer-mkf-mch.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластерам из интернета;
        * кластер-источник Managed Service for Apache Kafka®;
        * топик и два пользователя Apache Kafka®, от имени которых к топику будут подключаться производитель и потребитель;
        * кластер-приемник Managed Service for ClickHouse®;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-mkf-mch.tf`:

        * параметры кластера-источника Managed Service for Apache Kafka®:

            * `source_user_producer` и `source_password_producer` — имя и пароль пользователя производителя;
            * `source_user_consumer` и `source_password_consumer` — имя и пароль пользователя потребителя;
            * `source_topic_name` — имя топика;

        * параметры кластера-приемника Managed Service for ClickHouse®, которые будут использоваться как [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

            * `target_db_name` — имя базы данных Managed Service for ClickHouse®;
            * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

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

    * [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топик Apache Kafka®.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластерам Managed Service for Apache Kafka® через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    * [clickhouse-client](https://clickhouse.com/docs/ru/interfaces/cli/) — для подключения к базе данных в кластере Managed Service for ClickHouse®.

        1. Подключите [DEB-репозиторий](https://clickhouse.com/docs/ru/getting-started/install/#install-from-deb-packages) ClickHouse®:

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

        Убедитесь, что можете с ее помощью [подключиться к кластеру Managed Service for ClickHouse® через SSL](../../managed-clickhouse/operations/connect/clients.md).

    * [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Отправьте тестовые данные в топик Managed Service for Apache Kafka® {#send-sample-data-to-kf}

Пусть в топик Apache Kafka® поступают данные от сенсоров автомобиля. Эти данные будут передаваться в виде сообщений Apache Kafka® в формате JSON:

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

Кластер Managed Service for ClickHouse® будет использовать [формат данных JSONEachRow](https://clickhouse.com/docs/ru/interfaces/formats/#jsoneachrow) при вставке в таблицы на движке `Kafka`. Этот формат преобразует строки из сообщения Apache Kafka® в нужные значения столбцов.

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

1. Отправьте данные из файла `sample.json` в топик Managed Service for Apache Kafka® с помощью `jq` и `kafkacat`:

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

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% note info %}

Для ускорения поставки большого объема данных используйте [специальные настройки эндпоинтов](../../data-transfer/operations/endpoint/target/clickhouse.md#recommended-settings-queue).

{% endnote %}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `Kafka`.
    * **Параметры эндпоинта** → **Настройки подключения**:

        * **Тип подключения** — `Кластер Managed Service for Apache Kafka`.

            * **Кластер Managed Service for Apache Kafka** — выберите кластер-источник из списка.
            * **Аутентификация**:

                * **Имя пользователя** — укажите имя пользователя потребителя.
                * **Пароль** — укажите пароль пользователя потребителя.

        * **Полное имя топика** — укажите имя топика в кластере Managed Service for Apache Kafka®.

        * **Расширенные настройки** → **Правила конвертации**:

            * **Формат данных** — `JSON`.
            * **Схема данных** — `JSON-спецификация`:

                Скопируйте и вставьте схему данных в формате JSON:

                {% cut "схема данных" %}

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

            * **Тип базы данных** — `ClickHouse`.
            * **Параметры эндпоинта**:

                * **Настройки подключения**:

                    * **Тип подключения** — `Managed кластер`.

                        * **Managed кластер** — выберите кластер-приемник из списка.

                    * **База данных** — укажите имя базы данных.
                    * **Пользователь** и **Пароль** — укажите имя и пароль пользователя с доступом к базе, например, владельца базы данных.

                * **Расширенные настройки** → **Загружать данные в формате JSON** — включите эту опцию, если в расширенных настройках эндпоинта-источника включили опцию **Правила конвертации**.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Раскомментируйте в файле `data-transfer-mkf-mch.tf`:

            * переменную `source_endpoint_id` и задайте ей значение идентификатора эндпоинта для источника, созданного на предыдущем шаге;
            * ресурсы `yandex_datatransfer_endpoint` и `yandex_datatransfer_transfer`.

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

1. Убедитесь, что в базу данных Managed Service for ClickHouse® перенеслись данные из кластера-источника Managed Service for Apache Kafka®:

    1. [Подключитесь к кластеру](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью `clickhouse-client`.

    1. Выполните запрос:

        ```sql
        SELECT * FROM <имя_базы_данных_ClickHouse®>.<имя_топика_Apache_Kafka>
        ```

1. Измените значения в файле `sample.json` и отправьте данные из него в топик Managed Service for Apache Kafka®:

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

1. Убедитесь, что в базе данных Managed Service for ClickHouse® отобразились новые значения:

    1. [Подключитесь к кластеру](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью `clickhouse-client`.

    1. Выполните запрос:

        ```sql
        SELECT * FROM <имя_базы_данных_ClickHouse®>.<имя_топика_Apache_Kafka>
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
       1. [Удалите кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).
       1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).

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