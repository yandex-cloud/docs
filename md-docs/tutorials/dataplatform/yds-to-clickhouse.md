[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Сохранение потока данных Data Streams в Managed Service for ClickHouse®

# Сохранение потока данных Yandex Data Streams в Yandex Managed Service for ClickHouse®

# Сохранение потока данных Yandex Data Streams в Yandex Managed Service for ClickHouse®


С помощью сервиса Data Transfer вы можете поставлять данные из [потока Data Streams](../../data-streams/concepts/glossary.md#stream-concepts) в сервис Managed Service for ClickHouse®.

Чтобы перенести данные:

1. [Подготовьте поток данных Data Streams](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* База данных Managed Service for YDB ([тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
  	* Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Сервис Data Streams ([тарифы Data Streams](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

* Кластер Managed Service for ClickHouse®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы Data Transfer](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.
    1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации.
    1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

        * **Тип базы данных** — `ClickHouse`.
        * **Параметры эндпоинта**:

            * **Настройки подключения**:

                * **Тип подключения** — `Managed кластер`.

                    * **Managed кластер** — выберите кластер-приемник из списка.

                * **База данных** — укажите имя базы данных.
                * **Пользователь** и **Пароль** — укажите имя и пароль пользователя с доступом к базе, например, владельца базы данных.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-yds-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-clickhouse/blob/main/data-transfer-yds-mch.tf).

        В этом файле описаны:

        * база данных Managed Service for YDB;
        * сервисный аккаунт с ролью `yds.editor`;
        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for ClickHouse® из интернета;
        * кластер-приемник Managed Service for ClickHouse®;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-yds-mch.tf`:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
        * `sa_name` — имя сервисного аккаунта для использования в эндпоинтах.
        * `source_db_name` — имя базы данных Managed Service for YDB.
        * `target_db_name` — имя базы данных ClickHouse®.
        * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных ClickHouse®.
        * `transfer_enabled` – значение `0`, чтобы не создавать трансфер до [создания эндпоинта-источника вручную](#prepare-transfer).

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

## Подготовьте поток данных Data Streams {#prepare-source}

1. [Создайте поток данных Data Streams](../../data-streams/operations/aws-cli/create.md).
1. [Отправьте в поток](../../data-streams/operations/aws-cli/send.md) тестовые данные. В качестве сообщения используйте данные от сенсоров автомобиля в формате JSON:

```json
{
    "device_id":"iv9a94th6rzt********",
    "datetime":"2022-06-05 17:27:00",
    "latitude":55.70329032,
    "longitude":37.65472196,
    "altitude":427.5,
    "speed":0,
    "battery_voltage":"23.5",
    "cabin_temperature":17,
    "fuel_level":null
}
```

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% note info %}

Для ускорения поставки большого объема данных используйте [специальные настройки эндпоинтов](../../data-transfer/operations/endpoint/target/clickhouse.md#recommended-settings-queue).

{% endnote %}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `Yandex Data Streams`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

            * **База данных** — выберите базу данных Managed Service for YDB из списка.
            * **Поток** — укажите имя потока Data Streams.
            * **Сервисный аккаунт** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **Расширенные настройки**:

            * **Правила конвертации** — `JSON`.
            * **Схема данных** –  Вы можете задать схему двумя способами:
              * `Список полей`.

                Задайте список полей топика вручную:

                | Имя | Тип | Ключ |
                | :-- | :-- | :--- |
                |`device_id`|`STRING`| Да|
                |`datetime` |`DATETIME`|  |
                |`latitude` |`DOUBLE`|  |
                |`longitude`|`DOUBLE`|  |
                |`altitude` |`DOUBLE`|  |
                |`speed`    |`DOUBLE`|  |
                |`battery_voltage`| `ANY`||
                |`cabin_temperature`| `DOUBLE`||
                | `fuel_level`|`ANY`||

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

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **Репликация**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Укажите в файле `data-transfer-yds-mch.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
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

1. [Отправьте в поток](../../data-streams/operations/aws-cli/send.md) Data Streams новое сообщение:

    ```json
    {
        "device_id":"rhibbh3y08qm********",
        "datetime":"2022-06-06 09:49:54",
        "latitude":55.71294467,
        "longitude":37.66542005,
        "altitude":429.13,
        "speed":55.5,
        "battery_voltage":null,
        "cabin_temperature":18,
        "fuel_level":32
    }
    ```

1. Убедитесь, что в базу данных кластера Managed Service for ClickHouse® перенеслись данные из потока Data Streams:

   1. [Подключитесь к кластеру-приемнику Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/clients.md).
   1. Проверьте, что в базе ClickHouse® существует таблица с именем [созданного потока Data Streams](#prepare-source) с теми же колонками, что и [схема данных в эндпоинте-источнике](#prepare-transfer), и отправленными тестовыми данными.

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. Удалите ресурсы в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
       1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).
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

1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._