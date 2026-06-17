# Интеграция Yandex Managed Service for ClickHouse® с внешней базой данных Microsoft SQL Server через ClickHouse® JDBC Bridge

С помощью [ClickHouse® JDBC Bridge](https://clickhouse.com/docs/ru/integrations/jdbc/jdbc-with-clickhouse) вы можете:

* [Запрашивать данные](#jdbc-table-function) с помощью [функции JDBC Table Function](https://clickhouse.com/docs/ru/sql-reference/table-functions/jdbc) из таблицы внешней базы данных Microsoft SQL Server.
* [Создавать таблицы](#jdbc-table-engine) в ClickHouse® с помощью [JDBC Table Engine](https://clickhouse.com/docs/ru/engines/table-engines/integrations/jdbc), ссылающиеся на таблицу внешней базы данных Microsoft SQL Server.

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки решения входят:

* Плата за кластер Managed Service for ClickHouse®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Плата за NAT-шлюз, если для хостов кластера не включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#deploy-infrastructure}

1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) и [настройте ее](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    Также добавьте правило для исходящего трафика:

    * **Диапазон портов** — `0-65535`;
    * **Протокол** — `TCP`;
    * **Источник** — `CIDR`;
    * **CIDR блоки** — `0.0.0.0/0`.

    Это правило разрешает любой исходящий трафик, что позволит ClickHouse® JDBC Bridge подключаться к внешним базам данных, в т. ч. к Microsoft SQL Server.

1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md).

    При создании кластера укажите группу безопасности, подготовленную ранее.

    В разделе **Настройки СУБД** нажмите **Настроить** и добавьте опцию **jdbcBridge** с параметрами:

    * **host** — IP-адрес вашей инсталляции базы данных Microsoft SQL Server;
    * **port** — `9019`.

1. Создайте [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети, в которой будет создан кластер Managed Service for ClickHouse®, если вы не используете публичный доступ.

## Подготовьте внешнюю базу данных Microsoft SQL Server {#prepare-source}

1. Убедитесь, что к вашей инсталляции внешней базы данных Microsoft SQL Server разрешено подключение по портам `9019` и `1433`.

1. Подключитесь к вашей инсталляции внешней базы данных Microsoft SQL Server и загрузите [JDBC драйвер](https://mvnrepository.com/artifact/com.microsoft.sqlserver/mssql-jdbc) в директорию `/opt/drivers`:

    ```bash
    sudo mkdir -p /opt/drivers && \
    curl -s https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/ | grep -oP '(?<=href=")[^"]+(?=/")' | grep 'jre8$' | grep -v 'preview' | sort -V | tail -n1 | xargs -I{} bash -c 'ver="{}"; file=$(curl -s https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/$ver/ | grep -oP "(?<=href=\")[^\"]+\.jar" | grep -vE "javadoc|sources" | head -n1); sudo curl -o /opt/drivers/$file https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/$ver/$file'
    ```

1. Установите [Docker Engine](https://docs.docker.com/engine/install/).

1. Запустите ClickHouse® JDBC Bridge:

    ```bash
    docker run -d --name jdbc_bridge --network host -v /opt/drivers:/app/drivers clickhouse/jdbc-bridge
    ```

    Если у вас уже запущен контейнер, перезапустите его, чтобы новые драйверы загрузились в ClickHouse® JDBC Bridge:

    ```bash
    docker container restart jdbc_bridge
    ```

1. Создайте файл `init.sql` следующего содержания:

    ```sql
    CREATE LOGIN jdbc_user WITH PASSWORD = '<пароль_пользователя>';
    GO
    CREATE DATABASE mydb;
    GO
    USE mydb;
    GO
    CREATE USER jdbc_user FOR LOGIN jdbc_user;
    GO
    ALTER ROLE db_owner ADD MEMBER jdbc_user;
    GO
    CREATE SCHEMA jdbc_schema AUTHORIZATION jdbc_user;
    GO
    ALTER USER jdbc_user WITH DEFAULT_SCHEMA = jdbc_schema;
    GO
    ```

    Где `<пароль_пользователя>` должен быть длиной минимум 8 символов и содержать хотя бы три из четырех типов:

    * буквы верхнего регистра;
    * буквы нижнего регистра;
    * цифры;
    * спецсимволы.

1. Выполните скрипт `init.sql` через `sqlcmd` от имени административного пользователя `SA`:

    ```bash
    sqlcmd -S <хост_Microsoft_SQL_Server> -U SA -P '<пароль_администратора>' -i init.sql
    ```

    Где:
    
    * `<хост_Microsoft_SQL_Server>` — IP-адрес вашей инсталляции Microsoft SQL Server.
    * `<пароль_администратора>` — пароль от административной учетной записи `SA`.

    В результате его выполнения будут созданы:
    
    * база данных `mydb`;
    * пользователь `jdbc_user`;
    * схема `jdbc_schema`.

1. Подключитесь от имени нового пользователя `jdbc_user`:

    ```bash
    sqlcmd -S <хост_Microsoft_SQL_Server> -U jdbc_user -P '<пароль_пользователя>' -i init.sql
    ```

1. Создайте набор тестовых данных:

    ```sql
    CREATE TABLE Employees (
        Id INT PRIMARY KEY IDENTITY(1,1),
        Name NVARCHAR(100),
        Position NVARCHAR(100),
        Salary DECIMAL(10,2)
    );
    GO

    INSERT INTO Employees (Name, Position, Salary) VALUES
    ('Alice Johnson', 'Developer', 75000),
    ('Bob Smith', 'Manager', 90000),
    ('Charlie Rose', 'Analyst', 65000);
    GO

    SELECT * FROM Employees;
    GO
    ```

## Запросите данные с помощью JDBC Table Function {#jdbc-table-function}

1. [Подключитесь к кластеру Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md).

1. Отправьте запрос к внешней базе данных Microsoft SQL Server с помощью JDBC Table Function:

    ```sql
    SELECT * FROM jdbc('jdbc:sqlserver://<хост_Microsoft_SQL_Server_DB>:1433;databaseName=mydb;user=jdbc_user;password=<пароль_пользователя>;encrypt=false;', 'jdbc_schema', 'Employees')
    ```

    Где:

    * `<пароль_пользователя>` — пароль пользователя `jdbc_user`.
    * `<хост_Microsoft_SQL_Server_DB>` — IP-адрес вашей инсталляции базы данных Microsoft SQL Server.

    Если запрос выполнен успешно, то вы получите данные из внешней базы данных Microsoft SQL Server.

## Создайте таблицу с помощью JDBC Table Engine {#jdbc-table-engine}

С помощью JDBC Table Engine вы можете запрашивать данные через `SELECT`. Чтобы использовать JDBC Table Engine:

1. [Подключитесь к кластеру Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md).

1. Создайте таблицу с JDBC Table Engine на основе таблицы из внешней базы данных Microsoft SQL Server.

    ```sql
    CREATE TABLE mssql_employees
    (
        Id Int32,
        Name String,
        Position String,
        Salary Decimal(10, 2)
    )
    ENGINE = JDBC(
        'jdbc:sqlserver://<хост_Microsoft_SQL_Server_DB>:1433;databaseName=mydb;user=jdbc_user;password=<пароль_пользователя>;encrypt=false;',
        'jdbc_schema',
        'Employees'
    );
    ```

    Вы также можете создать таблицу с частичным указанием полей.

1. Проверьте результат:

    ```sql
    SELECT * FROM mssql_employees;
    ```

    Если таблица создалась корректно, то вы увидите вывод данных из таблицы внешней базы данных Microsoft SQL Server.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
* [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._