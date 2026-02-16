# Получение данных из внешних источников с помощью именованных запросов

В {{ GP }} для получения данных из внешних СУБД по протоколу [PXF](../../../managed-greenplum/concepts/external-tables.md) можно использовать именованные запросы (named queries).

Именованный запрос — это заранее подготовленный SQL-запрос, который хранится в таблице `mdb_toolkit.pxf_named_queries` системной базы данных кластера {{ GP }}. Ссылка на имя запроса указывается при создании внешней таблицы.

Именованные запросы позволяют объединять (JOIN) таблицы и агрегировать данные во внешнем источнике, когда нет возможности создать представление (VIEW). Поскольку вычисления выполняются во внешнем источнике, это также повышает производительность кластера.

Именованные запросы используются с источниками данных, подключенными к кластеру {{ GP }} через JDBC-коннектор.

Чтобы получить данные из внешнего источника с помощью именованного запроса:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Создайте внешний источник данных](#create-jdbc-source).
1. [Создайте именованный запрос](#create-named-query).
1. [Создайте внешнюю таблицу и получите из нее данные](#create-ext-table).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).



## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ GP }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mgp-name }}](../../../managed-greenplum/pricing/index.md)).
* Плата за кластер {{ mpg-full-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../../managed-postgresql/pricing.md)).
* Плата за почасовое использование NAT-шлюзов и исходящий через них трафик (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).
* Плата за использование публичных IP-адресов (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер](../../../managed-greenplum/operations/cluster-create.md) {{ GP }} любой подходящей конфигурации.
    
    1. В [подсети](../../../vpc/concepts/network.md#subnet) кластера {{ GP }} [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.

    1. [Создайте кластер](../../../managed-postgresql/operations/cluster-create.md) {{ mpg-name }} с хостами в публичном доступе.

        {% include [public-access](../../../_includes/mdb/note-public-access.md) %}

    1. В подсети кластера {{ mpg-name }} [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}
    1. Скачайте в рабочую директорию [файл](https://github.com/yandex-cloud-examples/yc-greenplum-pxf-named-queries/blob/main/pxf-named-queries-infrastructure.tf) `pxf-named-queries-infrastructure.tf`. В файле описаны:

         * сети;
         * подсети;
         * NAT-шлюзы;
         * группы безопасности;
         * кластер {{ GP }} в сервисе {{ mgp-name }};
         * кластер {{ mpg-name }};

    1. Укажите в файле:

         * `mgp_password` — пароль пользователя {{ GP }}.
         * `mgp_version` — версию {{ GP }}.
         * `mpg_password` — пароль пользователя базы данных {{ PG }}.
         * `mpg_version` — версию {{ PG }}.

    1. Для проверки правильности файлов конфигурации выполните команду:

         ```bash
         terraform validate
         ```

       Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте инфраструктуру:

       {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. [Подключитесь](../../../managed-postgresql/operations/connect.md#bash) к базе данных {{ PG }}.

1. Создайте таблицу `customers` и добавьте в нее тестовые данные:

   ```sql
   CREATE TABLE customers(id int, name text, city text);
   INSERT INTO customers VALUES (111, 'Борис', 'Саратов');
   INSERT INTO customers VALUES (222, 'Мария', 'Москва');
   INSERT INTO customers VALUES (333, 'Павел', 'Брянск');
   INSERT INTO customers VALUES (444, 'Петр', 'Новосибирск');
   INSERT INTO customers VALUES (555, 'Наталья', 'Псков');
   ```

1. Проверьте результат:

   ```sql
   SELECT * FROM customers;
   ```

   ```text
   id  |  name   |    city
   ----+---------+-------------
   111 | Борис   | Саратов
   222 | Мария   | Москва
   333 | Павел   | Брянск
   444 | Петр    | Новосибирск
   555 | Наталья | Псков
   ```

1. Создайте таблицу `orders` и добавьте в нее тестовые данные:

   ```sql
   CREATE TABLE orders(customer_id int, amount int, year int);
   INSERT INTO orders VALUES (111, 12, 2018);
   INSERT INTO orders VALUES (222, 234, 2019);
   INSERT INTO orders VALUES (333, 34, 2018);
   INSERT INTO orders VALUES (444, 456, 2019);
   INSERT INTO orders VALUES (555, 56, 2021);
   ```

1. Проверьте результат:

   ```sql
   SELECT * FROM orders;
   ```

   ```text
   customer_id | amount | year
   ------------+--------+------
           111 |     12 | 2018
           222 |    234 | 2019
           333 |     34 | 2018
           444 |    456 | 2019
           555 |     56 | 2021
   ```

## Создайте внешний источник данных {#create-jdbc-source}

В кластере {{ GP }} [создайте внешний источник данных](../../../managed-greenplum/operations/pxf/create-jdbc-source.md) с параметрами:

   * **Имя** — `pgserver`;
   * **Driver** — `org.postgresql.Driver`;
   * **Url** — `jdbc:postgresql://c-<идентификатор_кластера_{{ PG }}>.rw.{{ dns-zone }}:{{ port-mpg }}/<имя_БД_в_кластере_{{ PG }}>`;
   * **User** — `<имя_пользователя_{{ PG }}>`.

   Идентификатор кластера можно [получить](../../../managed-postgresql/operations/cluster-list.md#list-clusters) со списком кластеров в каталоге.

## Создайте именованный запрос {#create-named-query}

Чтобы создать именованный запрос, добавьте его в таблицу `mdb_toolkit.pxf_named_queries`:

1. [Подключитесь](../../../managed-greenplum/operations/connect/index.md) к {{ GP }}.

1. Выполните запрос:

   ```sql
   INSERT INTO mdb_toolkit.pxf_named_queries (pxf_profile, name, query) VALUES (
      'pgserver',
      'my_query',
      'SELECT c.name, o.year
      FROM customers c
      JOIN orders o ON c.id = o.customer_id;'
   );
   ```

   Где:

      * `pgserver` — имя источника данных.
      * `my_query`— имя именованного запроса.

   В качестве примера именованного запроса используется запрос, который объединяет таблицы `customers` и `orders` по полю `id = customer_id`, а затем выводит имя клиента (`c.name`) и год, когда клиент совершал заказы (`o.year`).

1. Проверьте результат:

   ```sql
   SELECT * FROM mdb_toolkit.pxf_named_queries;
   ```

   ```text
   pxf_profile |    name     |              query
   ------------+-------------+--------------------------------------------
   pgserver    | my_query    | SELECT c.name, o.year                       
               |             |       FROM customers c                      
               |             |       JOIN orders o ON c.id = o.customer_id;
   ```

   В столбце `query` должен содержаться текст именованного запроса.

## Создайте внешнюю таблицу и получите из нее данные {#create-ext-table}

1. [Подключитесь](../../../managed-greenplum/operations/connect/index.md) к {{ GP }}.

1. Создайте внешнюю таблицу `pxf_named_query`. Она будет ссылаться на данные, которые именованный запрос получает из таблиц `customers` и `orders` в БД {{ PG }}:

   ```sql
   CREATE READABLE EXTERNAL TABLE pxf_named_query(name text, year int)
   LOCATION ('pxf://query:my_query?PROFILE=JDBC&SERVER=pgserver')
   FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
   ```

   Подробнее о синтаксисе SQL-запроса для создания внешней таблицы см. в [соответствующем разделе](../../../managed-greenplum/operations/pxf/create-table.md#sql-statement).


1. Получите данные:

   ```sql
   SELECT * FROM pxf_named_query;
   ```

   Результат:

   ```text
     name  | year
   --------+------
   Борис   | 2018
   Мария   | 2019
   Павел   | 2018
   Петр    | 2019
   Наталья | 2021
   ```

   {% note tip %}

   Если при выполнении запроса возникает ошибка, подождите несколько минут и попробуйте снова. Возможно, изменения еще не вступили в силу.

   {% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Удалите](../../../managed-greenplum/operations/cluster-delete.md) кластер {{ GP }}.
   1. [Удалите](../../../managed-postgresql/operations/cluster-delete.md) кластер {{ mpg-name }}.
   1. [Удалите](../../../vpc/operations/delete-nat-gateway.md) NAT-шлюзы.

- {{ TF }} {#tf}

   {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
