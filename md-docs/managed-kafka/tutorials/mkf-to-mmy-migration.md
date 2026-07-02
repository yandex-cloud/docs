[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Kafka®](../index.md) > [Практические руководства](index.md) > Поставка данных с помощью Data Transfer > Поставка из Apache Kafka® в MySQL®

# Поставка данных в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer


# Поставка данных очереди из Apache Kafka® в MySQL® с помощью Yandex Data Transfer


В кластер Managed Service for MySQL® можно в реальном времени поставлять данные из топиков Apache Kafka®.

Чтобы запустить поставку данных:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../pricing.md)).
* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for MySQL®](../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

        1. [Создайте кластер-источник Managed Service for Apache Kafka®](../operations/cluster-create.md) любой подходящей конфигурации. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети Yandex Cloud, включите публичный доступ к кластеру при его создании.

        1. [Создайте в кластере-источнике топик](../operations/cluster-topics.md#create-topic) с именем `sensors`.

        1. [Создайте в кластере-источнике пользователя](../operations/cluster-accounts.md#create-account) с именем `mkf-user` и правами доступа `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_CONSUMER` к созданному топику.

        1. [Создайте кластер-приемник Managed Service for MySQL®](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

            * Имя базы данных — `db1`.
            * Имя пользователя — `mmy-user`.
            * В той же зоне доступности, что и кластер-источник.
            * Для подключения к кластеру с локальной машины пользователя, а не из облачной сети Yandex Cloud, включите публичный доступ к хостам кластера.

        
        1. Для подключения к кластерам с локальной машины пользователя настройте группы безопасности:

            * [Managed Service for Apache Kafka®](../operations/connect/index.md#configuring-security-groups).
            * [Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md#configure-security-groups).


    
    - Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-mmy.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-mysql/blob/main/data-transfer-mkf-mmy.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластерам Managed Service for Apache Kafka® и Managed Service for MySQL®;
            * кластер-источник Managed Service for Apache Kafka®;
            * топик Apache Kafka® с именем `sensors`;
            * пользователь Apache Kafka® `mkf-user` с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` к топику `sensors`;
            * кластер-приемник Managed Service for MySQL® с базой данных `db1` и пользователем `mmy-user`;
            * эндпоинты для источника и приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-mkf-mmy.tf` переменные:

            * `source_kf_version` — версия Apache Kafka® в кластере-источнике;
            * `source_user_password` — пароль пользователя `mkf-user` в кластере-источнике;
            * `target_mysql_version` — версия MySQL® в кластере-приемнике;
            * `target_user_password` — пароль пользователя `mmy-user` в кластере-приемнике;
            * `transfer_enabled` — значение `0`.

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

    - [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики Apache Kafka®.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику Managed Service for Apache Kafka® через SSL](../operations/connect/clients.md#bash-zsh).

    - [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

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

    1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [источника Apache Kafka®](../../data-transfer/operations/endpoint/source/kafka.md):

        **Параметры эндпоинта**:

        * **Настройки подключения**:

            * **Тип подключения** — `Кластер Managed Service for Apache Kafka`.

                * **Кластер Managed Service for Apache Kafka** — выберите кластер-источник из списка.

                * **Аутентификация** — **SASL**.

                    * **Имя пользователя** — `mkf-user`.
                    * **Пароль** — укажите пароль пользователя.

            * **Полное имя топика** — `sensors`.

        * **Расширенные настройки** → **Правила конвертации**:

            * **Правила конвертации** — `json`.
                * **Схема данных** — `JSON-спецификация`.

                    Вставьте схему данных в формате JSON:

                    {% cut "json" %}

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

    1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [приемника MySQL®](../../data-transfer/operations/endpoint/target/mysql.md):

        * **Параметры эндпоинта** → **Настройки подключения**:

            * **Тип подключения** — `Кластер Managed Service for MySQL`.

                * **Кластер Managed Service for MySQL** — выберите кластер-приемник из списка.

            * **База данных** — `db1`.

            * **Пользователь** — `mmy-user`.

            * **Пароль** — укажите пароль пользователя.

    1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.
    1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.


- Terraform {#tf}

    1. Укажите в файле `data-transfer-mkf-mmy.tf` значение `1` для переменной `transfer_enabled`, чтобы создать эндпоинты и трансфер.

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

Убедитесь, что в кластер Managed Service for MySQL® переносятся данные из топика кластера-источника Managed Service for Apache Kafka®:

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

    Подробнее о настройке SSL-сертификата и работе с `kafkacat` смотрите в разделе [Подключение к кластеру Apache Kafka® из приложений](../operations/connect/clients.md).

1. Проверьте, что таблица `sensors` кластера Managed Service for MySQL® содержит отправленные данные:

    1. [Подключитесь к кластеру Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md).

    1. Получите содержимое таблицы `sensors` с помощью запроса:

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
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
    1. [Удалите кластер Managed Service for Apache Kafka®](../operations/cluster-delete.md).
    1. [Удалите кластер Managed Service for MySQL®](../../managed-mysql/operations/cluster-delete.md).


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