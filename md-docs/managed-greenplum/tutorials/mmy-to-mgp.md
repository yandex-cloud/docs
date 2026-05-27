# Миграция данных из Yandex Managed Service for MySQL® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer

# Миграция данных из Yandex Managed Service for MySQL® в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer

Вы можете настроить перенос данных из базы Yandex Managed Service for MySQL® в базу Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Создайте базу данных в кластере-приемнике](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for MySQL®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for MySQL®](../../managed-mysql/pricing.md)).
* Кластер Yandex MPP Analytics for PostgreSQL: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Yandex MPP Analytics for PostgreSQL](../pricing/index.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы Data Transfer](../../data-transfer/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

* Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте кластер-источник Managed Service for MySQL®](../../managed-mysql/operations/cluster-create.md#create-cluster) в любой [зоне доступности](../../overview/concepts/geo-scope.md), с хостами любой подходящей конфигурации в публичном доступе и следующими настройками:

        * **Имя БД** — `mmy_db`.
        * **Имя пользователя** — `mmy_user`.
        * **Пароль** — `<пароль_источника>`.

    1. [Выдайте административные привилегии](../../managed-mysql/operations/grant.md#grant-privilege) `REPLICATION CLIENT` и `REPLICATION SLAVE` пользователю `mmy_user`.

        Подробнее об административных привилегиях читайте в [описании настроек](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

    1. В той же зоне доступности [создайте кластер-приемник Greenplum®](../operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

        * **Имя пользователя** — `mgp_user`.
        * **Пароль** — `<пароль_приемника>`.
        * **Доступ из Data Transfer** — включен.

    1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:

        * [Managed Service for MySQL®](../../managed-mysql/operations/connect/index.md#configure-security-groups).
        * [Yandex MPP Analytics for PostgreSQL](../operations/connect/index.md#configuring-security-groups).

* С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [mmy-to-mgp.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-greenplum/blob/main/mmy-to-mgp.tf).

        В этом файле описаны:

        * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;
        * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;
        * кластер-источник Managed Service for MySQL®;
        * кластер-приемник Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL;
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `mmy-to-mgp.tf`:

        * Версии MySQL® и Greenplum®.
        * Пароли пользователей MySQL® и Greenplum®.

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

1. [Подключитесь к базе данных](../../managed-mysql/operations/connect/index.md) `mmy_db` в кластере-источнике Managed Service for MySQL®.

1. Создайте простую таблицу `table1`:

    ```sql
    CREATE TABLE table1 (
    id int NOT NULL,
    name varchar (10),
    PRIMARY KEY (id)
    );
    ```

1. Наполните таблицу данными:

    ```sql
    INSERT INTO table1 VALUES
    (1, 'Name1'),
    (2, 'Name2'),
    (3, 'Name3');
    ```

## Создайте базу данных в кластере-приемнике {#prepare-data}

1. [Подключитесь к служебной базе данных](../operations/connect/index.md) `postgres` в кластере-приемнике Greenplum® от имени пользователя `mgp_user`.

1. Создайте базу данных `mgp_db`:

    ```sql
    CREATE DATABASE mgp_db;
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/greenplum.md) типа `Greenplum®` и укажите в нем параметры подключения к кластеру:

    * **Тип подключения** — `Кластер Managed Service for Greenplum`.
    * **Кластер Managed Service for Greenplum** — `<имя_кластера_приемника_Greenplum®>` из выпадающего списка.
    * **База данных** — `mgp_db`.
    * **Пользователь** — `mgp_user`.
    * **Пароль** — `<пароль_пользователя>`.

1. Создайте эндпоинт-источник и трансфер:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/mysql.md) типа `MySQL®` и укажите в нем параметры подключения к кластеру:

            * **Тип подключения** — `Кластер Managed Service for MySQL`.
            * **Кластер Managed Service for MySQL** — `<имя_кластера_источника_MySQL®>` из выпадающего списка.
            * **База данных** — `mmy_db`.
            * **Пользователь** — `mmy_user`.
            * **Пароль** — `<пароль_пользователя>`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Копирование и репликация_**, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.

    * С помощью Terraform {#tf}

        1. Укажите в файле `mmy-to-mgp.tf` значения параметров:

            * `target_endpoint_id` — идентификатор эндпоинта для приемника.
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

1. [Подключитесь к базе данных](../operations/connect/index.md) `mgp_db` в кластере-приемнике Greenplum®.

1. Выполните запрос:

    ```sql
    SELECT * FROM mmy_db.table1;
    ```

### Проверьте работу репликации {#verify-replication}

1. [Подключитесь к базе данных](../../managed-mysql/operations/connect/index.md) `mmy_db` в кластере-источнике Managed Service for MySQL®.

1. Добавьте данные в таблицу `table1`:

    ```sql
    INSERT INTO table1 VALUES
    (4, 'Name4');
    ```

1. Убедитесь, что добавленная строка появилась в базе данных приемника:

    1. [Подключитесь к базе данных](../operations/connect/index.md) `mgp_db` в кластере-приемнике Greenplum®.
    1. Выполните запрос:

        ```sql
        SELECT * FROM mmy_db.table1;
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
    1. [Удалите кластер Greenplum®](../operations/cluster-delete.md).

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