# Выполнение аналитических запросов в {{ mpg-full-name }} с обработкой в {{ mch-full-name }} при помощи pg_clickhouse и {{ data-transfer-full-name }}

Вы можете выполнять аналитические запросы к данным из [{{ mpg-full-name }}](../../../managed-postgresql/index.yaml), используя для обработки запросов вычислительные ресурсы [{{ mch-full-name }}](../../../managed-clickhouse/index.yaml). Для этого в {{ mch-name }} с помощью [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml) создается копия данных из {{ mpg-name }}, которая затем поддерживается в актуальном состоянии. В базу данных {{ mpg-name }} добавляется расширение `pg_clickhouse`. С его помощью в {{ mpg-name }} создаются внешние таблицы, которые ссылаются на таблицы в {{ mch-name }}. Работать с внешними таблицами можно так же, как с обычными таблицами. Аналитические запросы к внешним таблицам выполняются в {{ mpg-name }} и обрабатываются на стороне {{ mch-name }}, после чего в {{ mpg-name }} возвращается результат этих запросов.

Расширение `pg_clickhouse` доступно в кластерах {{ mpg-name }} версии `17` и выше.

Чтобы выполнить аналитические запросы:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте тестовые данные](#prepare-test-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работу трансфера](#check-transfer).
1. [Настройте подключение к {{ mch-name }} и создайте внешние таблицы](#connect-clickhouse).
1. [Выполните аналитические запросы к внешним таблицам в {{ mpg-name }}](#execute-queries).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mpg-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mpg-name }}](../../../managed-postgresql/pricing.md)).
* Кластер {{ mch-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mch-name }}](../../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы {{ data-transfer-name }}](../../../data-transfer/pricing.md)).



## Подготовьте инфраструктуру {#infra}


{% include [public-access](../../../_includes/mdb/note-public-access.md) %}


1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `demo-network`.
    
    
    При создании сети автоматически создаются три подсети в разных зонах доступности.



1. В сети `demo-network` [создайте группу безопасности](../../../vpc/operations/security-group-create.md) `mch-sg` для кластера {{ mch-name }} и [добавьте](../../../vpc/operations/security-group-add-rule.md) в группу правила, необходимые для подключения к кластеру через интернет:
    
    * Правило для входящего трафика, которое разрешает подключение на порт `{{ port-mch-http }}`:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mch-http }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    * Правило для входящего трафика, которое разрешает подключение на порт `{{ port-mch-cli }}`:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mch-cli }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

1. В сети `demo-network` создайте группу безопасности `mpg-sg` для кластера {{ mpg-name }} и добавьте в группу следующие правила:

    * Правило для входящего трафика, которое разрешает подключение к кластеру через интернет:
         
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mpg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
    
    * Правило для исходящего трафика, которое разрешает подключение к {{ mch-name }}:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mch-cli }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.


