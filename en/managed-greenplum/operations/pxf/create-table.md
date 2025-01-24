---
title: Creating an external table using PXF
description: Follow this guide to create an external PXF table using an SQL query.
---

# Creating an external table using PXF

## Getting started {#before-you-begin}


1. In the {{ mgp-name }} cluster subnet, [set up a NAT gateway and link a routing table](../../../vpc/operations/create-nat-gateway.md).
1. In the same subnet, [create a security group](../../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.
1. Create an external data source. The steps needed to create a source depend on the source connection type:

    * [S3](create-s3-source.md)
    * [JDBC](create-jdbc-source.md)
    * [HDFS](create-hdfs-source.md)
    * [Hive](create-hive-source.md)


## Creating an external table using an SQL query {#sql-statement}

The SQL query syntax to create an external table is as follows:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <table_name>
       (<column_name> <data_type> [, ...])
       LOCATION('pxf://<data_path_or_table_name>?PROFILE=<profile_name>&SERVER=<source_name>')
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Where:

* `<table_name>`: Name of the external table you are about to create in the {{ GP }} cluster.
* `<column_name>`: Column name.
* `<data_type>`: Column data type. It must match the column data type in the external DBMS table.
* `<data_path_or_table_name>`: External object name, see [examples of external tables](#pxf-examples).
* `PROFILE`: Standard interface to an external DBMS (profile), e.g., `JDBC`. The list of possible values depends on the connection type:

    * [S3]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/access_objstore.html#connectors-data-formats-and-profiles-1)
    * [JDBC]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/jdbc_pxf.html#accessing-an-external-sql-database-3)
    * [HDFS and Hive]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/access_hdfs.html#connectors-data-formats-and-profiles-3)

* `SERVER`: Name of the external PXF data source.

    Instead of `SERVER`, you can provide the parameters defining the external data source configuration. These depend on the source connection type. For more information, see the [{{ GP }} PFX documentation]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/intro_pxf.html#creating-an-external-table-6) and examples of creating external tables.

The `WRITABLE` option allows writing data to an external object. To read data from an external object, create an external table with the `READABLE` option.

## Examples for creating external tables {#pxf-examples}

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

    1. [Create a {{ mch-full-name }} cluster](../../../managed-clickhouse/operations/cluster-create.md) with the `chuser` username.

    
    1. In the cluster subnet, [set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) and [create a security group](../../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.


    1. (Optional) [Create an external JDBC data source](create-jdbc-source.md) with the following parameters:

        * **Name**: `chserver`
        * **Driver**: `com.clickhouse.jdbc.ClickHouseDriver`
        * **Url**: `jdbc:clickhouse:http://c-<cluster_ID>.rw.{{ dns-zone }}:8123/db1`
        * **User**: `chuser`

        You can get the cluster ID with a [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

        With no data source created, you need to provide the source connection parameters in the SQL query for creating an external table.

    1. [Connect to the {{ CH }} DB](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) using `clickhouse-client`.
    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE test (id int) ENGINE = Memory;
        ```

        ```sql
        INSERT INTO test VALUES (1);
        ```

    1. [Connect to the {{ GP }}](../connect.md) DB.
    1. Create an external table named `pxf_ch` to reference the `test` table in the {{ CH }} cluster. The SQL query depends on whether you previously created an external data source or not:

        * With a data source created:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
            LOCATION ('pxf://test?PROFILE=JDBC&SERVER=chserver')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        * With no data source created:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
            LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.clickhouse.jdbc.ClickHouseDriver&DB_URL=jdbc:clickhouse:http://c-<cluster_ID>.rw.{{ dns-zone }}:8123/db1&USER=chuser')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        If public access is enabled for {{ CH }} hosts, use an encrypted connection when creating an external table. To do this, specify SSL parameters in your query:

        * With a data source created:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
            LOCATION ('pxf://test?PROFILE=JDBC&SERVER=chserver&ssl=true&sslmode=strict&sslrootcert=/etc/greenplum/ssl/allCAs.pem')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        * With no data source created:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
            LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.clickhouse.jdbc.ClickHouseDriver&DB_URL=jdbc:clickhouse:https://c-<cluster_ID>.rw.mdb.yandexcloud.net:{{ port-mch-http }}/db1&USER=chuser&ssl=true&sslmode=strict&sslrootcert=/etc/greenplum/ssl/allCAs.pem')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

    1. Query the external table for data:

        ```sql
        SELECT * FROM pxf_ch;
        ```

        Result:

        ```text
        test_pxf=> SELECT * FROM pxf_ch;
         id
        ----
          1
        (1 row)
        ```

- {{ MY }} {#mysql}

    1. [Create a {{ mmy-full-name }} cluster](../../../managed-mysql/operations/cluster-create.md) with the following settings:

        * Username: `mysqluser`.
        * In the host settings, select the **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** option.

    
    1. In the cluster subnet, [set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) and [create a security group](../../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.


    1. (Optional) [Create an external JDBC data source](create-jdbc-source.md) with the following parameters:

        * **Name**: `mysqlserver`
        * **Driver**: `com.mysql.jdbc.Driver`
        * **Url**: `jdbc:mysql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mmy }}/db1`
        * **User**: `mysqluser`

        You can get the cluster ID with a [list of clusters](../../../managed-mysql/operations/cluster-list.md#list-clusters) in the folder.

        With no data source created, you need to provide the source connection parameters in the SQL query for creating an external table.

    1. [Connect to the {{ MY }} DB](../../../managed-mysql/operations/connect.md#connection-string) using `mysql`.
    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE test (a INT, b INT);
        ```

        ```sql
        INSERT INTO test VALUES (1, '11'), (2, '22');
        ```

    1. [Connect to the {{ GP }}](../connect.md) DB.
    1. Create an external table named `pxf_mysql` to reference the `test` table in the {{ MY }} cluster. The SQL query depends on whether you previously created an external data source or not:

        * With a data source created:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_mysql(a int, b int)
            LOCATION ('pxf://test?PROFILE=JDBC&SERVER=mysqlserver')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        * With no data source created:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_mysql(a int, b int)
            LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.mysql.jdbc.Driver&DB_URL=jdbc:mysql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mmy }}/db1&USER=mysqluser')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

    1. Query the external table for data:

        ```sql
        SELECT * FROM pxf_mysql;
        ```

        Result:

        ```text
        test_pxf=> SELECT * FROM pxf_mysql;
        a | b
        --+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ PG }} {#postgresql}

    1. [Create a {{ mpg-full-name }}](../../../managed-postgresql/operations/cluster-create.md) cluster with the following settings:

        * Username: `pguser`
        * In the host settings, select the **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** option.

    
    1. In the cluster subnet, [set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) and [create a security group](../../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.


    1. (Optional) [Create an external JDBC data source](create-jdbc-source.md) with the following parameters:

        * **Name**: `pgserver`
        * **Driver**: `org.postgresql.Driver`
        * **Url**: `jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mpg }}/db1`
        * **User**: `pguser`

        You can get the cluster ID with the [list of clusters](../../../managed-postgresql/operations/cluster-list.md#list-clusters) in the folder.

        With no data source created, you need to provide the source connection parameters in the SQL query for creating an external table.

    1. [Connect to the {{ PG }} DB](../../../managed-postgresql/operations/connect.md#bash) using `psql`.
    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE public.test ("a" INT,"b" INT);
        ```

        ```sql
        INSERT INTO public.test VALUES (1, '11'), (2, '22');
        ```

    1. [Connect to the {{ GP }}](../connect.md) DB.
    1. Create an external table named `pxf_pg` to reference the `public.test` table in the {{ PG }} cluster. The SQL query depends on whether you previously created an external data source or not:

        * With a data source created:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_pg(a int, b int)
            LOCATION ('pxf://public.test?PROFILE=JDBC&SERVER=pgserver')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        * With no data source created:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_pg(a int, b int)
            LOCATION ('pxf://public.test?PROFILE=JDBC&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mpg }}/db1&USER=pguser')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

    1. Query the external table for data:

        ```sql
        SELECT * FROM pxf_pg;
        ```

        Result:

        ```text
        test_pxf=> SELECT * FROM pxf_pg;
        a | b
        --+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ objstorage-name }} {#storage}

    
    1. In the cluster subnet, [set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) and [create a security group](../../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.


    1. [Create an {{ objstorage-name }}](../../../storage/operations/buckets/create.md) bucket with restricted access.
    1. [Create a static access key](../../../iam/operations/sa/create-access-key.md).
    1. (Optional) [Create an external S3 data source](create-s3-source.md) with the following parameters:

        * **Name**: `objserver`
        * **Access Key**: ID of the static access key you previously created.
        * **Secret Key**: Secret key you previously created along with the static access key.
        * **Endpoint**: `{{ s3-storage-host }}`.

        With no data source created, you need to provide the source connection parameters in the SQL query for creating an external table.

    1. Create a test file named `test.csv` on the local machine:

        ```csv
        1,111
        2,222
        ```

    1. [Upload your test file to the bucket](../../../storage/operations/objects/upload.md).

        Files you are uploading to the bucket must not start with `.` and `_`. Such files are considered hidden, and PXF does not read data from them.

    1. [Connect to the {{ GP }}](../connect.md) DB.
    1. To read data from the {{ objstorage-name }} bucket:

        1. Create an external table named `pxf_s3_read` to reference the bucket. The SQL query depends on whether you previously created an external data source or not:

            * With a data source created:

                ```sql
                CREATE READABLE EXTERNAL TABLE pxf_s3_read(a int, b int)
                LOCATION ('pxf://<bucket_name>/test.csv?PROFILE=s3:text&SERVER=objserver')
                FORMAT 'CSV';
                ```

            * With no data source created:

                ```sql
                CREATE READABLE EXTERNAL TABLE pxf_s3_read(a int, b int)
                LOCATION ('pxf://<bucket_name>/test.csv?PROFILE=s3:text&accesskey=<key_ID>&secretkey=<secret_key>&endpoint={{ s3-storage-host }}')
                FORMAT 'CSV';
                ```

        1. Query the external table for data:

            ```sql
            SELECT * FROM pxf_s3_read;
            ```

            Result:

            ```text
            test_pxf=> SELECT * FROM pxf_s3_read;
            a | b
            ---+----
            1 | 111
            2 | 222
            (2 rows)
            ```

    1. To write data to a {{ objstorage-name }} bucket:

        1. Create an external table named `pxf_s3_write` with the `WRITABLE` option. You do not need to specify a file name when creating the table:

            * With a data source created:

                ```sql
                CREATE WRITABLE EXTERNAL TABLE pxf_s3_write(a int, b int)
                LOCATION ('pxf://<bucket_name>/?PROFILE=s3:text&SERVER=objserver')
                FORMAT 'CSV';
                ```

            * With no data source created:

                ```sql
                CREATE WRITABLE EXTERNAL TABLE pxf_s3_write(a int, b int)
                LOCATION ('pxf://<bucket_name>/?PROFILE=s3:text&accesskey=<key_ID>&secretkey=<secret_key>&endpoint={{ s3-storage-host }}')
                FORMAT 'CSV';
                ```

        1. Add data to the table:

            ```sql
            INSERT INTO pxf_s3_write VALUES (3,333);
            ```

            ```text
            INSERT 0 1
            ```

        1. Make sure that [a new object has been created](../../../storage/operations/objects/info.md) in the bucket.

    {% note info %}

    To create an external table from {{ objstorage-name }}, you can use the S3 protocol and transmit your static key parameters using a file located on a web server. For more information, see [this tutorial](../../tutorials/config-server-for-s3.md).

    {% endnote %}

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
