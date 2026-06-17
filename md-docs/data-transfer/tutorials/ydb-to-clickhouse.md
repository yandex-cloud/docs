# Загрузка данных из YDB в витрину ClickHouse®

# Загрузка данных из Yandex Managed Service for YDB в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer


С помощью сервиса Data Transfer вы можете загружать данные из базы данных Managed Service for YDB в кластер Managed Service for ClickHouse®.

Чтобы загрузить данные:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* База данных Managed Service for YDB ([тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

    * Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
    * Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Кластер Managed Service for ClickHouse®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) `ydb1` любой подходящей конфигурации.
    1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

        * **Имя БД** — `db1`.
        * **Имя пользователя** — `user1`.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `ydb-account` и ролью `ydb.editor`. Трансфер будет использовать его для доступа к базе данных.


- С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [ydb-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-ydb-to-clickhouse/blob/main/ydb-to-clickhouse.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for ClickHouse® из интернета;
        * база данных Managed Service for YDB;
        * кластер-приемник Managed Service for ClickHouse®;
        * эндпоинт для источника;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `ydb-to-clickhouse.tf` параметры:

        * `mch_version` — версия ClickHouse®.
        * `mch_password` — пароль пользователя-владельца базы данных ClickHouse®.

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

1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
1. [Создайте строковую таблицу](../../ydb/operations/schema.md#create-table) `table1` со следующими колонками:

    | Имя | Тип | Первичный ключ |
    |:-------|:--------|:-------|
    | `Id`   | `Int64` | Да     |
    | `Name` | `Utf8`  |        |

    Вы также можете создать таблицу [с помощью SQL-запроса](../../ydb/operations/crud.md#web-sql):

    ```sql
    CREATE TABLE table1 (
        Id Int64,
        Name Utf8,
        PRIMARY KEY (Id)
    )
    ```

1. [Заполните таблицу данными](../../ydb/operations/crud.md#change-data) с помощью SQL-запроса:

    ```sql
    INSERT INTO table1 (Id, Name)
    VALUES
        (1, "Anna"),
        (2, "Robert"),
        (3, "Umar"),
        (4, "Algul"),
        (5, "Viktor");
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт для источника](../operations/endpoint/source/ydb.md#endpoint-settings) типа `YDB` и укажите в нем параметры подключения к базе данных:

        * **Настройки подключения**:
            * **База данных** — выберите базу данных Managed Service for YDB из списка.

            
            * **Идентификатор сервисного аккаунта** — выберите сервисный аккаунт `ydb-account`.


        * **Список включенных путей** — укажите таблицу `table1`.

    1. [Создайте эндпоинт для приемника](../operations/endpoint/target/clickhouse.md#endpoint-settings) типа `ClickHouse®` и укажите в нем параметры подключения к кластеру:

        * **Тип подключения** — `Кластер Managed Service for ClickHouse`.
        * **Managed кластер** — `<имя_кластера_приемника_ClickHouse®>` из выпадающего списка.
        * **База данных** — `db1`.
        * **Пользователь** — `user1`.
        * **Пароль** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../operations/transfer.md#create) типа **_Копирование и репликация_**, использующий созданные эндпоинты.

    1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.

- С помощью Terraform {#tf}

    1. Укажите в файле `ydb-to-clickhouse.tf` значение `1` для параметра `transfer_enabled`.

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

Чтобы убедиться в работоспособности трансфера, проверьте работу копирования и репликации.

### Проверьте работу копирования {#verify-copy}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` в кластере-приемнике Managed Service for ClickHouse®.

1. Выполните запрос:

    ```sql
    SELECT * FROM db1.table1;
    ```

    {% cut "Пример ответа" %}

    ```sql
    # | Id  | Name     | __data_transfer_commit_time | __data_transfer_delete_time
    --+-----+----------+-----------------------------+----------------------------
    1 | "1" | "Anna"   | "1722023098109014844"       | "0"
    2 | "2" | "Robert" | "1722023098109014844"       | "0"
    3 | "3" | "Umar"   | "1722023098109014844"       | "0"
    4 | "4" | "Algul"  | "1722023098109014844"       | "0"
    5 | "5" | "Viktor" | "1722023098109014844"       | "0"
    ```

    {% endcut %}

### Проверьте работу репликации {#verify-replication}

1. [Подключитесь к базе данных Managed Service for YDB](../../ydb/operations/connection.md).

1. [Добавьте данные в таблицу](../../ydb/operations/crud.md#change-data) `table1`:

    ```sql
    INSERT INTO table1 (Id, Name)
    VALUES
        (6, "Maria"),
        (7, "Alex");
    ```

1. Убедитесь, что новые данные появились в базе данных приемника:

    1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` в кластере-приемнике Managed Service for ClickHouse®.

    1. Выполните запрос:

        ```sql
        SELECT * FROM db1.table1;
        ```

        {% cut "Пример ответа" %}

        ```sql
        # | Id  | Name     | __data_transfer_commit_time | __data_transfer_delete_time
        --+-----+----------+-----------------------------+----------------------------
        1 | "1" | "Anna"   | "1722023098109014844"       | "0"
        2 | "2" | "Robert" | "1722023098109014844"       | "0"
        3 | "3" | "Umar"   | "1722023098109014844"       | "0"
        4 | "4" | "Algul"  | "1722023098109014844"       | "0"
        5 | "5" | "Viktor" | "1722023098109014844"       | "0"
        6 | "6" | "Maria"  | "1722023655224000000"       | "0"
        7 | "7" | "Alex"   | "1722023655225000000"       | "0"
        ```

        {% endcut %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите трансфер](../operations/transfer.md#delete).
    1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.
    1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).
    1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).

    
    1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).


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

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._