# Using external tables

[{{ GP }} Platform Extension Framework (PXF)](https://docs.greenplum.org/6-4/pxf/overview_pxf.html) is a software platform that provides access to data from sources external to a {{ mgp-name }} cluster. You handle external data through _PXF tables_, special objects in a {{ GP }} database referencing external tables or buckets.

Use {{ GP }} PXF to:

* Query external data sources.
* Load datasets from external sources into a {{ GP }} database.
* Join local and external tables in queries.
* Write data to external tables.

Tables from the following external sources are available to connect to:

* Apache Hive.
* {{ CH }};
* HBase.
* HDFS.
* {{ MY }};
* Oracle.
* {{ PG }};
* {{ MS }};
* {{ objstorage-full-name }} buckets.

## Creating a database with external table support {#create-pxf-db}

To work with external tables, install the PXF plugin in the database. The `postgres` database available after you create a {{ GP }} cluster does not include this plugin. To get support for external tables, create a new database from `template1`, which already has the PXF plugin installed.

To create a {{ GP }} database with external table support:

1. [Create a {{ GP }} cluster](../quickstart.md#cluster-create) with the desired configuration. When creating a cluster, select the **Public access** option.
1. [Connect](../quickstart.md#connect) to the cluster.
1. Create a database with PXF support:

    ```sql
    CREATE DATABASE test_pxf TEMPLATE template1;
    ```

1. Check the connection to the created database:

    ```sql
    \c test_pxf
    ```

    ```text
    You are now connected to the "test_pxf" database as "<user name>".
    ```

## Creating external tables {#pxf-tables-creation}

{% note info %}

You can only create PXF tables in a [database with PXF plugin support](#create-pxf-db).

{% endnote %}

SQL query syntax to create a PXF table:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <table name>
       ( <column name> <data type> [, ...])
       LOCATION('pxf://<data path or table name>?PROFILE=<profile name>&JDBC_DRIVER=<JDBC driver name>&DB_URL=<connection string>&USER=<user name>&PASS=<user password>')
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Where:

* `table name`: name of the PXF table to be created in the {{ GP }} cluster.
* `column name`: name of a column in the PXF table.
* `data type`: data type of a column in the PXF table. Must match the data type in the external table.
* `data path or table name`: name of an external object, see [example external tables](#examples).

If required, you can specify additional parameters:

* `profile name`: external DBMS interaction standard, such as `JDBC`.
* `JDBC driver name`: JDBC driver used to connect to an external DBMS.
* `connection string`: external DBMS connection URL.
* `user name`: user name to connect to the external DBMS.
* `user password`: user password to connect to an external DBMS.

The `READABLE` option enables you to read data from an external object but not write to it. To write data to an external object, create a PXF table with the `WRITABLE` option.

This SQL query does not contain an exhaustive list of available parameters. For more information, see the [{{ GP }} documentation](https://docs.greenplum.org/6-4/pxf/intro_pxf.html) and [examples for creating external tables](#examples).

## Examples for creating external tables {#examples}

{% list tabs %}

- {{ CH }}

    1. [Create a {{ mch-full-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with this configuration:

        * User name: `chuser`.
        * Password: `chpassword`.
        * Make sure the **Public access** option is disabled in the host settings.

    1. [Connect to the {{ CH }} database](../../managed-clickhouse/operations/connect#connection-string) using the `clickhouse-client` utility.

    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE test (id int) ENGINE = Memory;
        ```

        ```sql
        INSERT INTO test VALUES (1);
        ```

    1. [Connect to the {{ GP }} database](#create-pxf-db) with support for external tables configured.

    1. Create a PXF table called `pxf_ch` to reference an external table called `test` in the {{ CH }} cluster:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
        LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=ru.yandex.clickhouse.ClickHouseDriver&DB_URL=jdbc:clickhouse://c-<cluster ID>.rw.{{ dns-zone }}:8123/db1&USER=chuser&PASS=chpassword') FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        You can fetch the cluster ID with a [list of clusters in the folder](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Query the external table for data:

        ```sql
        SELECT * FROM pxf_ch;
        ```

        Command output:

        ```text
        test_pxf=> SELECT * FROM pxf_ch;
         id
        ----
          1
        (1 row)
        ```

- {{ MY }}

    1. [Create a {{ mmy-full-name }} cluster](../../managed-mysql/operations/cluster-create.md) with this configuration:

        * User name: `mysqluser`.
        * Password: `mysqlpassword`.
        * In the host settings, select the **Public access** option.

    1. [Connect to the {{ MY }} database](../../managed-mysql/operations/connect#connection-string) using the `mysql` utility.

    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE test (a  INT, b INT);
        ```

        ```sql
        INSERT INTO test VALUES (1, '11'), (2, '22');
        ```

    1. [Connect to the {{ GP }} database](#create-pxf-db) with support for external tables configured.

    1. Create a PXF table called `pxf_mysql` to reference an external table called `test` in the {{ MY }} cluster:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_mysql(a int, b int)
        LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.mysql.jdbc.Driver&DB_URL=jdbc:mysql://c-<cluster ID>.rw.{{ dns-zone }}:3306/db1&USER=mysqluser&PASS=mysqlpassword')
        FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        You can fetch the cluster ID with a [list of clusters in the folder](../../managed-mysql/operations/cluster-list.md#list-clusters).

    1. Query the external table for data:

        ```sql
        SELECT * FROM pxf_mysql;
        ```

        Command output:

        ```text
        test_pxf=> SELECT * FROM pxf_mysql;
        a | b
        ---+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ PG }}

    1. [Create a {{ mpg-full-name }} cluster](../../managed-postgresql/operations/cluster-create.md) with this configuration:

        * User name: `pguser`.
        * Password: `pgpassword`.
        * In the host settings, select the **Public access** option.

    1. [Connect to the {{ PG }} database](../../managed-postgresql/operations/connect.md#bash) using the `psql` utility.

    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE public.test ("a" INT,"b" INT);
        ```

        ```sql
        INSERT INTO public.test VALUES (1, '11'), (2, '22');
        ```

    1. [Connect to the {{ GP }} database](#create-pxf-db) with support for external tables configured.

    1. Create a PXF table `pxf_pg` to reference an external table `public.test` in the {{ PG }}cluster:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_pg(a int, b int)
        LOCATION ('pxf://public.test?PROFILE=JDBC&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://c-<cluster ID>.rw.{{ dns-zone }}:6432/db1&USER=pguser&PASS=pgpassword')
        FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        You can fetch the cluster ID with a [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list-clusters).

    1. Query the external table for data:

        ```sql
        SELECT * FROM pxf_pg;
        ```

        Command output:

        ```text
        test_pxf=> SELECT * FROM pxf_pg;
        a | b
        ---+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ objstorage-name }}

    1. [Create a bucket {{ objstorage-name }}](../../storage/operations/buckets/create.md) called `test-bucket`.

    1. [Create a static access key](../../iam/operations/sa/create-access-key.md).

    1. Create a test file `test.csv` on the local machine:

        ```csv
        1,111
        2,222
        ```

    1. [Upload your test file to the bucket](../../storage/operations/objects/upload.md).

    1. [Connect to the {{ GP }} database](#create-pxf-db) with support for external tables configured.

    1. To read data from the {{ objstorage-name }} bucket:

        1. Create a PXF table `pxf_s3_read`to reference `test-bucket`:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_s3_read(a int, b int)
            LOCATION ('pxf://test-bucket/test.csv?PROFILE=s3:text&accesskey=<key ID>&secretkey=<secret key>&endpoint=storage.yandexcloud.net') FORMAT 'CSV';
            ```

        1. Query the external table for data:

            ```sql
            SELECT * FROM pxf_s3_read;
            ```

            Command output:

            ```text
            test_pxf=> SELECT * FROM pxf_s3_read;
            a | b
            ---+----
            1 | 111
            2 | 222
            (2 rows)
            ```

    1. To write data to a {{ objstorage-name }} bucket:

        1. Create a PXF table `pxf_s3_write` with the `WRITABLE` option. You do not need to specify a file name when creating the table:

            ```sql
            CREATE WRITABLE EXTERNAL TABLE pxf_s3_write(a int, b int)
            LOCATION ('pxf://test-bucket/?PROFILE=s3:text&accesskey=<key ID>&secretkey=<secret key>&endpoint=storage.yandexcloud.net') FORMAT 'CSV';
            ```

        1. Insert data into the table

            ```sql
            INSERT INTO pxf_s3_write VALUES (3,333);
            ```

            ```text
            INSERT 0 1
            ```

        1. Make sure in the bucket, [that a new object has been created](../../storage/operations/objects/info.md).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

