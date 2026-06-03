---
title: Creating an external table using PXF
description: Follow this guide to create an external PXF table using an SQL query.
---


# Creating an external table using PXF

{{ mgp-name }} allows [creating external tables](#sql-statement) to access data in external databases. In clusters with the [Apache Cloudberry™](https://cloudberry.apache.org) DBMS, in addition to external tables, you can also [create foreign tables](#sql-statement-fdw) using the FDW mechanism. Such tables provide access to the same external DBMSs as external ones. However, foreign tables support both read and write operations within a single table, unlike external tables which are strictly read-only or write-only.

The FDW mechanism supports the following external data types:

* `s3_pxf_fdw`
* `jdbc_pxf_fdw`
* `hdfs_pxf_fdw`
* `hive_pxf_fdw`

External tables are created using the `CREATE EXTERNAL TABLE` SQL query, whereas foreign tables using `CREATE FOREIGN TABLE`.


## Getting started {#before-you-begin}


1. In the {{ mgp-name }} cluster's subnet, [set up a NAT gateway and link a routing table](../../../vpc/operations/create-nat-gateway.md).
1. In the {{ mgp-name }} cluster network, [create a security group](../../../vpc/operations/security-group-create.md) that allows all incoming and outgoing traffic from all addresses.
1. Create an external data source. The steps you need to follow depend on the source connection type:

    * [S3](create-s3-source.md)
    * [JDBC](create-jdbc-source.md)
    * [HDFS](create-hdfs-source.md)
    * [Hive](create-hive-source.md)



## Creating a foreign table {#sql-statement-fdw}

Syntax of an SQL query to create a foreign table:

```sql
CREATE FOREIGN TABLE <table_name>
  (<column_name> <data_type> [, ...])
  SERVER "<local_source_name>"
  OPTIONS (
    resource '<data_path_or_table_name>'
  );
```

Where:

* `<table_name>`: Name of the external table in the {{ mgp-name }} cluster.
* `<column_name>`: Column name.
* `<data_type>`: Column data type. It must match the type of the corresponding column in the external DBMS.
* `<local_source_name>`: Local data source name.
* `<path_to_data_or_table_name>`: Path to data or table name on the external source.


### Examples of creating foreign tables {#fdw-examples}

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

  1. [Create a {{ mch-full-name }} cluster](../../../managed-clickhouse/operations/cluster-create.md) with the `chuser` username.

  
  1. [Add rules](../../../vpc/operations/security-group-add-rule.md) allowing all incoming and outgoing traffic to the security group of the {{ mch-name }} cluster.
    
    
  1. Create a table in {{ CH }} and populate it with data:
      
      1. [Connect to the {{ CH }}](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) DB using `clickhouse-client`.
  
      1. Create a table named `test`:

          ```sql
          CREATE TABLE test (
            a INT,
            b INT
          ) ENGINE = Memory;
          ```

      1. Add data:

          ```sql
          INSERT INTO test (a, b)
          VALUES (1, 11), (2, 22);
          ```

  1. Get access to external data in {{ mgp-name }}:
  
      1. [Connect to the database](../connect/index.md) in {{ mgp-name }}.

      1. Create an external data source:
          
          
          ```sql
          CREATE SERVER "chserver"
            FOREIGN DATA WRAPPER jdbc_pxf_fdw
            OPTIONS (
              jdbc_driver 'com.clickhouse.jdbc.ClickHouseDriver',
              db_url 'jdbc:clickhouse:http://c-<cluster_ID>.rw.{{ dns-zone }}:8123/<DB_name>',
              user 'chuser',
              pass '<password>'
            );
          ```

          Where `db_url` is a [special FQDN](../../../managed-clickhouse/operations/connect/fqdn.md#auto) always pointing to an available {{ mch-name }} cluster host.

          You can get the cluster ID with the [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

          If public access is enabled for {{ CH }} hosts, use an encrypted connection when creating an external table. Do it by specifying SSL parameters; use the `https` protocol and port `{{ port-mch-http }}`.

          ```sql
          CREATE SERVER "chserver"
            FOREIGN DATA WRAPPER jdbc_pxf_fdw
            OPTIONS (
              ssl 'true',
              sslmode 'strict',
              sslrootcert '/etc/greenplum/ssl/allCAs.pem',
              jdbc_driver 'com.clickhouse.jdbc.ClickHouseDriver',
              db_url 'jdbc:clickhouse:https://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mch-http }}/<DB_name>',
              user 'chuser',
              pass '<password>'
            );
          ```

      1. Create a mapping between a local user and a user in the external data source:
  
          ```sql
          CREATE USER MAPPING FOR CURRENT_USER
            SERVER "chserver";
          ```

      1. Create an external table named `fdw_ch` to reference the `test` table in the {{ CH }} cluster:

          ```sql
          CREATE FOREIGN TABLE fdw_ch (
            a INT,
            b INT
          )
          SERVER "chserver"
          OPTIONS (
            resource 'test'
          );
         ```

      1. Query the external table for data:

          ```sql
          SELECT * FROM fdw_ch;
          ```
      
      1. Populate the external table with data:
          
          ```sql
          INSERT INTO fdw_ch (a, b)
          VALUES (3, 33);
          ```

- {{ MY }} {#mysql}

  
  1. [Create a {{ mmy-full-name }} cluster](../../../managed-mysql/operations/cluster-create.md) with public access to its hosts and `mysqluser` for username.

  1. [Add rules](../../../vpc/operations/security-group-add-rule.md) allowing all incoming and outgoing traffic to the security group of the {{ mmy-name }} cluster.

    
  1. Create a table in {{ MY }} and populate it with data:
      
      1. [Connect to the {{ MY }}](../../../managed-mysql/operations/connect/index.md#connection-string) DB using `mysql`.
  
      1. Create a table named `test`:

          ```sql
          CREATE TABLE test (
            a INT,
            b INT
          );
          ```

      1. Add data:

          ```sql
          INSERT INTO test (a, b)
          VALUES (1, 11), (2, 22);
          ```

  1. Get access to external data in {{ mgp-name }}:
  
      1. [Connect to the database](../connect/index.md) in {{ mgp-name }}.

      1. Create an external data source:
          
          ```sql
          CREATE SERVER "myserver"
            FOREIGN DATA WRAPPER jdbc_pxf_fdw
            OPTIONS (
              jdbc_driver 'com.mysql.jdbc.Driver',
              db_url 'jdbc:mysql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mmy }}/<DB_name>',
              user 'mysqluser',
              pass '<password>'
            );
          ```

          `db_url` is a [special FQDN](../../../managed-mysql/operations/connect/fqdn.md#fqdn-master) always pointing to the current master host in the {{ mmy-name }} cluster.

          You can get the cluster ID with the [list of clusters](../../../managed-mysql/operations/cluster-list.md#list-clusters) in the folder.

      1. Create a mapping between a local user and a user in the external data source:
  
          ```sql
          CREATE USER MAPPING FOR CURRENT_USER
            SERVER "myserver";
          ```

      1. Create an external table named `fdw_mysql` to reference the `test` table in the {{ MY }} cluster:

          ```sql
          CREATE FOREIGN TABLE fdw_mysql (
            a INT,
            b INT
          )
          SERVER "myserver"
          OPTIONS (
            resource 'test'
          );
         ```

      1. Query the external table for data:

          ```sql
          SELECT * FROM fdw_mysql;
          ```
      
      1. Populate the external table with data:
          
          ```sql
          INSERT INTO fdw_mysql (a, b)
          VALUES (3, 33);
          ```

- {{ PG }} {#postgresql}

  
  1. [Create a {{ mpg-full-name }} cluster](../../../managed-postgresql/operations/cluster-create.md) with public access to its hosts and `pguser` for username.
  1. [Add rules](../../../vpc/operations/security-group-add-rule.md) allowing all incoming and outgoing traffic to the security group of the {{ mpg-name }} cluster.

    
  1. Create a table in {{ PG }} and populate it with data:
      
      1. [Connect to the {{ PG }}](../../../managed-postgresql/operations/connect/clients.md) DB using `psql`.
  
      1. Create a table named `test`:

          ```sql
          CREATE TABLE public.test (
            a INT,
            b INT
          );
          ```

      1. Add data:

          ```sql
          INSERT INTO public.test (a, b)
          VALUES (1, 11), (2, 22);
          ```

  1. Get access to external data in {{ mgp-name }}:
  
      1. [Connect to the database](../connect/index.md) in {{ mgp-name }}.

      1. Create an external data source:
          
          ```sql
          CREATE SERVER "pgserver"
            FOREIGN DATA WRAPPER jdbc_pxf_fdw
            OPTIONS (
              jdbc_driver 'org.postgresql.Driver',
              db_url 'jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mpg }}/<DB_name>',
              user 'pguser',
              pass '<password>'
            );
          ```

          `db_url` is a [special FQDN](../../../managed-postgresql/operations/connect/fqdn.md#fqdn-master) always pointing to the current master host in the {{ mpg-name }} cluster.

          You can get the cluster ID with the [list of clusters](../../../managed-postgresql/operations/cluster-list.md#list-clusters) in the folder.

      1. Create a mapping between a local user and a user in the external data source:
  
          ```sql
          CREATE USER MAPPING FOR CURRENT_USER
            SERVER "pgserver";
          ```

      1. Create an external table named `fdw_pg` to reference the `public.test` table in the {{ PG }} cluster:

          ```sql
          CREATE FOREIGN TABLE fdw_pg (
            a INT,
            b INT
          )
          SERVER "pgserver"
          OPTIONS (
            resource 'public.test'
          );
         ```

      1. Query the external table for data:

          ```sql
          SELECT * FROM fdw_pg;
          ```

      1. Populate the external table with data:
          
          ```sql
          INSERT INTO fdw_pg (a, b)
          VALUES (3, 33);
          ```

- {{ objstorage-name }} {#storage}

  1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) named `fdw-agent` and assign it the `storage.editor` role to access the {{ objstorage-name }} bucket.
  1. [Create an {{ objstorage-name }} bucket](../../../storage/operations/buckets/create.md) with restricted access.
  1. [Grant](../../../storage/operations/buckets/edit-acl.md) `fdw-agent` the `READ and WRITE` permissions for the new bucket.
  1. [Create a static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key).
  1. Prepare a test file and upload it to the bucket.
      
      1. Create a test file named `test.csv` on your local machine:

          ```csv
          1,11
          2,22
          ```

      1. [Upload](../../../storage/operations/objects/upload.md) the `test.csv` file to the bucket.
  
  1. Get access to external data in {{ mgp-name }}:
  
      1. [Connect to the database](../connect/index.md) in {{ mgp-name }}.

      1. Create an external data source:
          
          ```sql
          CREATE SERVER "objserver"
            FOREIGN DATA WRAPPER s3_pxf_fdw
            OPTIONS (
              accesskey '<static_access_key_ID>',
              secretkey '<secret_access_key>',
              endpoint '{{ s3-storage-host }}'
            );
          ```

      1. Create a mapping between a local user and a user in the external data source:
  
          ```sql
          CREATE USER MAPPING FOR CURRENT_USER
            SERVER "objserver";
          ```

      1. Create an external table named `fdw_s3` to reference the `test.csv` table in the bucket:

          ```sql
          CREATE FOREIGN TABLE fdw_s3 (
            a INT,
            b INT
          )
          SERVER "objserver"
          OPTIONS (
            resource '<bucket_name>/test.csv',
            format 'csv'
          );
         ```

      1. Query the external table for data:

          ```sql
          SELECT * FROM fdw_s3;
          ```

{% endlist %}

{% note tip %}

You can provide connection parameters either when creating the data source and when creating the external table.

{% cut "Providing connection parameters when creating the external table" %}

```sql
CREATE SERVER "<local_source_name>"
  FOREIGN DATA WRAPPER jdbc_pxf_fdw;

CREATE USER MAPPING FOR CURRENT_USER
  SERVER "<local_source_name>";

CREATE FOREIGN TABLE <table_name>
  (<column_name> <data_type> [, ...])
  SERVER "<local_source_name>"
  OPTIONS (
    resource '<data_path_or_table_name>',
    jdbc_driver '<JDBC_driver_class_name>',
    db_url 'jdbc:<DBMS_type>://<cluster_FQDN>:<port>/<database_name>',
    user '<username>',
    pass '<password>'
  );
```

{% endcut %}

{% endnote %}


## Creating an external table {#sql-statement}

Syntax of an SQL query to create an external table:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <table_name>
       (<column_name> <data_type> [, ...])
       LOCATION('pxf://<data_path_or_table_name>?PROFILE=<profile_name>&SERVER=<source_name>')
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Where:

* `<table_name>`: Name of the external table you are creating in the {{ mgp-name }} cluster.
* `<column_name>`: Column name.
* `<data_type>`: Column data type. It must match the column data type in the external DBMS table.
* `<data_path_or_table_name>`: External object name, see [examples of external tables](#pxf-examples).
* `PROFILE`: Standard interface to an external DBMS (profile), e.g., `JDBC`. The list of possible values depends on the connection type:

    * [S3]({{ gp.docs.broadcom }}-platform-extension-framework/6-9/gp-pxf/access_objstore.html#objstore_connectors)
    * [JDBC]({{ gp.docs.broadcom }}-platform-extension-framework/6-9/gp-pxf/jdbc_pxf.html#queryextdata)
    * [HDFS and Hive]({{ gp.docs.broadcom }}-platform-extension-framework/6-9/gp-pxf/access_hdfs.html#hadoop_connectors)

* `SERVER`: Name of the external PXF data source.

    Instead of `SERVER`, you can provide parameters defining the external data source configuration. These depend on the source connection type. For more information, see the [{{ GP }} PFX guide]({{ gp.docs.broadcom }}-platform-extension-framework/6-9/gp-pxf/intro_pxf.html#create_external_table) and examples of creating external tables.

The `WRITABLE` option allows writing data to an external object. To read data from an external object, create an external table with the `READABLE` option.

## Examples of creating external tables {#pxf-examples}

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

    1. [Create a {{ mch-full-name }} cluster](../../../managed-clickhouse/operations/cluster-create.md) with the `chuser` username.

    
    1. In the cluster subnet, [set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) and [create a security group](../../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.


    1. Optionally, [create an external JDBC data source](create-jdbc-source.md) with the following properties:

        * **Name**: `chserver`
        * **Driver**: `com.clickhouse.jdbc.ClickHouseDriver`
        * **Url**: `jdbc:clickhouse:http://c-<cluster_ID>.rw.{{ dns-zone }}:8123/db1`, where:

            * `c-<cluster_id>.rw.{{ dns-zone }}` is a [special FQDN](../../../managed-clickhouse/operations/connect/fqdn.md#auto) always pointing to an available {{ mch-name }} cluster host.
            * `8123`: Port for [connection](../../../managed-clickhouse/operations/connect/index.md) to the {{ mch-name }} cluster.
            * `db1`: DB name in the {{ mch-name }} cluster.

        * **User**: `chuser`

        You can get the cluster ID with the [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

        With no data source created, you will need to provide the source connection properties in the SQL query for creating an external table.

    1. [Connect to the {{ CH }} DB](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) using `clickhouse-client`.
    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE test (id int) ENGINE = Memory;
        ```

        ```sql
        INSERT INTO test VALUES (1);
        ```

    1. [Connect to the database](../connect/index.md).
    1. Create an external table named `pxf_ch` to reference the `test` table in the {{ CH }} cluster. The SQL query depends on whether you previously created an external data source:

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
            LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.clickhouse.jdbc.ClickHouseDriver&DB_URL=jdbc:clickhouse:https://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mch-http }}/db1&USER=chuser&ssl=true&sslmode=strict&sslrootcert=/etc/greenplum/ssl/allCAs.pem')
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


    1. Optionally, [create an external JDBC data source](create-jdbc-source.md) with the following properties:

        * **Name**: `mysqlserver`
        * **Driver**: `com.mysql.jdbc.Driver`
        * **Url**: `jdbc:mysql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mmy }}/db1`, where:

            * `c-<cluster_ID>.rw.{{ dns-zone }}` is a [special FQDN](../../../managed-mysql/operations/connect/fqdn.md#fqdn-master) always pointing to the current master host in the {{ mmy-name }} cluster.
            * `{{ port-mmy }}`: Port for [connection](../../../managed-mysql/operations/connect/index.md) to the {{ mmy-name }} cluster.
            * `db1`: DB name in the {{ mmy-name }} cluster.

        * **User**: `mysqluser`

        You can get the cluster ID with the [list of clusters](../../../managed-mysql/operations/cluster-list.md#list-clusters) in the folder.

        With no data source created, you will need to provide the source connection properties in the SQL query for creating an external table.

    1. [Connect to the {{ MY }} DB](../../../managed-mysql/operations/connect/index.md#connection-string) using `mysql`.
    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE test (a INT, b INT);
        ```

        ```sql
        INSERT INTO test VALUES (1, 11), (2, 22);
        ```

    1. [Connect to the database](../connect/index.md).
    1. Create an external table named `pxf_mysql` to reference the `test` table in the {{ MY }} cluster. The SQL query depends on whether you previously created an external data source:

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


    1. Optionally, [create an external JDBC data source](create-jdbc-source.md) with the following properties:

        * **Name**: `pgserver`
        * **Driver**: `org.postgresql.Driver`
        * **Url**: `jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mpg }}/db1`, where:

            * `c-<cluster_ID>.rw.{{ dns-zone }}` is a [special FQDN](../../../managed-postgresql/operations/connect/fqdn.md#fqdn-master) always pointing to the current master host in the {{ mpg-name }} cluster.
            * `{{ port-mpg }}`: Port for [connection](../../../managed-postgresql/operations/connect/index.md) to the {{ mpg-name }} cluster.
            * `db1`: DB name in the {{ mpg-name }} cluster.

        * **User**: `pguser`

        You can get the cluster ID with the [list of clusters](../../../managed-postgresql/operations/cluster-list.md#list-clusters) in the folder.

        With no data source created, you will need to provide the source connection properties in the SQL query for creating an external table.

    1. [Connect to the {{ PG }} DB](../../../managed-postgresql/operations/connect/clients.md) using `psql`.
    1. Create a test table and populate it with data:

        ```sql
        CREATE TABLE public.test ("a" INT,"b" INT);
        ```

        ```sql
        INSERT INTO public.test VALUES (1, 11), (2, 22);
        ```

    1. [Connect to the database](../connect/index.md).
    1. Create an external table named `pxf_pg` to reference the `public.test` table in the {{ PG }} cluster. The SQL query depends on whether you previously created an external data source:

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
    1. [Create a static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key).
    1. Optionally, [create an external S3 data source](create-s3-source.md) with the following properties:

        * **Name**: `objserver`.
        * **Access Key**: ID of the static access key created earlier.
        * **Secret Key**: Secret key created earlier together with the static access key.
        * **Endpoint**: `{{ s3-storage-host }}`.

        With no data source created, you will need to provide the source connection properties in the SQL query for creating an external table.

    1. Create a test file named `test.csv` on your local machine:

        ```csv
        1,111
        2,222
        ```

    1. [Upload your test file to the bucket](../../../storage/operations/objects/upload.md).

        Files you are uploading to the bucket must not start with `.` or `_`. Such files are considered hidden, and PXF does not read data from them.

    1. [Connect to the database](../connect/index.md).
    1. To read data from an {{ objstorage-name }} bucket:

        1. Create an external table named `pxf_s3_read` to reference the bucket. The SQL query depends on whether you previously created an external data source:

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

    1. To write data to an {{ objstorage-name }} bucket:

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

        1. Populate the table with data:

            ```sql
            INSERT INTO pxf_s3_write VALUES (3,333);
            ```

            ```text
            INSERT 0 1
            ```

        1. Make sure that [a new object has been created](../../../storage/operations/objects/info.md) in the bucket.

    {% note info %}

    To create an external table from {{ objstorage-name }}, you can use the S3 protocol and transmit your static key properties using a file located on a web server. For more information, see [this tutorial](../../tutorials/config-server-for-s3.md).

    {% endnote %}

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
