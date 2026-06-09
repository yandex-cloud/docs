# Миграция базы данных из Yandex Managed Service for MySQL® в Yandex Managed Service for YDB с помощью Yandex Data Transfer

# Миграция данных со сменой хранилища из MySQL® в YDB с помощью Yandex Data Transfer


С помощью сервиса Data Transfer вы можете перенести данные из кластера-источника Managed Service for MySQL® в Managed Service for YDB.

Чтобы перенести данные:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for MySQL®](../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* База данных Managed Service for YDB (см. [тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

    * Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
    * Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервных копий.


## Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник Managed Service for MySQL®](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации.

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    
    1. Если вы используете группы безопасности, [настройте их](../../managed-kafka/operations/connect/index.md#configuring-security-groups) так, чтобы к кластеру можно было подключаться из интернета.



- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mmy-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-ydb/blob/main/data-transfer-mmy-ydb.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру Managed Service for MySQL®;
        * кластер-источник Managed Service for MySQL®;
        * база данных Managed Service for YDB;
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `data-transfer-mmy-ydb.tf`:

        * параметры кластера-источника Managed Service for MySQL®, которые будут использоваться как [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

            * `source_mysql_version` — версия MySQL®;
            * `source_db_name` — имя базы данных;
            * `source_user` и `source_password` — имя и пароль пользователя-владельца базы данных.

        * `target_db_name` — имя базы данных Managed Service for YDB.

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

1. Если создавали инфраструктуру вручную, [подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).

1. [Подключитесь к кластеру-источнику Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md).

1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию, поступающую от некоторых датчиков автомобиля.

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

    * **Тип базы данных** — `YDB`.
    * **Параметры эндпоинта**:

        * **Настройки подключения** → **База данных** — выберите базу данных Managed Service for YDB из списка.

        
        * **Идентификатор сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.


1. Создайте эндпоинт для источника и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `MySQL®`.
            * **Параметры эндпоинта** → **Настройки подключения** — `Кластер Managed Service for MySQL`.

                Выберите кластер-источник из списка и укажите настройки подключения к нему.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Копирование и репликация_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Раскомментируйте в файле `data-transfer-mmy-ydb.tf`:

            * переменную `target_endpoint_id` и задайте ей значение идентификатора эндпоинта для приемника, созданного на предыдущем шаге;
            * ресурсы `yandex_datatransfer_endpoint` и `yandex_datatransfer_transfer`.

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

1. Убедитесь, что в базу данных Managed Service for YDB перенеслись данные из кластера-источника Managed Service for MySQL®:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужная база данных.
        1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что база данных Managed Service for YDB содержит таблицу `<имя_БД_кластера-источника>_measurements` с тестовыми данными.

    - CLI {#cli}

        1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
        1. Проверьте, что база данных содержит таблицу `<имя_БД_кластера-источника>_measurements` с тестовыми данными:

            ```sql
            SELECT *
            FROM <имя_БД_кластера-источника>_measurements;
            ```

    {% endlist %}

1. [Подключитесь к кластеру-источнику Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md) и добавьте данные в таблицу `measurements`:

    ```sql
    INSERT INTO measurements VALUES
        ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что в базе данных Managed Service for YDB отобразились сведения о добавленной строке:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужная база данных.
        1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что в таблицу `<имя_БД_кластера-источника>_measurements` добавились новые данные.

    - CLI {#cli}

        1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
        1. Проверьте, что в таблицу `<имя_БД_кластера-источника>_measurements` добавились новые данные:

            ```sql
            SELECT *
            FROM <имя_БД_кластера-источника>_measurements;
            ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.


1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).


1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
       1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).
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