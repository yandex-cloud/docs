[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Практические руководства](index.md) > Миграция данных из Yandex Data Streams с помощью Yandex Data Transfer

# Миграция данных из Yandex Data Streams с помощью Yandex Data Transfer

С помощью сервиса Data Transfer вы можете перенести данные из [потока Data Streams](../../data-streams/concepts/glossary.md#stream-concepts) в бакет Yandex Object Storage:

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

* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    1. [Создайте бакет в Yandex Object Storage](../operations/buckets/create.md).

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-yds-obj.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-object-storage/blob/main/data-transfer-yds-obj.tf).

        В этом файле описаны:

        * база данных Managed Service for YDB;
        * сервисный аккаунт с ролями `yds.editor`, `storage.editor` и `storage.uploader`;
        * бакет в Object Storage;
        * трансфер.

    1. Укажите в файле `data-transfer-yds-obj.tf`:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
        * `sa_name` — имя сервисного аккаунта для создания бакета и использования в эндпоинтах.
        * `source_db_name` — имя базы данных Managed Service for YDB.
        * `bucket_name` — имя бакета в Object Storage.

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
1. Подождите 5–10 секунд и отправьте в поток второе сообщение.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `Yandex Data Streams`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

            * **База данных** — выберите базу данных Managed Service for YDB из списка.
            * **Поток** — укажите имя потока Data Streams.
            * **Сервисный аккаунт** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **Расширенные настройки**:

            * **Правила конвертации** — `JSON`.
            * **Схема данных** — `JSON-спецификация`:

                Создайте и загрузите файл схемы данных в формате JSON `json_schema.json`:

                {% cut "json_schema.json" %}

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

    * **Тип базы данных** — `Object Storage`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

            * **Бакет** — укажите имя бакета в Object Storage.
            * **Сервисный аккаунт** — выберите или создайте сервисный аккаунт с ролью `storage.uploader`.

        * **Выходной формат** — выберите `JSON` или `CSV`, если в расширенных настройках эндпоинта источника включили опцию **Правила конвертации**.
      
        * **Расширенные настройки писателя** — выберите **Писатель репликации** и в поле **Интервал ротации** укажите 1.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **Репликация**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Раскомментируйте в файле `data-transfer-yds-obj.tf`:

            * переменные:

                * `source_endpoint_id` и задайте ей значение идентификатора эндпоинта для источника;
                * `target_endpoint_id` и задайте ей значение идентификатора эндпоинта для приемника;

            * ресурс `yandex_datatransfer_transfer`.

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

1. Убедитесь, что данные из потока Data Streams перенеслись в бакет Object Storage:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится бакет.
    1. Перейдите в сервис **Object Storage**.
    1. Выберите бакет из списка.
    1. Проверьте, что бакет содержит файл `<имя_потока>/partition=0/<имя_потока>+0+0.raw` (`.json` или `.csv`, в зависимости от выбранного выходного формата) с первым сообщением.

1. [Отправьте в поток Data Streams](../../data-streams/operations/aws-cli/send.md) новое сообщение:

    ```json
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
    ```

1. Убедитесь, что в бакете Object Storage появились добавленные данные:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится бакет.
    1. Перейдите в сервис **Object Storage**.
    1. Выберите бакет из списка.
    1. Проверьте, что бакет содержит файл `<имя_потока>/partition=0/<имя_потока>+0+1.raw` (`.json` или `.csv`, в зависимости от выбранного выходного формата) с первым сообщением.

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. [Удалите объекты](../operations/objects/delete.md) из бакета Object Storage.
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).
       1. [Удалите бакет в Object Storage](../operations/buckets/delete.md).
       1. Если при создании эндпоинтов вы создавали сервисные аккаунты, [удалите их](../../iam/operations/sa/delete.md).

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