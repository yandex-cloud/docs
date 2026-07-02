[Документация Yandex Cloud](../../index.md) > [Yandex Data Transfer](../index.md) > [Практические руководства](index.md) > Загрузка данных в витрины > Object Storage в PostgreSQL

# Загрузка данных из Yandex Object Storage в Yandex Managed Service for PostgreSQL

# Перенос данных из Yandex Object Storage в Yandex Managed Service for PostgreSQL с использованием Yandex Data Transfer


Вы можете перенести данные из Yandex Object Storage в таблицу Managed Service for PostgreSQL с помощью сервиса Data Transfer. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}


Подготовьте инфраструктуру:

{% list tabs group=resources %}

- Вручную {#manual}

    1. [Создайте кластер-приемник Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-postgresql/concepts/instance-types.md) со следующими настройками:

        * **Имя БД** — `db1`.
        * **Имя пользователя** — `pg-user`.
        * **Пароль** — `<пароль_пользователя>`.
        * Выделен публичный доступ к хостам кластера.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

    
    1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../../managed-postgresql/operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.


    1. [Создайте бакет Yandex Object Storage](../../storage/operations/buckets/create.md).

    
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-viewer` и ролью `storage.viewer`. Трансфер будет использовать его для доступа к бакету.
    1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `storage-viewer`.


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [objstorage-to-postgres.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-postgresql/blob/main/objstorage-to-postgres.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
        * сервисный аккаунт, который будет использоваться для создания бакета и дальнейшего доступа к нему;
        * секрет Yandex Lockbox, в котором будет храниться статический ключ сервисного аккаунта для настройки эндпоинта-источника;
        * бакет-источник Object Storage;
        * кластер-приемник Managed Service for PostgreSQL;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `objstorage-to-postgres.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
        * `pg_password` — пароль пользователя PostgreSQL.

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

1. Создайте на рабочей машине `demo_data.csv` и наполните его тестовыми данными:

    ```csv
    1,Anna
    2,Robert
    3,Umar
    4,Algul
    5,Viktor
    ```

1. [Загрузите](../../storage/operations/objects/upload.md#simple) подготовленный файл в бакет Object Storage.

## Подготовьте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../operations/endpoint/source/object-storage.md) типа `Object Storage` со следующими настройками:

    * **Тип базы данных** — `Object Storage`.
    * **Бакет** — имя бакета в Object Storage.

    
    * **Идентификатор ключа доступа AWS** — открытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью Terraform, [скопируйте значение ключа из секрета Yandex Lockbox](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **Секретный ключ доступа AWS** — закрытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью Terraform, [скопируйте значение ключа из секрета Yandex Lockbox](../../lockbox/operations/secret-get-info.md#secret-contents).


    * **Эндпоинт** — `https://storage.yandexcloud.net`.
    * **Регион** — `ru-central1`.
    * **Формат данных** — `CSV`.
    * **Разделитель** — знак запятой `,`.
    * **Таблица** — имя CSV-файла в бакете, например `demo_data.csv`.
    * **Схема результирующей таблицы** — выберите `Вручную` и укажите имена полей и тип данных:

        * `Id`: `Int64`;
        * `Name`: `UTF8`.

    Остальные параметры оставьте по умолчанию.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../operations/endpoint/target/postgresql.md) типа `PostgreSQL` и укажите в нем параметры подключения к кластеру:

            * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
            * **Кластер Managed Service for PostgreSQL** — имя кластера-источника PostgreSQL из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `pg-user`.
            * **Пароль** — `<пароль_пользователя>`.

        1. [Создайте трансфер](../operations/transfer.md#create) типа **_Копирование_**, использующий созданные эндпоинты.

    - Terraform {#tf}

        1. Укажите в файле `objstorage-to-postgres.tf` переменные:

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

    {% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **Завершен**.
1. [Подключитесь к базе данных в кластере-приемнике Managed Service for PostgreSQL](../../managed-postgresql/operations/connect/index.md).
1. Выполните запрос:

    ```sql
    SELECT * FROM public."demo_data.csv";
    ```

    {% cut "Пример ответа" %}

    ```sql
     __file_name  | __row_index | Id |  Name  
    --------------+-------------+----+--------
    demo_data.csv |           1 |  1 | Anna
    demo_data.csv |           2 |  2 | Robert
    demo_data.csv |           3 |  3 | Umar
    demo_data.csv |           4 |  4 | Algul
    demo_data.csv |           5 |  5 | Viktor
    ```

    {% endcut %}

Данные успешно перенесены.

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../operations/transfer.md#delete).
1. [Удалите эндпоинт-источник](../operations/endpoint/index.md#delete).
1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакета.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Удалите эндпоинт-приемник](../operations/endpoint/index.md#delete).
        1. [Удалите кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-delete.md).
        1. [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md).

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