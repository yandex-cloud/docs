# Загрузка данных из Yandex Managed Service for YDB в Yandex Object Storage

# Загрузка данных из Yandex Managed Service for YDB в Yandex Object Storage с помощью Yandex Data Transfer


Вы можете перенести данные из Managed Service for YDB в объектное хранилище Object Storage с помощью сервиса Data Transfer. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* База данных Managed Service for YDB ([тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

    * Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
    * Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../../storage/pricing.md)).


## Перед началом работы {#before-you-begin}


Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    1. [Создайте бакет Object Storage](../../storage/operations/buckets/create.md).

    
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с ролями `storage.editor` и `ydb.editor`. Трансфер будет использовать его для доступа к базе данных и бакету.


- С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [ydb-to-object-storage.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-ydb-to-object-storage/blob/main/ydb-to-object-storage.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md);
        * сервисный аккаунт с ролями `storage.editor` и `ydb.editor`;
        * бакет-приемник Object Storage;
        * эндпоинты;
        * трансфер.

    1. Укажите в файле `ydb-to-object-storage.tf`:
        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md);
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

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

## Подготовьте тестовые данные {#prepare-data}

1. [Создайте](../../ydb/operations/crud.md#web-sql) в базе данных Managed Service for YDB таблицу `seasons`:

    ```sql
    CREATE TABLE seasons
    (
        series_id Uint64,
        season_id Uint64,
        title Utf8,
        first_aired Uint64,
        last_aired Uint64,
        PRIMARY KEY (series_id, season_id)
    );

    COMMIT;
     ```
1. Заполните таблицу данными:

    ```sql
    REPLACE INTO seasons (series_id, season_id, title, first_aired, last_aired)
    VALUES
        (1, 1, "Season 1", CAST(Date("2006-02-03") AS Uint64), CAST(Date("2006-03-03") AS Uint64)),
        (1, 2, "Season 2", CAST(Date("2007-08-24") AS Uint64), CAST(Date("2007-09-28") AS Uint64)),
        (1, 3, "Season 3", CAST(Date("2008-11-21") AS Uint64), CAST(Date("2008-12-26") AS Uint64)),
        (1, 4, "Season 4", CAST(Date("2010-06-25") AS Uint64), CAST(Date("2010-07-30") AS Uint64)),
        (2, 1, "Season 1", CAST(Date("2014-04-06") AS Uint64), CAST(Date("2014-06-01") AS Uint64)),
        (2, 2, "Season 2", CAST(Date("2015-04-12") AS Uint64), CAST(Date("2015-06-14") AS Uint64)),
        (2, 3, "Season 3", CAST(Date("2016-04-24") AS Uint64), CAST(Date("2016-06-26") AS Uint64)),
        (2, 4, "Season 4", CAST(Date("2017-04-23") AS Uint64), CAST(Date("2017-06-25") AS Uint64)),
        (2, 5, "Season 5", CAST(Date("2018-03-25") AS Uint64), CAST(Date("2018-05-13") AS Uint64));

    COMMIT;
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт для приемника](../operations/endpoint/target/object-storage.md) типа `Object Storage` со следующими настройками:

        * **Бакет** — `<имя_созданного_ранее_бакета>`

        
        * **Сервисный аккаунт** — `<имя_созданного_ранее_сервисного_аккаунта>`.


        * **Выходной формат** — `CSV`.
        * **Формат сжатия** — `UNCOMPRESSED`.
        * **Имя папки** — `from_YDB`.

    1. [Создайте эндпоинт для источника](../operations/endpoint/source/ydb.md) типа `YDB` и укажите в нем параметры подключения к базе данных:

        * **База данных** — выберите базу данных YDB из списка.

        
        * **Идентификатор сервисного аккаунта** — выберите созданный ранее сервисный аккаунт.


    1. [Создайте трансфер](../operations/transfer.md#create) типа **Копирование**, использующий созданные эндпоинты.

    1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **_Завершен_**.

- Terraform {#tf}

    1. Укажите в файле `ydb-to-object-storage.tf` переменные:

        * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
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

    1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **_Завершен_**.

{% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Убедитесь, что данные перенеслись из базы данных Managed Service for YDB в бакет Object Storage:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужный бакет.
1. Перейдите в сервис **Object Storage**.
1. Выберите бакет из списка.
1. Перейдите на вкладку **Объекты**.
1. Проверьте, что бакет Object Storage содержит папку `from_YDB` с объектом `<seasons.csv>` с тестовыми данными.

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../operations/transfer.md#delete).
1. [Удалите эндпоинты](../operations/endpoint/index.md#delete).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md).
       1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).

       
       1. Если вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).


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