# Миграция базы данных из Yandex Managed Service for MySQL® в Yandex Object Storage

# Загрузка данных из MySQL® в Yandex Object Storage с помощью Yandex Data Transfer


С помощью сервиса Data Transfer вы можете перенести данные из кластера-источника Managed Service for MySQL® в объектное хранилище Yandex Object Storage.

Чтобы перенести данные:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for MySQL®](../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными (см. [тарифы Object Storage](../../storage/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник Managed Service for MySQL®](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации.
    1. [Создайте бакет в Yandex Object Storage](../../storage/operations/buckets/create.md).


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mmy-objs.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-object-storage/blob/main/data-transfer-mmy-objs.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру Managed Service for MySQL®;
        * кластер-источник Managed Service for MySQL®;
        * сервисный аккаунт с ролями `editor`, `storage.editor` и `storage.uploader`;
        * бакет Object Storage;
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `data-transfer-mmy-objs.tf`:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
        * `sa_name` — имя сервисного аккаунта для создания бакета и использования в эндпоинте-приемнике.
        * `bucket_name` — имя бакета в Object Storage.
        * параметры кластера-источника Managed Service for MySQL®, которые будут использоваться как [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/source/mysql.md#managed-service):

            * `source_mysql_version` — версия MySQL®;
            * `source_db_name` — имя базы данных;
            * `source_user` и `source_password` — имя и пароль пользователя-владельца базы данных.
        * `transfer_enabled` – значение `0`, чтобы не создавать трансфер до [создания эндпоинта-приемника вручную](#prepare-transfer).

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

## Подготовьте кластер-источник {#prepare-source}

1. Если вы создавали инфраструктуру вручную, [подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).

1. [Подключитесь к кластеру-источнику Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md).

1. Наполните базу тестовыми данными. В качестве примера используется таблица с информацией, поступающей от датчиков автомобиля.

    Создайте таблицу:

    ```sql
    CREATE TABLE measurements (
        device_id varchar(200) NOT NULL,
        datetime timestamp NOT NULL,
        latitude real NOT NULL,
        longitude real NOT NULL,
        altitude real NOT NULL,
        speed real NOT NULL,
        battery_voltage real,
        cabin_temperature real NOT NULL,
        fuel_level real,
        PRIMARY KEY (device_id)
    );
    ```

    Наполните таблицу данными:

    ```sql
    INSERT INTO measurements VALUES
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `Object Storage`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

          * **Бакет** — укажите имя бакета Object Storage.

          
          * **Сервисный аккаунт** — выберите или создайте сервисный аккаунт с ролью `storage.uploader`.


        * **Имя папки** — `measurements`.

1. Создайте эндпоинт для источника и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `MySQL`.
            * **Параметры эндпоинта**:

              * **Настройки подключения**:
                * **Тип подключения** — `Кластер Managed Service for MySQL`.

                   Выберите кластер-источник из списка и укажите настройки подключения к нему.

              * (Опционально) **Список включённых таблиц**, **Список исключённых таблиц** — укажите регулярные выражения для переносимых таблиц и таблиц, которые не надо переносить.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Копирование_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Укажите в файле `data-transfer-mmy-objs.tf` переменные:

            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера;
            * (опционально) `include_tables_regex`, `exclude_tables_regex` – регулярные выражения для переносимых таблиц и таблиц, которые не надо переносить.

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

1. Дождитесь перехода трансфера в статус **Завершен**.
1. Убедитесь, что данные перенеслись из кластера-источника Managed Service for MySQL® в бакет Object Storage:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужный бакет.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
    1. Выберите бакет из списка.
    1. Перейдите на вкладку **Объекты**.
    1. Проверьте, что бакет Object Storage содержит папку `measurements` с объектом `<имя_базы_данных_кластера-источника>_measurements` с тестовыми данными.

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
       1. [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md).
       1. [Удалите кластер Managed Service for MySQL®](../../managed-mysql/operations/cluster-delete.md).

       
       1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).


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