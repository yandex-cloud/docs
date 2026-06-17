# Загрузка данных из Yandex Object Storage в Managed Service for ClickHouse® с помощью Yandex Data Transfer

# Загрузка данных из Yandex Object Storage в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer


Вы можете перенести данные из Yandex Object Storage в таблицу Managed Service for ClickHouse® с помощью сервиса Data Transfer. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Кластер Managed Service for ClickHouse®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}


Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-приемник Managed Service for ClickHouse®](../operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

        * **Имя БД** — `db1`.
        * **Имя пользователя** — `user1`.
        * **Пароль** — `<пароль_пользователя>`.
        * Количество хостов ClickHouse® — не меньше 2 (для включения репликации в кластере).
        * Выделен публичный доступ к хостам кластера.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

    
    1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.


    1. [Создайте бакет Yandex Object Storage](../../storage/operations/buckets/create.md).

    
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-viewer` и ролью `storage.viewer`. Трансфер будет использовать его для доступа к бакету.

    1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `storage-viewer`.


- С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [object-storage-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-clickhouse/blob/main/object-storage-to-clickhouse.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
        * сервисный аккаунт, который будет использоваться для создания бакета и дальнейшего доступа к нему;
        * секрет Yandex Lockbox, в котором будет храниться статический ключ сервисного аккаунта для настройки эндпоинта-источника;
        * бакет-источник Object Storage;
        * кластер-приемник Managed Service for ClickHouse®;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `object-storage-to-clickhouse.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
        * `ch_password` — пароль пользователя ClickHouse®.

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

1. Подготовьте два CSV-файла с тестовыми данными:

    * `demo_data1.csv`:

        ```csv
        1,Anna
        2,Robert
        3,Umar
        4,Algul
        5,Viktor
        ```

    * `demo_data2.csv`:

        ```csv
        6,Maria
        7,Alex
        ```

1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `demo_data1.csv` в бакет Object Storage.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/object-storage.md#endpoint-settings) типа `Object Storage` со следующими настройками:

    * **Тип базы данных** — `Object Storage`.
    * **Бакет** — имя бакета в Object Storage.

    
    * **Идентификатор ключа доступа AWS** — открытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью Terraform, [скопируйте значение ключа из секрета Yandex Lockbox](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **Секретный ключ доступа AWS** — закрытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью Terraform, [скопируйте значение ключа из секрета Yandex Lockbox](../../lockbox/operations/secret-get-info.md#secret-contents).


    * **Эндпоинт** — `https://storage.yandexcloud.net`.
    * **Регион** — `ru-central1`.
    * **Формат данных** — `CSV`.
    * **Разделитель** — знак запятой `,`.
    * **Таблица** — `table1`.
    * **Схема результирующей таблицы** — выберите `Вручную` и укажите имена полей и тип данных:

        * `Id`: `Int64`;
        * `Name`: `UTF8`.

    Остальные параметры оставьте по умолчанию.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/clickhouse.md#endpoint-settings) типа `ClickHouse®` и укажите в нем параметры подключения к кластеру:

            * **Тип подключения** — `Кластер Managed Service for ClickHouse`.
            * **Managed кластер** — `<имя_кластера_приемника_ClickHouse®>` из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `user1`.
            * **Пароль** — `<пароль_пользователя>`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Копирование и репликация_**, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.

    - С помощью Terraform {#tf}

        1. Укажите в файле `object-storage-to-clickhouse.tf` значения параметров:

            * `source_endpoint_id` — идентификатор эндпоинта для источника.
            * `transfer_enabled` — значение `1` для создания трансфера.

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

Чтобы убедиться в работоспособности трансфера, проверьте работу копирования и репликации.

### Проверьте работу копирования {#verify-copy}

1. [Подключитесь к базе данных](../operations/connect/clients.md) `db1` в кластере-приемнике Managed Service for ClickHouse®.

1. Выполните запрос:

    ```sql
    SELECT * FROM db1.table1;
    ```

    {% cut "Пример ответа" %}

    ```sql
      __file_name  | __row_index | Id |  Name
    --------------+-------------+----+--------
    demo_data1.csv |           1 |  1 | Anna
    demo_data1.csv |           2 |  2 | Robert
    demo_data1.csv |           3 |  3 | Umar
    demo_data1.csv |           4 |  4 | Algul
    demo_data1.csv |           5 |  5 | Viktor
    ```

    {% endcut %}

### Проверьте работу репликации {#verify-replication}

1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `demo_data2.csv` в бакет Object Storage.

1. Убедитесь, что данные из файла `demo_data2.csv` появились в базе данных приемника:

    1. [Подключитесь к базе данных](../operations/connect/clients.md) `db1` в кластере-приемнике Managed Service for ClickHouse®.

    1. Выполните запрос:

        ```sql
        SELECT * FROM db1.table1;
        ```

        {% cut "Пример ответа" %}

        ```sql
          __file_name  | __row_index | Id |  Name
        --------------+-------------+----+--------
        demo_data1.csv |           1 |  1 | Anna
        demo_data1.csv |           2 |  2 | Robert
        demo_data1.csv |           3 |  3 | Umar
        demo_data1.csv |           4 |  4 | Algul
        demo_data1.csv |           5 |  5 | Viktor
        demo_data2.csv |           1 |  6 | Maria
        demo_data2.csv |           2 |  7 | Alex
        ```

        {% endcut %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакета.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
        1. [Удалите кластер Managed Service for ClickHouse®](../operations/cluster-delete.md).
        1. [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md).

    - С помощью Terraform {#tf}

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