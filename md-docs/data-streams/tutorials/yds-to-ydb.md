# Поставка данных из очереди Data Streams в Managed Service for YDB

# Поставка данных из очереди Data Streams в Managed Service for YDB с помощью Data Transfer

С помощью сервиса Data Transfer можно поставлять данные из потока Data Streams в базу данных Managed Service for YDB.

Чтобы перенести данные:

1. [Подготовьте поток данных Data Streams](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Базы данных Managed Service for YDB (см. [тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
  	* Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Сервис Data Streams (см. [тарифы Data Streams](../pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы Data Transfer](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру поставки данных:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации для потока Data Streams.

    1. [Создайте базу данных приемника Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [yds-to-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-ydb/blob/main/yds-to-ydb.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к базе данных Managed Service for YDB.
        * базы данных Managed Service for YDB;
        * трансфер.

    1. Укажите в файле `yds-to-ydb.tf` значения параметров:

        * `source_db_name` — имя базы данных Managed Service for YDB для потока Data Streams;
        * `target_db_name` — имя базы данных приемника Managed Service for YDB;
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

## Создайте поток данных Data Streams {#prepare-source}

[Создайте поток данных Data Streams](../quickstart/create-stream.md).

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для источника Data Streams](../../data-transfer/operations/endpoint/index.md#create).

    * **Тип базы данных** — `Yandex Data Streams`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

            * **База данных** — выберите из списка базу данных Managed Service for YDB для потока Data Streams.
            * **Поток** — укажите имя потока Data Streams.
            * **Сервисный аккаунт** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **Расширенные настройки**:

            * **Правила конвертации** — `JSON`.
            * **Схема данных** — `JSON-спецификация`.

                Заполните схему данных:

                {% cut "Схема данных" %}

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

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `YDB`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

           * **База данных** — выберите базу данных приемника Managed Service for YDB из списка.
           * **Идентификатор сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **Репликация**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Укажите в файле `yds-to-ydb.tf` значения переменных:

            * `source_endpoint_id` — идентификатор эндпоинта для источника;
            * `target_endpoint_id` — идентификатор эндпоинта для приемника;
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

            Трансфер активируется автоматически.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **Реплицируется**.

1. [Отправьте в поток Data Streams](../operations/aws-cli/send.md) тестовые данные:

    ```json
    {
        "device_id":"iv9a94th6rzt********",
        "datetime":"2020-06-05T17:27:00",
        "latitude":"55.70329032",
        "longitude":"37.65472196",
        "altitude":"427.5",
        "speed":"0",
        "battery_voltage":"23.5",
        "cabin_temperature":"17",
        "fuel_level":null
    }
    ```

1. Убедитесь, что данные перенеслись в базу данных приемника:

     {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором база данных.
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;YDB**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что в таблицу `<название_потока>` добавились тестовые данные.

    - YDB CLI {#cli}

        1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
        1. Проверьте, что в таблицу `<название_потока>` добавились тестовые данные:

            ```bash
            ydb table query execute \
            --query "SELECT * \
            FROM <название_потока>"
            ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. Если вы создавали сервисные аккаунты, [удалите их](../../iam/operations/sa/delete.md).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       [Удалите базы данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).

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