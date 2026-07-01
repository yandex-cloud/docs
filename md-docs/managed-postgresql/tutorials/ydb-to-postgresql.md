# Загрузка данных из Yandex Managed Service for YDB в Yandex Managed Service for PostgreSQL

# Загрузка данных из Yandex Managed Service for YDB в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer

С помощью сервиса Data Transfer вы можете загружать данные из базы данных Managed Service for YDB в кластер Managed Service for PostgreSQL.

Чтобы загрузить данные:

1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* База данных Managed Service for YDB ([тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

    * Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
    * Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../../vpc/pricing.md)).

## Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) `ydb1` любой подходящей конфигурации.
    1. [Создайте кластер Managed Service for PostgreSQL](../operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

        * **Имя БД** — `db1`.
        * **Имя пользователя** — `user1`.

    1. Если вы используете группы безопасности в кластере, убедитесь, что они настроены правильно и допускают подключение к кластеру [Managed Service for PostgreSQL](../operations/connect/index.md#configuring-security-groups).

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `ydb-account` и ролью `ydb.editor`. Трансфер будет использовать его для доступа к базе данных.

- С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [ydb-to-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-ydb-to-postgresql/blob/main/ydb-to-postgresql.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for PostgreSQL из интернета;
        * база данных Managed Service for YDB;
        * кластер-приемник Managed Service for PostgreSQL;
        * эндпоинт для источника;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `ydb-to-postgresql.tf` параметры:

        * `mpg_version` — версия PostgreSQL.
        * `mpg_password` — пароль пользователя-владельца базы данных PostgreSQL.

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

    1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/source/ydb.md#endpoint-settings) типа `YDB` и укажите в нем параметры подключения к базе данных:

        * **Настройки подключения**:
            * **База данных** — выберите базу данных Managed Service for YDB `ydb1` из списка.
            * **Идентификатор сервисного аккаунта** — выберите сервисный аккаунт `ydb-account`.

        * **Список включенных путей** — укажите таблицу `table1`.

    1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/target/postgresql.md#endpoint-settings) типа `PostgreSQL` и укажите в нем параметры подключения к кластеру:

        * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
        * **Кластер Managed Service for PostgreSQL** — выберите [созданный ранее](#deploy-infrastructure) кластер PostgreSQL из списка.
        * **База данных** — `db1`.
        * **Пользователь** — `user1`.
        * **Пароль** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Копирование и репликация_**, использующий созданные эндпоинты.

    1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.

- С помощью Terraform {#tf}

    1. Укажите в файле `ydb-to-postgresql.tf` значение `1` для параметра `transfer_enabled`.

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

1. [Подключитесь к базе данных](../operations/connect/clients.md) `db1` в кластере-приемнике Managed Service for PostgreSQL.

1. Выполните запрос:

    ```sql
    SELECT * FROM table1;
    ```

    {% cut "Пример ответа" %}

    ```sql
    # | Id | Name   |
    --+----+--------+
    1 | 1  | Anna   |
    2 | 2  | Robert |
    3 | 3  | Umar   |
    4 | 4  | Algul  |
    5 | 5  | Viktor |
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

    1. [Подключитесь к базе данных](../operations/connect/clients.md) `db1` в кластере-приемнике Managed Service for PostgreSQL.

    1. Выполните запрос:

        ```sql
        SELECT * FROM table1;
        ```

        {% cut "Пример ответа" %}

        ```sql
        # | Id  | Name    |
        --+-----+---------+
        1 |  1  |  Anna   |
        2 |  2  |  Robert |
        3 |  3  |  Umar   |
        4 |  4  |  Algul  |
        5 |  5  |  Viktor |
        6 |  6  |  Maria  |
        7 |  7  |  Alex   |
        ```

        {% endcut %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).
    1. [Удалите кластер Managed Service for PostgreSQL](../operations/cluster-delete.md).

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