1. [Создайте кластер {{ mch-name }}](../../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

    * **Сеть** — `demo-network`.
    
    
    * **Группа безопасности** — `mch-sg`.
    * Публичный доступ к хостам включен.
    

    * **База данных** — `chdb`.
    * **Пользователь** — `chuser`.

1. [Создайте кластер {{ mpg-name }}](../../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

    * **Версия** — `17` или выше.
    * **Сеть** — `demo-network`.

    
    * **Группа безопасности** — `mpg-sg`.
    * Публичный доступ к хостам включен.


    * **База данных** — `pgdb`.
    * **Пользователь** — `pguser`.

1. В кластере {{ mpg-name }} [добавьте расширение](../../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) `pg_clickhouse` в базу данных `pgdb`.

1. В кластере {{ mpg-name }} [назначьте](../../../managed-postgresql/operations/grant.md#grant-role) пользователю `pguser` следующие роли:

    * [mdb_replication](../../../managed-postgresql/concepts/roles.md#mdb-replication) — для репликации данных с помощью {{ data-transfer-name }}.
    * [mdb_admin](../../../managed-postgresql/concepts/roles.md#mdb-admin) — для подключения к {{ mch-name }} через `pg_clickhouse`.


## Подготовьте тестовые данные {#prepare-test-data}

1. [Подключитесь к кластеру {{ mpg-name }}](../../../managed-postgresql/operations/connect/clients.md).
1. Создайте таблицы `customers` и `orders`:
        
    ```sql
    CREATE TABLE public.customers (
      id INT PRIMARY KEY,
      name TEXT NOT NULL,
      city TEXT
    );

    CREATE TABLE public.orders (
      id INT PRIMARY KEY,
      customer_id INT NOT NULL,
      amount NUMERIC(10, 2) NOT NULL,
      order_date DATE NOT NULL,
      status TEXT NOT NULL
    );
    ```

1. Заполните таблицы данными:

    ```sql
    INSERT INTO public.customers (id, name, city) VALUES
    (1, 'Анна', 'Волгоград'),
    (2, 'Иван', 'Новосибирск'),
    (3, 'Виктория', 'Воронеж'),
    (4, 'Борис', 'Краснодар'),
    (5, 'Мария', 'Нижний Новгород');

    INSERT INTO public.orders (id, customer_id, amount, order_date, status) VALUES
    (1, 1, 1500.00, '2024-03-01', 'new'),
    (2, 2, 2300.50, '2024-03-02', 'new'),
    (3, 1, 999.99, '2024-03-03', 'completed'),
    (4, 3, 4500.00, '2024-03-04', 'shipped'),
    (5, 4, 1200.75, '2024-03-05', 'new'),
    (6, 5, 3100.25, '2024-03-06', 'shipped'),
    (7, 2, 1750.00, '2024-03-07', 'completed'),
    (8, 3, 800.00, '2024-03-08', 'new'),
    (9, 4, 5500.99, '2024-03-09', 'shipped'),
    (10, 5, 2200.00, '2024-03-10', 'completed');
    ```


## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../../data-transfer/operations/endpoint/index.md#create) для источника со следующими настройками:
    
    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ PG }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
    * **Кластер управляемой БД** — имя созданного ранее кластера {{ mpg-name }}.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `pgdb`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — `pguser`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — пароль пользователя `pguser`.

1. Создайте эндпоинт для приемника со следующими настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}** — имя созданного ранее кластера {{ mch-name }}.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `chdb`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — `chuser`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — пароль пользователя `chuser`.

1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create), использующий созданные эндпоинты. В качестве [типа](../../../data-transfer/concepts/index.md#transfer-type) трансфера выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}**.

1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate).

1. Дождитесь, пока трансфер перейдет в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.


## Проверьте работу трансфера {#check-transfer}

1. [Подключитесь к кластеру {{ mch-name }}](../../../managed-clickhouse/operations/connect/clients.md).
1. Проверьте, что в базе данных `chdb` созданы таблицы `customers` и `orders`:
        
    ```sql
    SHOW TABLES FROM chdb;
    ```
    
1. Проверьте, что данные загружены в таблицы:
        
    ```sql
    SELECT * FROM customers;
        
    SELECT * FROM orders;
    ```

1. В кластере {{ mpg-name }} добавьте запись в таблицу `orders`:
    
    ```sql
    INSERT INTO public.orders (id, customer_id, amount, order_date, status) VALUES
    (11, 1, 520.00, '2024-03-17', 'new');
    ```

1. Выполните запрос в кластере {{ mch-name }}, чтобы проверить, что новая запись появилась в таблице `orders`:
    
    ```sql
    SELECT * FROM orders;
    ```


## Настройте подключение к {{ mch-name }} и создайте внешние таблицы {#connect-clickhouse}

1. [Подключитесь к кластеру {{ mpg-name }}](../../../managed-postgresql/operations/connect/clients.md).
1. Создайте внешний источник данных:
    
    ```sql
    CREATE SERVER chserver
    FOREIGN DATA WRAPPER clickhouse_fdw
    OPTIONS (
      driver 'binary',
      host 'c-<идентификатор_кластера_Managed_Service_for_Clickhouse>.rw.mdb.yandexcloud.net',
      port '9440',
      dbname 'chdb'
    );
    ```

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. Создайте сопоставление локального пользователя с пользователем на внешнем источнике:
  
    ```sql
    CREATE USER MAPPING FOR CURRENT_USER
    SERVER chserver
    OPTIONS (
      user 'chuser',
      password '<пароль>'
    );
    ```

1. Создайте схему:
    
    ```sql
    CREATE SCHEMA mch;
    ```

1. Создайте в схеме `mch` внешние таблицы, которые будут ссылаться на таблицы в базе данных `chdb` в {{ mch-name }}:

    ```sql
    IMPORT FOREIGN SCHEMA chdb
    FROM SERVER chserver
    INTO mch;
    ```

1. Проверьте, что внешние таблицы созданы:
    
    ```sql
    SELECT *
    FROM information_schema.foreign_tables
    WHERE foreign_table_schema = 'mch';
    ```

    В выводе должны быть таблицы `customers` и `orders`.


## Выполните аналитические запросы к внешним таблицам в {{ mpg-name }} {#execute-queries}

1. Получите для каждого города количество заказов и их общую сумму:
    
    ```sql
    SELECT
      c.city,
      COUNT(*) AS orders_count,
      SUM(o.amount) AS total_amount
    FROM mch.orders o
    JOIN mch.customers c
      ON o.customer_id = c.id
    GROUP BY c.city
    ORDER BY total_amount DESC;
    ```

1. Постройте план выполнения запроса, чтобы убедиться, что он обрабатывается в {{ mch-name }}:

    ```sql
    EXPLAIN (VERBOSE, COSTS OFF)
    SELECT
      c.city,
      COUNT(*) AS orders_count,
      SUM(o.amount) AS total_amount
    FROM mch.orders o
    JOIN mch.customers c
      ON o.customer_id = c.id
    GROUP BY c.city
    ORDER BY total_amount DESC;
    ```

    Если в плане выполнения есть строки `Foreign Scan` и `Remote SQL`, то запрос обрабатывается в {{ mch-name }}.

    Пример плана выполнения:

    ```text
    QUERY PLAN
    ----------
    Foreign Scan
      Output: c.city, (count(*)), (sum(o.amount))
      Relations: Aggregate on ((orders o) INNER JOIN (customers c))
      Remote SQL: SELECT r2.city, count(*), sum(r1.amount) FROM chdb.orders r1 ALL INNER JOIN chdb.customers r2 ON (((r1.customer_id = r2.id))) GROUP BY r2.city ORDER BY sum(r1.amount) DESC NULLS FIRST
    Query Identifier: -6142969501942783
    ```


## Удалите созданные ресурсы {#clear-out}


Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:


1. [Деактивируйте](../../../data-transfer/operations/transfer.md#deactivate) и [удалите](../../../data-transfer/operations/transfer.md#delete) трансфер.
1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. [Удалите кластер {{ mch-name }}](../../../managed-clickhouse/operations/cluster-delete.md).
1. [Удалите кластер {{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}