# Интеграция Yandex Managed Service for ClickHouse® с Oracle через ClickHouse® JDBC Bridge

С помощью [ClickHouse® JDBC Bridge](https://clickhouse.com/docs/ru/integrations/jdbc/jdbc-with-clickhouse) вы можете:

* [Запрашивать данные](#jdbc-table-function) с помощью [функции JDBC Table Function](https://clickhouse.com/docs/ru/sql-reference/table-functions/jdbc) из таблицы внешней базы данных Oracle.
* [Создавать таблицы](#jdbc-table-engine) в ClickHouse® с помощью [JDBC Table Engine](https://clickhouse.com/docs/ru/engines/table-engines/integrations/jdbc), ссылающиеся на таблицу внешней базы данных Oracle.

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки решения входят:

* Плата за кластер Managed Service for ClickHouse®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства (см. [тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Плата за NAT-шлюз, если для хостов кластера не включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#deploy-infrastructure}

1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) и [настройте ее](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    Также добавьте правило для исходящего трафика:

    * **Диапазон портов** — `0-65535`;
    * **Протокол** — `TCP`;
    * **Источник** — `CIDR`;
    * **CIDR блоки** — `0.0.0.0/0`.

    Это правило разрешает любой исходящий трафик, что позволит ClickHouse® JDBC Bridge подключаться к внешним базам данных, в т. ч. к Oracle.

1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md).

    При создании кластера укажите группу безопасности, подготовленную ранее.

    В разделе **Настройки СУБД** нажмите **Настроить** и добавьте опцию **jdbcBridge** с параметрами:

    * **host** — IP-адрес вашей инсталляции базы данных Oracle;
    * **port** — `9019`.

1. Создайте [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети, в которой будет создан кластер Managed Service for ClickHouse®, если вы не используете публичный доступ.

## Подготовьте внешнюю базу данных Oracle {#prepare-source}

{% note warning %}

В приведенных ниже командах все сущности, создаваемые для базы данных Oracle, указываются в верхнем регистре согласно [правилам именования Oracle](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/Database-Object-Names-and-Qualifiers.html#GUID-75337742-67FD-4EC0-985F-741C93D918DA).

{% endnote %}

1. Убедитесь, что к вашей инсталляции внешней базы данных Oracle разрешено подключение по портам `9019` и `1521`.

1. Подключитесь к вашей инсталляции внешней базы данных Oracle и загрузите JDBC драйвер [ojdbc8](https://mvnrepository.com/artifact/com.oracle.database.jdbc/ojdbc8) в директорию `/opt/drivers`:

    ```bash
    sudo mkdir -p /opt/drivers && \
    curl -s https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/ | grep -oP '(?<=href=")[0-9][^/]+(?=/")' | sort -V | tail -n1 | xargs -I{} sudo curl -o /opt/drivers/ojdbc8-{}.jar https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/{}/ojdbc8-{}.jar
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

1. Подключитесь к внешней базе данных Oracle как [администратор](https://docs.oracle.com/en/database/oracle/oracle-database/21/admin/getting-started-with-database-administration.html#GUID-79AB6187-1522-4EB7-8FAD-E4322262AC65). Например, через SQL Plus, если вы подключаетесь локально:

    ```bash
    sqlplus / as sysdba
    ```

1. Смените сессию на нужную [PDB](https://docs.oracle.com/en/database/oracle/oracle-database/21/cncpt/CDBs-and-PDBs.html#GUID-49C0C90D-5A72-4131-8C3D-B07341C75CB2), например на `PDB1`:

    ```sql
    ALTER SESSION SET CONTAINER = PDB1;
    ```

1. Создайте пользователя `JDBC_USER`, от имени которого вы будете подключаться из кластера Managed Service for ClickHouse®:

    ```sql
    CREATE USER JDBC_USER IDENTIFIED BY <пароль_пользователя>
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA UNLIMITED ON USERS;
    ```

    Где `<пароль_пользователя>` — ваш пароль пользователя `JDBC_USER`.

    {% note tip %}

    Чтобы подключаться к разным PDB, создайте [общего пользователя](https://docs.oracle.com/en/database/oracle/oracle-database/21/dbseg/managing-security-for-oracle-database-users.html#GUID-A1A3989E-D769-4FFB-9CF2-77175FCE0FE5), добавив к его имени префикс `C##`. Например, `C##JDBC_USER`. 

    {% endnote %}

1. Выдайте права, необходимые для работы ClickHouse® JDBC Bridge:

    ```sql
    GRANT CONNECT, RESOURCE TO JDBC_USER;
    ```

1. Подключитесь от нового пользователя:

    ```sql
    CONNECT JDBC_USER/<пароль_пользователя>@<хост_Oracle_DB>/PDB1;
    ```

    Где:

    * `<пароль_пользователя>` — пароль пользователя `JDBC_USER`.
    * `<хост_Oracle_DB>` — IP-адрес вашей инсталляции базы данных Oracle.

1. Создайте тестовую таблицу с именем `CUSTOMERS`:

    ```sql
    CREATE TABLE CUSTOMERS (
      NAME       VARCHAR2(100),
      EMAIL      VARCHAR2(100)
    );
    ```

1. Добавьте тестовые данные:

    ```sql
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Angela Smith', 'angela@example.ru');
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Bob Johnson', 'bob@example.ru');
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Charlie Brown', 'charlie@example.ru');

    COMMIT;
    ```

1. Проверьте, что данные записались:

    ```sql
    SELECT * FROM CUSTOMERS;
    ```

## Запросите данные с помощью JDBC Table Function {#jdbc-table-function}

1. [Подключитесь к кластеру Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md).

1. Отправьте запрос к внешней базе данных Oracle с помощью JDBC Table Function:

    ```sql
    SELECT * FROM jdbc('jdbc:oracle:thin:JDBC_USER/<пароль_пользователя>@<хост_Oracle_DB>:1521/PDB1', 'SELECT * FROM CUSTOMERS');
    ```

    Где:

    * `<пароль_пользователя>` — пароль пользователя `JDBC_USER`.
    * `<хост_Oracle_DB>` — IP-адрес вашей инсталляции базы данных Oracle.

    Если запрос выполнен успешно, то вы получите данные из внешней базы данных Oracle.

## Создайте таблицу с помощью JDBC Table Engine {#jdbc-table-engine}

С помощью JDBC Table Engine вы можете:

* Запрашивать данные через `SELECT`.
* Добавлять новые значения через `INSERT INTO`, с ограничениями: 

    * Таблица в базе данных кластера Managed Service for ClickHouse® должна полностью повторять структуру таблицы, на которую ссылается. 
    * `INSERT INTO` — единственная доступная операция записи. Изменять уже существующие данные через `UPDATE`, `DELETE`, `ALTER` и т. п. — нельзя.
    * Если добавить новые записи и не указать в них значения для полей с автоматической генерацией (`DEFAULT`, `GENERATED BY`, `SYSDATE` и т. п.), эти значения сгенерированы не будут.

Чтобы использовать JDBC Table Engine:

1. [Подключитесь к кластеру Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md).

1. Создайте таблицу с JDBC Table Engine на основе таблицы из внешней базы данных Oracle.

    ```sql
    CREATE TABLE oracle_customers
    ENGINE = JDBC(
      'jdbc:oracle:thin:JDBC_USER/<пароль_пользователя>@<хост_Oracle_DB>:1521/XEPDB1',
      'JDBC_USER',
      'CUSTOMERS'
    )
    AS SELECT *
    FROM jdbc(
      'jdbc:oracle:thin:JDBC_USER/<пароль_пользователя>@<хост_Oracle_DB>:1521/XEPDB1',
      'JDBC_USER',
      'SELECT * FROM CUSTOMERS'
    )
    LIMIT 0;
    ```

    Вы также можете создать таблицу с указанием только части полей, однако в таком случае вы не сможете добавлять новые значения через `INSERT INTO`.

1. Проверьте результат:

    ```sql
    SELECT * FROM oracle_customers;
    ```

1. Вставьте новую строку:

    ```sql
    INSERT INTO oracle_customers (NAME, EMAIL)
      VALUES ('Alice Wonderland', 'alice@example.ru');
    ```

    ClickHouse® JDBC Bridge сам открывает транзакцию и закрывает её. Выполнять отдельно `COMMIT` не нужно.

1. Снова проверьте результат и сравните с предыдущим выводом:

    ```sql
    SELECT * FROM oracle_customers;
    ```

    Если вставка прошла успешно, вы увидите новую строку в полученном выводе.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
* [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._