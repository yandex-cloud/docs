# Использование внешних таблиц

{{ GP }} позволяет взаимодействовать с данными в источниках, внешних по отношению к кластеру {{ mgp-name }}. Работа с такими данными ведется с помощью _внешних таблиц_ — специальных объектов в базе данных {{ GP }}, которые ссылаются на таблицы, бакеты или файлы внешних источников. Доступ к [данным во внешних СУБД](#pxf) осуществляется с помощью протокола _PXF_, а к [файлам на внешних файловых серверах](#gpfdist) — с помощью утилиты _GPFDIST_.

С помощью внешних таблиц вы можете:

* выполнять запросы к внешним источникам данных;
* загружать наборы данных из внешних источников в БД {{ GP }};
* объединять локальные и внешние таблицы в запросах;
* записывать данные во внешние таблицы или файлы.

{% note info %}

Для обеспечения безопасности в {{ mgp-name }} недоступно создание [внешних веб-таблиц](https://gpdb.docs.pivotal.io/6-19/admin_guide/external/g-creating-and-using-web-external-tables.html), использующих shell-скрипты.

{% endnote %}

## Подключение к внешним СУБД {#pxf}

[{{ GP }} Platform Extension Framework (PXF)](https://docs.greenplum.org/6-4/pxf/overview_pxf.html) — программная платформа, которая позволяет получить доступ к данным во внешних СУБД. Доступно подключение таблиц следующих внешних источников:

* Apache Hive;
* {{ CH }};
* HBase;
* HDFS;
* {{ MY }};
* Oracle;
* {{ PG }};
* {{ MS }};
* Бакеты {{ objstorage-full-name }}.

### Создание внешней таблицы с использованием протокола PXF {#create-pxf-table}

Синтаксис SQL-запроса для создания внешней таблицы:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <имя таблицы>
       (<имя столбца> <тип данных> [, ...])
       LOCATION('pxf://<путь к данным или имя таблицы>?PROFILE=<имя профиля>&JDBC_DRIVER=<имя JDBC-драйвера>&DB_URL=<строка подключения>&USER=<имя пользователя>&PASS=<пароль пользователя>')
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Где:

* `имя таблицы` — имя внешней таблицы, которая будет создана в кластере {{ GP }}.
* `имя столбца` — имя столбца.
* `тип данных` — тип данных столбца. Должен совпадать с типом данных в таблице во внешней СУБД.
* `путь к данным или имя таблицы` — имя внешнего объекта, см. [примеры внешних таблиц](#pxf-examples).

При необходимости вы можете указать дополнительные параметры:

* `имя профиля` — стандарт взаимодействия с внешней СУБД, например `JDBC`.
* `имя JDBC-драйвера` — JDBC-драйвер, который будет использоваться для подключения к внешней СУБД.
* `строка подключения` — URL для подключения к внешней СУБД.
* `имя пользователя` — имя пользователя для подключения к внешней СУБД.
* `пароль пользователя`— пароль пользователя для подключения к внешней СУБД.

Опция `READABLE` позволяет считывать данные из внешнего объекта, но не записывать их. Чтобы записать данные во внешний объект, создайте внешнюю таблицу с опцией `WRITABLE`.

В этом SQL-запросе приведены не все доступные параметры. Подробнее см. в [документации {{ GP }}](https://docs.greenplum.org/6-4/pxf/intro_pxf.html) и [примерах создания внешних таблиц](#pxf-examples).

### Примеры создания внешних таблиц {#pxf-examples}

{% list tabs %}

- {{ CH }}

    1. [Создайте кластер {{ mch-full-name }}](../../managed-clickhouse/operations/cluster-create.md) с настройками:

        * Имя пользователя — `chuser`;
        * Пароль — `chpassword`;
        * Убедитесь, что опция **Публичный доступ** в настройках хостов отключена.

    1. [Подключитесь к БД {{ CH }}](../../managed-clickhouse/operations/connect#connection-string) с помощью утилиты `clickhouse-client`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE test (id int) ENGINE = Memory;
        ```

        ```sql
        INSERT INTO test VALUES (1);
        ```

    1. [Подключитесь к БД {{ GP }}](connect.md).
    1. Создайте внешнюю таблицу `pxf_ch`, которая будет ссылаться на таблицу `test` в кластере {{ CH }}:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
        LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=ru.yandex.clickhouse.ClickHouseDriver&DB_URL=jdbc:clickhouse://c-<идентификатор кластера>.rw.mdb.yandexcloud.net:8123/db1&USER=chuser&PASS=chpassword')
        FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_ch;
        ```

        Результат выполнения команды:

        ```text
        test_pxf=> SELECT * FROM pxf_ch;
         id
        ----
          1
        (1 row)
        ```

- {{ MY }}

    1. [Создайте кластер {{ mmy-full-name }}](../../managed-mysql/operations/cluster-create.md) с настройками:

        * Имя пользователя — `mysqluser`;
        * Пароль — `mysqlpassword`;
        * В настройках хостов выберите опцию **Публичный доступ**.

    1. [Подключитесь к БД {{ MY }}](../../managed-mysql/operations/connect#connection-string) с помощью утилиты `mysql`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE test (a  INT, b INT);
        ```

        ```sql
        INSERT INTO test VALUES (1, '11'), (2, '22');
        ```

    1. [Подключитесь к БД {{ GP }}](connect.md).
    1. Создайте внешнюю таблицу `pxf_mysql`, которая будет ссылаться на таблицу `test` в кластере {{ MY }}:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_mysql(a int, b int)
        LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.mysql.jdbc.Driver&DB_URL=jdbc:mysql://c-<идентификатор кластера>.rw.mdb.yandexcloud.net:3306/db1&USER=mysqluser&PASS=mysqlpassword')
        FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-mysql/operations/cluster-list.md#list-clusters).

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_mysql;
        ```

        Результат выполнения команды:

        ```text
        test_pxf=> SELECT * FROM pxf_mysql;
        a | b
        ---+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ PG }}

    1. [Создайте кластер {{ mpg-full-name }}](../../managed-postgresql/operations/cluster-create.md) с настройками:

        * Имя пользователя — `pguser`;
        * Пароль — `pgpassword`;
        * В настройках хостов выберите опцию **Публичный доступ**.

    1. [Подключитесь к БД {{ PG }}](../../managed-postgresql/operations/connect.md#bash) с помощью утилиты `psql`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE public.test ("a" INT,"b" INT);
        ```

        ```sql
        INSERT INTO public.test VALUES (1, '11'), (2, '22');
        ```

    1. [Подключитесь к БД {{ GP }}](connect.md).
    1. Создайте внешнюю таблицу `pxf_pg`, которая будет ссылаться на таблицу `public.test` в кластере {{ PG }}:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_pg(a int, b int)
        LOCATION ('pxf://public.test?PROFILE=JDBC&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://c-<идентификатор кластера>.rw.mdb.yandexcloud.net:6432/db1&USER=pguser&PASS=pgpassword')
        FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-postgresql/operations/cluster-list.md#list-clusters).

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_pg;
        ```

        Результат выполнения команды:

        ```text
        test_pxf=> SELECT * FROM pxf_pg;
        a | b
        ---+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ objstorage-name }}

    1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с именем `test-bucket`.

    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md).

    1. На локальной машине создайте тестовый файл `test.csv`:

        ```csv
        1,111
        2,222
        ```

    1. [Загрузите тестовый файл в бакет](../../storage/operations/objects/upload.md).

    1. [Подключитесь к БД {{ GP }}](connect.md).

    1. Чтобы считать данные из бакета {{ objstorage-name }}:

        1. Создайте внешнюю таблицу `pxf_s3_read`, которая будет ссылаться на бакет `test-bucket`:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_s3_read(a int, b int)
            LOCATION ('pxf://test-bucket/test.csv?PROFILE=s3:text&accesskey=<идентификатор ключа>&secretkey=<секретный ключ>&endpoint=storage.yandexcloud.net')
            FORMAT 'CSV';
            ```

        1. Получите данные из внешней таблицы:

            ```sql
            SELECT * FROM pxf_s3_read;
            ```

            Результат выполнения команды:

            ```text
            test_pxf=> SELECT * FROM pxf_s3_read;
            a | b
            ---+----
            1 | 111
            2 | 222
            (2 rows)
            ```

    1. Чтобы записать данные в бакет {{ objstorage-name }}:

        1. Создайте внешнюю таблицу `pxf_s3_write` с опцией `WRITABLE`. Имя файла при создании таблицы указывать не нужно:

            ```sql
            CREATE WRITABLE EXTERNAL TABLE pxf_s3_write(a int, b int)
            LOCATION ('pxf://test-bucket/?PROFILE=s3:text&accesskey=<идентификатор ключа>&secretkey=<секретный ключ>&endpoint=storage.yandexcloud.net')
            FORMAT 'CSV';
            ```

        1. Добавьте данные в таблицу:

            ```sql
            INSERT INTO pxf_s3_write VALUES (3,333);
            ```

            ```text
            INSERT 0 1
            ```

        1. Убедитесь, что в бакете [создан новый объект](../../storage/operations/objects/info.md).

{% endlist %}

## Подключение к внешнему файловому серверу {#gpfdist}

[{{ GP }} Parallel File Server (GPFDIST)](https://gpdb.docs.pivotal.io/6-19/admin_guide/external/g-using-the-greenplum-parallel-file-server--gpfdist-.html) — утилита для чтения и записи данных из файлов, расположенных на удаленных серверах. Она установлена на всех хостах-сегментах кластера {{ mgp-name }} и обеспечивает параллельную загрузку данных, распределяя их между сегментами равномерно или согласно заданному [ключу дистрибуции](../concepts/sharding.md#distibution-key). Это способствует максимальной производительности при взаимодействии с большими объемами внешних данных.

GPFDIST может работать с любыми текстовыми файлами, которые содержат разделители, а также со сжатыми файлами gzip и bzip2.

Для чтения или записи файлов на внешнем сервере:
1. [Установите и запустите GPFDIST](#run-gpfdist) в составе пакета Greenplum Loader на удаленном сервере, на котором находятся нужные файлы.
1. [Создайте внешнюю таблицу](#create-gpfdist-table), которая будет ссылаться на эти файлы, в базе данных {{ GP }}.

### Запуск GPFDIST {#run-gpfdist}

1. [Скачайте и установите](https://greenplum.docs.pivotal.io/43330/client_tool_guides/load/unix/unix_load_install.html) пакет Greenplum Loader.

1. Запустите утилиту GPFDIST:

    ```bash
    $ gpfdist -d <директория с файлами данных> -p <порт подключения> -l <путь к файлу логов>
    ```
   
    Где:
    - `директория с файлами данных` — локальный путь к директории, в которой хранятся файлы для чтения или записи данных через внешнюю таблицу.
    - `порт подключения` — порт, на котором будет работать утилита. По умолчанию используется порт `8080`.
    - `путь к файлу логов` — (опционально) путь к файлу, в который GPFDIST будет записывать логи своей работы.

    Вы можете запустить несколько экземпляров GPFDIST на одном сервере, указав разные директории и порты для подключения, чтобы распределить нагрузку на сеть, например:

    ```bash
    $ gpfdist -d /var/load_files1 -p 8081 -l /home/gpadmin/log1 &
    $ gpfdist -d /var/load_files2 -p 8082 -l /home/gpadmin/log2
    ```

1. Проверьте, что файлы в указанной директории доступны по указанному порту из {{ yandex-cloud }}, например выполнив команду с ВМ в {{ yandex-cloud }}:

    ```bash
    $ wget http://hostname:port/filename
    ```

### Создание внешней таблицы с использованием протокола GPFDIST {#create-gpfdist-table}

Синтаксис SQL-запроса для создания внешней таблицы:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <имя таблицы>
       (<имя столбца> <тип данных> [, ...])
       LOCATION('gpfdist://<путь к файлу на удаленном сервере>' [, ...])
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Где:

* `имя таблицы` — имя внешней таблицы, которая будет создана в базе данных {{ GP }}.
* `имя столбца` — имя столбца таблицы.
* `тип данных` — тип данных столбца таблицы.
* `путь к файлу на удаленном сервере` — адрес сервера, на котором запущен GPFDIST, порт для подключения и путь к файлу. Вы можете указать конкретный файл или задать маску с помощью символа звездочки (*).

Опция `READABLE` позволяет считывать данные из внешних файлов, но не записывать их. Чтобы записать данные во внешний файл, создайте внешнюю таблицу с опцией `WRITABLE`.

### Примеры создания внешних таблиц {#gpfdist-examples}

- Создание внешней таблицы с данными из файла `file.csv` на сервере `hostname`:

    ```sql
    CREATE EXTERNAL TABLE tableName (id int)
           LOCATION('gpfdist://hostname:8080/file.csv')
           FORMAT 'CSV' (DELIMITER ',');
    ```

- Создание внешней таблицы, объединяющей данные из всех файлов формата `txt`, где `|` — символ разделителя, а пробел — значение `NULL`, на серверах `hostname1` и `hostname2`:

    ```sql
    CREATE EXTERNAL TABLE tableName (...)
           LOCATION('gpfdist://hostname1:8081/*.txt',
                    'gpfdist://hostname2:8081/*.txt')
           FORMAT 'TEXT' (DELIMITER '|' NULL ' ');
    ```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
