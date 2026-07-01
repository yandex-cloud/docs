# Миграция данных из Yandex Managed Service for MySQL® в Managed Service for PostgreSQL с помощью Yandex Data Transfer

Вы можете настроить перенос данных из базы Managed Service for MySQL® в базу Managed Service for PostgreSQL с помощью сервиса Data Transfer. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../../managed-postgresql/pricing.md)).
* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for MySQL®](../../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ ([тарифы Virtual Private Cloud](../../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте кластер-источник Managed Service for MySQL®](../../managed-mysql/operations/cluster-create.md#create-cluster) в любой [зоне доступности](../../overview/concepts/geo-scope.md), с хостами любой подходящей конфигурации в публичном доступе, и следующими настройками:

        * **Имя БД** — `mmy_db`.
        * **Имя пользователя** — `mmy_user`.
        * **Пароль** — `<пароль_источника>`.

    1. [Выдайте административные привилегии](../../managed-mysql/operations/grant.md#grant-privilege) `REPLICATION CLIENT` и `REPLICATION SLAVE` пользователю `mmy_user`.

        Подробнее об административных привилегиях смотрите в [описании настроек](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

    1. В той же зоне доступности [создайте кластер-приемник Managed Service for PostgreSQL](../operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

        * **Имя БД** — `mpg_db`.
        * **Имя пользователя** — `mpg_user`.
        * **Пароль** — `<пароль_приемника>`.

    1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:

        * [Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md#configuring-security-groups).
        * [Managed Service for PostgreSQL](../operations/connect/index.md#configuring-security-groups).

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [mysql-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-postgresql/blob/main/mysql-postgresql.tf).

        В этом файле описаны:

        * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;
        * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;
        * кластер-источник Managed Service for MySQL®;
        * кластер-приемник Managed Service for PostgreSQL;
        * эндпоинты для источника и приемника;
        * трансфер.

    1. Укажите в файле `mysql-postgresql.tf`:

        * Версии MySQL® и PostgreSQL.
        * Пароли пользователей MySQL® и PostgreSQL.

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

1. [Подключитесь к базе данных в кластере-источнике Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md).

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

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/mysql.md) типа `MySQL®` и укажите в нем параметры подключения к кластеру:

        * **Тип подключения** — `Кластер Managed Service for MySQL`.
        * **Кластер Managed Service for MySQL** — `<имя_кластера_источника_MySQL®>` из выпадающего списка.
        * **База данных** — `mmy_db`.
        * **Пользователь** — `mmy_user`.
        * **Пароль** — `<пароль_пользователя>`.

    1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/postgresql.md) типа `PostgreSQL` и укажите в нем параметры подключения к кластеру:

        * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
        * **Кластер Managed Service for PostgreSQL** — `<имя_кластера_приемника_PostgreSQL>` из выпадающего списка.
        * **База данных** — `mpg_db`.
        * **Пользователь** — `mpg_user`.
        * **Пароль** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Копирование и репликация_**, использующий созданные эндпоинты.
    1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.

- Terraform {#tf}

    1. Укажите в файле `mysql-postgresql.tf` значение `1` для параметра `transfer_enabled`.

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

1. [Подключитесь к базе данных в кластере-приемнике Managed Service for PostgreSQL](../operations/connect/index.md).
1. Выполните запрос:

    ```sql
    SELECT * FROM mmy_db.measurements;
    ```

### Проверьте работу репликации {#verify-replication}

1. [Подключитесь к базе данных в кластере-источнике Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md).
1. Добавьте данные в таблицу `measurements`:

    ```sql
    INSERT INTO measurements VALUES
    ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что добавленная строка появилась в базе данных приемника:

    1. [Подключитесь к базе данных в кластере-приемнике Managed Service for PostgreSQL](../operations/connect/index.md).
    1. Выполните запрос:

        ```sql
        SELECT * FROM mmy_db.measurements;
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).
    1. [Удалите кластер Managed Service for MySQL®](../../managed-mysql/operations/cluster-delete.md).
    1. [Удалите кластер Managed Service for PostgreSQL](../operations/cluster-delete.md).

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