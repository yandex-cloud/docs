# Поставка данных из Yandex Managed Service for Apache Kafka® в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer

# Поставка данных из очереди Apache Kafka® в PostgreSQL с помощью Yandex Data Transfer


Вы можете настроить перенос данных из топика Managed Service for Apache Kafka® в Managed Service for PostgreSQL с помощью сервиса Yandex Data Transfer. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../../../managed-kafka/pricing.md)).
* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ ([тарифы Virtual Private Cloud](../../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

        1. [Создайте кластер-источник Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md#create-cluster) в любой [зоне доступности](../../overview/concepts/geo-scope.md), любой подходящей конфигурации и с публичным доступом.

        1. [Создайте в кластере-источнике топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `sensors`.

        1. [Создайте в кластере-источнике пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `mkf-user` и правами доступа к созданному топику `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_CONSUMER`.

        1. В той же зоне доступности [создайте кластер-приемник Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с именем пользователя-администратора `pg-user` и хостами в публичном доступе.

        1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:
            * [Managed Service for Apache Kafka®](../../managed-kafka/operations/connect/index.md#configuring-security-groups).
            * [Managed Service for PostgreSQL](../../managed-postgresql/operations/connect/index.md#configuring-security-groups).

    - Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-postgresql/blob/main/kafka-postgresql.tf).

            В этом файле описаны:

            * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;
            * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;
            * кластер-источник Managed Service for Apache Kafka®;
            * кластер-приемник Managed Service for PostgreSQL;
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `kafka-postgresql.tf`:

            * Версии Apache Kafka® и PostgreSQL.
            * Пароли пользователей Apache Kafka® и PostgreSQL.

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

1. Установите утилиты:

    * [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики Apache Kafka®.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику Managed Service for Apache Kafka® через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    * [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq

## Подготовьте тестовые данные {#prepare-data}

Пусть в качестве сообщения в топик Apache Kafka® `sensors` кластера-источника поступают данные от сенсоров автомобиля в формате JSON.

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

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/kafka.md) типа `Apache Kafka®` и задайте для него:

        * **Полное имя топика** — `sensors`.
        * Правила конвертации типа `json`. В поле **Схема данных** выберите `JSON-спецификация` и в открывшуюся форму скопируйте следующую спецификацию полей:

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

    1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/postgresql.md) типа `PostgreSQL` и укажите в нем параметры подключения к кластеру:

        * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
        * **Кластер Managed Service for PostgreSQL** — `<имя_кластера-приемника_PostgreSQL>` из выпадающего списка.
        * **База данных** — `db1`.
        * **Пользователь** — `pg-user`.
        * **Пароль** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.
    1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.

- Terraform {#tf}

    1. Укажите в файле `kafka-postgresql.tf` значение `1` для переменной `transfer_enabled`, чтобы создать эндпоинты и трансфер.

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

    1. Трансфер активируется автоматически. Дождитесь его перехода в статус **Реплицируется**.

{% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Убедитесь, что в базу данных Managed Service for PostgreSQL переносятся данные из топика кластера-источника Managed Service for Apache Kafka®:

1. Отправьте данные из файла `sample.json` в топик `sensors` Managed Service for Apache Kafka® с помощью утилит `jq` и `kafkacat`:

    ```bash
    jq -rc . sample.json | kafkacat -P \
        -b <FQDN_хоста-брокера>:9091 \
        -t sensors \
        -k key \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username="mkf-user" \
        -X sasl.password="<пароль_пользователя_в_кластере-источнике>" \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z
    ```

    Подробнее о настройке SSL-сертификата и работе с `kafkacat` смотрите в разделе [Подключение к кластеру Apache Kafka® из приложений](../../managed-kafka/operations/connect/clients.md).

1. Проверьте, что в базу данных Managed Service for PostgreSQL перенеслись данные из кластера-источника Managed Service for Apache Kafka®:

    1. [Подключитесь к базе данных Managed Service for PostgreSQL](../../managed-postgresql/operations/connect/index.md).
    1. Проверьте, что таблица `sensors` содержит отправленные данные:

        ```sql
        SELECT * FROM sensors;
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).
    1. [Удалите кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).
    1. [Удалите кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-delete.md).

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
```