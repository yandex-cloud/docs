[Документация Yandex Cloud](../../index.md) > [Yandex Data Transfer](../index.md) > [Практические руководства](index.md) > Загрузка данных в витрины > Выполнение аналитических запросов в Managed Service for PostgreSQL с помощью Managed Service for ClickHouse® и Data Transfer

# Выполнение аналитических запросов в Yandex Managed Service for PostgreSQL с обработкой в Yandex Managed Service for ClickHouse® при помощи pg_clickhouse и Yandex Data Transfer

# Выполнение аналитических запросов в Yandex Managed Service for PostgreSQL с обработкой в Yandex Managed Service for ClickHouse® при помощи pg_clickhouse и Yandex Data Transfer

Вы можете выполнять аналитические запросы к данным из [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md), используя для обработки запросов вычислительные ресурсы [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md). Для этого в Managed Service for ClickHouse® с помощью [Yandex Data Transfer](../index.md) создается копия данных из Managed Service for PostgreSQL, которая затем поддерживается в актуальном состоянии. В базу данных Managed Service for PostgreSQL добавляется расширение `pg_clickhouse`. С его помощью в Managed Service for PostgreSQL создаются внешние таблицы, которые ссылаются на таблицы в Managed Service for ClickHouse®. Работать с внешними таблицами можно так же, как с обычными таблицами. Аналитические запросы к внешним таблицам выполняются в Managed Service for PostgreSQL и обрабатываются на стороне Managed Service for ClickHouse®, после чего в Managed Service for PostgreSQL возвращается результат этих запросов.

Расширение `pg_clickhouse` доступно в кластерах Managed Service for PostgreSQL версии `17` и выше.

