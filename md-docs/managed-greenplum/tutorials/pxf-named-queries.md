# Получение данных из внешних источников с помощью именованных запросов

В {{ GP }} для получения данных из внешних СУБД по протоколу [PXF](../concepts/external-tables.md) можно использовать именованные запросы (named queries).

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

* Кластер {{ mgp-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mgp-name }}](../pricing/index.md)).
* Кластер {{ mpg-full-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* NAT-шлюз: почасовое использование шлюзов и исходящий через них трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер](../operations/cluster-create.md) {{ GP }} любой подходящей конфигурации.
    
    1. В [подсети](../../vpc/concepts/network.md#subnet) кластера {{ GP }} [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.

    1. [Создайте кластер](../../managed-postgresql/operations/cluster-create.md) {{ mpg-name }} с хостами в публичном доступе.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. В подсети кластера {{ mpg-name }} [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.

- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
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

       В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. [Подключитесь](../../managed-postgresql/operations/connect/clients.md#bash) к базе данных {{ PG }}.

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

В кластере {{ GP }} [создайте внешний источник данных](../operations/pxf/create-jdbc-source.md) с параметрами:

   * **Имя** — `pgserver`;
   * **Driver** — `org.postgresql.Driver`;
   * **Url** — `jdbc:postgresql://c-<идентификатор_кластера_{{ PG }}>.rw.{{ dns-zone }}:{{ port-mpg }}/<имя_БД_в_кластере_{{ PG }}>`;
   * **User** — `<имя_пользователя_{{ PG }}>`.

   Идентификатор кластера можно [получить](../../managed-postgresql/operations/cluster-list.md#list-clusters) со списком кластеров в каталоге.

## Создайте именованный запрос {#create-named-query}

Чтобы создать именованный запрос, добавьте его в таблицу `mdb_toolkit.pxf_named_queries`:

1. [Подключитесь](../operations/connect/index.md) к {{ GP }}.

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

1. [Подключитесь](../operations/connect/index.md) к {{ GP }}.

1. Создайте внешнюю таблицу `pxf_named_query`. Она будет ссылаться на данные, которые именованный запрос получает из таблиц `customers` и `orders` в БД {{ PG }}:

   ```sql
   CREATE READABLE EXTERNAL TABLE pxf_named_query(name text, year int)
   LOCATION ('pxf://query:my_query?PROFILE=JDBC&SERVER=pgserver')
   FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
   ```

   Подробнее о синтаксисе SQL-запроса для создания внешней таблицы в [соответствующем разделе](../operations/pxf/create-table.md#sql-statement).


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

   1. [Удалите](../operations/cluster-delete.md) кластер {{ GP }}.
   1. [Удалите](../../managed-postgresql/operations/cluster-delete.md) кластер {{ mpg-name }}.
   1. [Удалите](../../vpc/operations/delete-nat-gateway.md) NAT-шлюзы.

- {{ TF }} {#tf}

   1. В терминале перейдите в директорию с планом инфраструктуры.
   
       {% note warning %}
   
       Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
   
       {% endnote %}
   
   1. Удалите ресурсы:
   
       1. Выполните команду:
   
           ```bash
           terraform destroy
           ```
   
       1. Подтвердите удаление ресурсов и дождитесь завершения операции.
   
       Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

{% endlist %}

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._