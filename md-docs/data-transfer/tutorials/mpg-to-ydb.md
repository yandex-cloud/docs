# Миграция данных из PostgreSQL в YDB

# Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for YDB


В кластер Managed Service for YDB можно в реальном времени поставлять данные из базы данных PostgreSQL. Эти данные будут автоматически добавлены в таблицы YDB с именами исходных схем и таблиц.

Чтобы запустить поставку данных:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* База данных Managed Service for YDB (см. [тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

    * Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
    * Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервных копий.


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру поставки данных:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.
    1. [Создайте в кластере-источнике пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) и [назначьте ему](../../managed-postgresql/operations/grant.md) роль `mdb_replication`.


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mpg-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-ydb/blob/main/data-transfer-mpg-ydb.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру Managed Service for PostgreSQL;
        * кластер-источник Managed Service for PostgreSQL;
        * база данных PostgreSQL;
        * пользователь Managed Service for PostgreSQL;
        * база данных Managed Service for YDB;
        * эндпоинт-источник;
        * трансфер.

    1. Укажите в файле `data-transfer-mpg-ydb.tf` значения параметров:

        * `source_pg_version` – версия PostgreSQL в кластере-источнике;
        * `source_db_name` – имя БД в кластере-источнике;
        * `source_user_name` – имя пользователя для подключения к кластеру-источнику;
        * `source_user_password` – пароль пользователя;
        * `target_db_name` — имя базы данных Managed Service for YDB;
        * `transfer_enabled` – значение `0`, чтобы не создавать эндпоинт-источник и трансфер до [создания эндпоинта-приемника вручную](#prepare-transfer).

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

1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect/index.md) кластера-источника от имени созданного пользователя.
1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию с некоторых датчиков автомобиля.

    Создайте таблицу:

    ```sql
    CREATE TABLE public.sensors (
        "device_id" text PRIMARY KEY NOT NULL,
        "datetime" timestamp NOT NULL,
        "latitude" real NOT NULL,
        "longitude" real NOT NULL,
        "altitude" real NOT NULL,
        "speed" real NOT NULL,
        "battery_voltage" real,
        "cabin_temperature" real NOT NULL,
        "fuel_level" real
    );
    ```

    Наполните таблицу данными:

    ```sql
    INSERT INTO public.sensors VALUES
        ('iv9a94th6rzt********', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th678t********', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
    ```

1. [Подготовьте кластер-источник к трансферу](../operations/prepare.md#source-pg).

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../operations/endpoint/index.md#create):

    * **Тип базы данных** — `YDB`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:
           * **База данных** — выберите базу данных Managed Service for YDB из списка.

            

           * **Идентификатор сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.


1. Создайте эндпоинт для источника и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт](../operations/endpoint/index.md#create) для [созданного ранее](#before-you-begin) источника PostgreSQL с [настройками](../operations/endpoint/source/postgresql.md):

            * **Тип базы данных** — `PostgreSQL`.
            * **Параметры эндпоинта**:
                * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
                * **Кластер Managed Service for PostgreSQL** — созданный кластер Managed Service for PostgreSQL.
                * **База данных** — имя созданной БД в кластере Managed Service for PostgreSQL.
                * **Пользователь** — имя созданного пользователя в кластере Managed Service for PostgreSQL.
                * **Пароль** — пароль пользователя.
                * **Список включённых таблиц** — `<имя_БД>.sensors`.

        1. [Создайте трансфер](../operations/transfer.md#create) типа **Копирование и репликация**, использующий созданные эндпоинты.
        1. [Активируйте](../operations/transfer.md#activate) трансфер.

    - Terraform {#tf}

        1. Укажите в файле `data-transfer-mpg-ydb.tf` значения параметров:

            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания эндпоинта-источника и трансфера.

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
1. Убедитесь, что в базу данных Managed Service for YDB перенеслись данные из кластера-источника Managed Service for PostgreSQL:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужная база данных.
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;YDB**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что база данных Managed Service for YDB содержит таблицу `public_sensors` с тестовыми данными.

    * YDB CLI

        1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
        1. Проверьте, что база данных содержит таблицу `public_sensors` с тестовыми данными:

            ```bash
            ydb table query execute \
              --query "SELECT * \
              FROM public_sensors"
            ```

    {% endlist %}

1. [Подключитесь к кластеру-источнику Managed Service for PostgreSQL](../../managed-postgresql/operations/connect/index.md) и добавьте данные в таблицу `sensors`:

    ```sql
    INSERT INTO public.sensors VALUES
        ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что в базе данных Managed Service for YDB отобразились сведения о добавленной строке:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужная база данных.
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;YDB**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что в таблицу `public_sensors` добавились новые данные.

    - YDB CLI {#cli}

        1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
        1. Проверьте, что в таблицу `public_sensors` добавились новые данные:

            ```bash
            ydb table query execute \
              --query "SELECT * \
              FROM public_sensors"
            ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Деактивируйте](../operations/transfer.md#deactivate) и [удалите трансфер](../operations/transfer.md#delete).
    1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для приемника и источника.

    
    1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).


    1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).
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