Чтобы выполнить аналитические запросы:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте тестовые данные](#prepare-test-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работу трансфера](#check-transfer).
1. [Настройте подключение к Managed Service for ClickHouse® и создайте внешние таблицы](#connect-clickhouse).
1. [Выполните аналитические запросы к внешним таблицам в Managed Service for PostgreSQL](#execute-queries).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for PostgreSQL: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Кластер Managed Service for ClickHouse®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы Data Transfer](../pricing.md)).



## Подготовьте инфраструктуру {#infra}


{% note info %}

Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.

{% endnote %}


1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `demo-network`.
    
    
    При создании сети автоматически создаются три подсети в разных зонах доступности.



1. В сети `demo-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) `mch-sg` для кластера Managed Service for ClickHouse® и [добавьте](../../vpc/operations/security-group-add-rule.md) в группу правила, необходимые для подключения к кластеру через интернет:
    
    * Правило для входящего трафика, которое разрешает подключение на порт `8443`:

      * **Диапазон портов** — `8443`.
      * **Протокол** — `TCP`.
      * **Назначение** — `Диапазон адресов`.
      * **IPv4 CIDR** — `0.0.0.0/0`.

    * Правило для входящего трафика, которое разрешает подключение на порт `9440`:

      * **Диапазон портов** — `9440`.
      * **Протокол** — `TCP`.
      * **Назначение** — `Диапазон адресов`.
      * **IPv4 CIDR** — `0.0.0.0/0`.

1. В сети `demo-network` создайте группу безопасности `mpg-sg` для кластера Managed Service for PostgreSQL и добавьте в группу следующие правила:

    * Правило для входящего трафика, которое разрешает подключение к кластеру через интернет:
         
      * **Диапазон портов** — `6432`.
      * **Протокол** — `TCP`.
      * **Назначение** — `Диапазон адресов`.
      * **IPv4 CIDR** — `0.0.0.0/0`.
    
    * Правило для исходящего трафика, которое разрешает подключение к Managed Service for ClickHouse®:

      * **Диапазон портов** — `9440`.
      * **Протокол** — `TCP`.
      * **Назначение** — `Диапазон адресов`.
      * **IPv4 CIDR** — `0.0.0.0/0`.


1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

    * **Сеть** — `demo-network`.
    
    
    * **Группа безопасности** — `mch-sg`.
    * Публичный доступ к хостам включен.
    

    * **База данных** — `chdb`.
    * **Пользователь** — `chuser`.

1. [Создайте кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

    * **Версия** — `17` или выше.
    * **Сеть** — `demo-network`.

    
    * **Группа безопасности** — `mpg-sg`.
    * Публичный доступ к хостам включен.


    * **База данных** — `pgdb`.
    * **Пользователь** — `pguser`.

1. В кластере Managed Service for PostgreSQL [добавьте расширение](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) `pg_clickhouse` в базу данных `pgdb`.

1. В кластере Managed Service for PostgreSQL [назначьте](../../managed-postgresql/operations/grant.md#grant-role) пользователю `pguser` следующие роли:

    * [mdb_replication](../../managed-postgresql/concepts/roles.md#mdb-replication) — для репликации данных с помощью Data Transfer.
    * [mdb_admin](../../managed-postgresql/concepts/roles.md#mdb-admin) — для подключения к Managed Service for ClickHouse® через `pg_clickhouse`.


## Подготовьте тестовые данные {#prepare-test-data}

1. [Подключитесь к кластеру Managed Service for PostgreSQL](../../managed-postgresql/operations/connect/clients.md).
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

1. [Создайте эндпоинт](../operations/endpoint/index.md#create) для источника со следующими настройками:
    
    * **Тип базы данных** — `PostgreSQL`.
    * **Тип подключения** — `Ручная настройка`.
    * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
    * **Кластер управляемой БД** — имя созданного ранее кластера Managed Service for PostgreSQL.
    * **База данных** — `pgdb`.
    * **Пользователь** — `pguser`.
    * **Пароль** — пароль пользователя `pguser`.

1. Создайте эндпоинт для приемника со следующими настройками:

    * **Тип базы данных** — `ClickHouse`.
    * **Тип подключения** — `Ручная настройка`.
    * **Тип инсталляции** — `Кластер Managed Service for ClickHouse`.
    * **Managed кластер** — имя созданного ранее кластера Managed Service for ClickHouse®.
    * **База данных** — `chdb`.
    * **Пользователь** — `chuser`.
    * **Пароль** — пароль пользователя `chuser`.

1. [Создайте трансфер](../operations/transfer.md#create), использующий созданные эндпоинты. В качестве [типа](../concepts/index.md#transfer-type) трансфера выберите **Копирование и репликация**.

1. [Активируйте трансфер](../operations/transfer.md#activate).

1. Дождитесь, пока трансфер перейдет в статус **Реплицируется**.


## Проверьте работу трансфера {#check-transfer}

1. [Подключитесь к кластеру Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/clients.md).
1. Проверьте, что в базе данных `chdb` созданы таблицы `customers` и `orders`:
        
    ```sql
    SHOW TABLES FROM chdb;
    ```
    
1. Проверьте, что данные загружены в таблицы:
        
    ```sql
    SELECT * FROM customers;
        
    SELECT * FROM orders;
    ```

1. В кластере Managed Service for PostgreSQL добавьте запись в таблицу `orders`:
    
    ```sql
    INSERT INTO public.orders (id, customer_id, amount, order_date, status) VALUES
    (11, 1, 520.00, '2024-03-17', 'new');
    ```

1. Выполните запрос в кластере Managed Service for ClickHouse®, чтобы проверить, что новая запись появилась в таблице `orders`:
    
    ```sql
    SELECT * FROM orders;
    ```


## Настройте подключение к Managed Service for ClickHouse® и создайте внешние таблицы {#connect-clickhouse}

1. [Подключитесь к кластеру Managed Service for PostgreSQL](../../managed-postgresql/operations/connect/clients.md).
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

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

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

1. Создайте в схеме `mch` внешние таблицы, которые будут ссылаться на таблицы в базе данных `chdb` в Managed Service for ClickHouse®:

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


## Выполните аналитические запросы к внешним таблицам в Managed Service for PostgreSQL {#execute-queries}

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

1. Постройте план выполнения запроса, чтобы убедиться, что он обрабатывается в Managed Service for ClickHouse®:

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

    Если в плане выполнения есть строки `Foreign Scan` и `Remote SQL`, то запрос обрабатывается в Managed Service for ClickHouse®.

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


1. [Деактивируйте](../operations/transfer.md#deactivate) и [удалите](../operations/transfer.md#delete) трансфер.
1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.
1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
1. [Удалите кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-delete.md).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._