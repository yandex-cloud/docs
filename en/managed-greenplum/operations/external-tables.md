# Using external tables

{{ GP }} lets you work with data from sources that are external to a {{ mgp-name }} cluster. This functionality uses _external tables_, which are special objects in a {{ GP }} database that reference external source tables, buckets, or files. Access to [data in external DBMS](#pxf) uses the _PXF_ protocol whereas access to [files on external file servers](#gpfdist) uses the _GPFDIST_ utility.

{% note info %}


To connect to external sources, [set up an NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet hosting the {{ mgp-name }} cluster.


{% endnote %}

With external tables, you can:

* Query external data sources.
* Load datasets from external sources into a {{ GP }} database.
* Join local and external tables in queries.
* Write data to external tables or files.

{% note info %}

For security reasons, {{ mgp-name }} does not support creating [external web tables]({{ gp.docs.pivotal }}/6-19/admin_guide/external/g-creating-and-using-web-external-tables.html) that use shell scripts.

{% endnote %}

## Connecting to external DBMS {#pxf}

The [{{ GP }} Platform Extension Framework (PXF)]({{ gp.docs.pivotal }}/6-4/pxf/overview_pxf.html) is a software platform that provides access to data from external DBMS's. You can connect tables from the following external sources:

* Apache Hive
* {{ CH }}
* HBase
* HDFS
* {{ MY }}
* Oracle
* {{ PG }}
* {{ MS }}
* {{ objstorage-full-name }} buckets

### Creating an external table using PXF {#create-pxf-table}

SQL query syntax to create an external table:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <table name>
       (<column name> <data type> [, ...])
       LOCATION('pxf://<data path or table name>?PROFILE=<profile name>&JDBC_DRIVER=<JDBC driver name>&DB_URL=<connection string>&USER=<username>&PASS=<user password>')
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Where:

* `table name`: Name of the external table to be created in the {{ GP }} cluster.
* `column name`: Name of a column.
* `data type`: Type of column data. It must match the column data type in the external DBMS table.
* `data path or table name`: External object name, see [example external tables](#pxf-examples).
* (optional) `profile name`: Standard interface to external DBMS, such as `JDBC`.
* (optional) `JDBC driver name`: JDBC driver to be used to connect to an external DBMS.
* (optional) `connection string`: External DBMS connection URL.
* (optional) `username`: Username to connect to the external DBMS.
* (optional) `user password`: User password to connect to an external DBMS.

The `WRITABLE` option enables you to write data to an external object. To be able to read data from an external object, create a table with the `READABLE` option.

This SQL query does not contain an exhaustive list of available parameters. For more information, see the [{{ GP }} documentation]({{ gp.docs.pivotal }}/6-4/pxf/intro_pxf.html) and examples for creating external tables.

### Examples for creating external tables {#pxf-examples}

{% list tabs %}

- {{ CH }}

   1. [Create a {{ mch-full-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with the following settings:

      * User name: `chuser`.
      * Password: `chpassword`.

   1. [Connect to a {{ CH }} database](../../managed-clickhouse/operations/connect#connection-string) using `clickhouse-client`.
   1. Create a test table and populate it with data:

      ```sql
      CREATE TABLE test (id int) ENGINE = Memory;
      ```

      ```sql
      INSERT INTO test VALUES (1);
      ```

   1. [Connect to the DB {{ GP }}](connect.md).
   1. Create an external table named `pxf_ch` to reference a table named `test` in the {{ CH }} cluster:

      ```sql
      CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
      LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.clickhouse.jdbc.ClickHouseDriver&DB_URL=jdbc:clickhouse:http://c-<cluster ID>.rw.{{ dns-zone }}:8123/db1&USER=chuser&PASS=chpassword')
      FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
      ```

      If public access is enabled for {{ CH }} hosts, use an encrypted connection when creating an external table. To do this, specify SSL parameters and `{{ port-mch-http }}` port in your request:

      ```sql
      CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
      LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.clickhouse.jdbc.ClickHouseDriver&DB_URL=jdbc:clickhouse:https://c-<cluster ID>.rw.mdb.yandexcloud.net:{{ port-mch-http }}/db1&USER=chuser&PASS=chpassword&ssl=true&sslmode=strict&sslrootcert=/etc/greenplum/ssl/allCAs.pem')
      FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
      ```

      You can get the cluster ID with a [list of clusters in the folder](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

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

- {{ MY }}

   1. [Create a {{ mmy-full-name }} cluster](../../managed-mysql/operations/cluster-create.md) with the following settings:

      * User name: `mysqluser`.
      * Password: `mysqlpassword`.
      * In the host settings, select the **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** option.

   1. [Connect to a {{ MY }} database](../../managed-mysql/operations/connect#connection-string) using `mysql`.
   1. Create a test table and populate it with data:

      ```sql
      CREATE TABLE test (a INT, b INT);
      ```

      ```sql
      INSERT INTO test VALUES (1, '11'), (2, '22');
      ```

   1. [Connect to the DB {{ GP }}](connect.md).
   1. Create an external table named `pxf_mysql` to reference the `test` table in the {{ MY }} cluster:

      ```sql
      CREATE READABLE EXTERNAL TABLE pxf_mysql(a int, b int)
      LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.mysql.jdbc.Driver&DB_URL=jdbc:mysql://c-<cluster ID>.rw.{{ dns-zone }}:3306/db1&USER=mysqluser&PASS=mysqlpassword')
      FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
      ```

      You can get the cluster ID with a [list of clusters in the folder](../../managed-mysql/operations/cluster-list.md#list-clusters).

   1. Query the external table for data:

      ```sql
      SELECT * FROM pxf_mysql;
      ```

      Result:

      ```text
      test_pxf=> SELECT * FROM pxf_mysql;
      a | b
      ---+----
      1 | 11
      2 | 22
      (2 rows)
      ```

- {{ PG }}

   1. [Create a {{ mpg-full-name }} cluster](../../managed-postgresql/operations/cluster-create.md) with the following settings:

      * User name: `pguser`.
      * Password: `pgpassword`.
      * In the host settings, select the **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** option.

   1. [Connect to a {{ PG }} database](../../managed-postgresql/operations/connect.md#bash) using `psql`.
   1. Create a test table and populate it with data:

      ```sql
      CREATE TABLE public.test ("a" INT,"b" INT);
      ```

      ```sql
      INSERT INTO public.test VALUES (1, '11'), (2, '22');
      ```

   1. [Connect to the DB {{ GP }}](connect.md).
   1. Create an external table named `pxf_pg` to reference a table named `public.test` in the {{ PG }} cluster:

      ```sql
      CREATE READABLE EXTERNAL TABLE pxf_pg(a int, b int)
      LOCATION ('pxf://public.test?PROFILE=JDBC&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://c-<cluster ID>.rw.{{ dns-zone }}:6432/db1&USER=pguser&PASS=pgpassword')
      FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
      ```

      You can get the cluster ID with a [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list-clusters).

   1. Query the external table for data:

      ```sql
      SELECT * FROM pxf_pg;
      ```

      Result:

      ```text
      test_pxf=> SELECT * FROM pxf_pg;
      a | b
      ---+----
      1 | 11
      2 | 22
      (2 rows)
      ```

- {{ objstorage-name }}

   1. [Create a {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) with restricted access.

   1. [Create a static access key](../../iam/operations/sa/create-access-key.md).

   1. Create a test file `test.csv` on the local machine:

      ```csv
      1,111
      2,222
      ```

   1. [Upload your test file to the bucket](../../storage/operations/objects/upload.md).

   1. [Connect to the DB {{ GP }}](connect.md).

   1. To read data from the {{ objstorage-name }} bucket:

      1. Create an external table named `pxf_s3_read` to reference a bucket:

         ```sql
         CREATE READABLE EXTERNAL TABLE pxf_s3_read(a int, b int)
         LOCATION ('pxf://<bucket name>/test.csv?PROFILE=s3:text&accesskey=<key ID>&secretkey=<secret key>&endpoint={{ s3-storage-host }}')
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

         ```sql
         CREATE WRITABLE EXTERNAL TABLE pxf_s3_write(a int, b int)
         LOCATION ('pxf://<bucket name>/?PROFILE=s3:text&accesskey=<key ID>&secretkey=<secret key>&endpoint={{ s3-storage-host }}')
         FORMAT 'CSV';
         ```

      1. Insert data into the table

         ```sql
         INSERT INTO pxf_s3_write VALUES (3,333);
         ```

         ```text
         INSERT 0 1
         ```

      1. Make sure in the bucket, that a new object [has been created](../../storage/operations/objects/info.md).

   {% note info %}

   To create an external table from {{ objstorage-name }}, you can use the `s3` protocol and transmit your static key parameters using a file located on a web server. For more information, see the [tutorial](../tutorials/config-server-for-s3.md).

   {% endnote %}

{% endlist %}

## Connecting to an external file server {#gpfdist}

[{{ GP }} Parallel File Server (GPFDIST)]({{ gp.docs.pivotal }}/6-19/admin_guide/external/g-using-the-greenplum-parallel-file-server--gpfdist-.html) is a utility to read data from and write data to files located on remote servers. It is installed on each segment host of a {{ mgp-name }} cluster and provides parallel data loading by distributing it across segments either evenly or according to the [distribution key](../concepts/sharding.md#distribution-key) set. This improves performance when handling large amounts of external data.

GPFDIST works with any delimited text files and compressed gzip and bzip2 files.

To read or write files on an external server:
1. [Install and run GPFDIST](#run-gpfdist) as part of the Greenplum Loader or Greenplum Database package on the remote server where your target files are located.
1. [Create an external table](#create-gpfdist-table) in the {{ GP }} database to reference these files.

### Running GPFDIST {#run-gpfdist}


{% note info %}

Downloading and using software from the VMware website is not part of the [{{ mgp-full-name }} Terms of Use]({{ link-cloud-terms-of-use }}) and is governed by a separate arrangement between the client and VMware. Yandex is not responsible for the relationship between VMware and the client arising in connection with the client's use of VMware products or services.

{% endnote %}


1. Download and install the Greenplum Loader package from the [VMware website](https://greenplum.docs.pivotal.io/6-19/client_tool_guides/installing.html) or the Greenplum Database package from a {{ objstorage-full-name }} bucket by following [this guide](./greenplum-db.md).

1. Run the GPFDIST utility:

   ```bash
   gpfdist -d <data file directory> -p <connection port> -l <log file path>
   ```

   Where:

   * `data file directory` is the local path to the directory with files to read or write data from/to using the external table.
   * `connection port` is the port the utility will run on. The default value is `8080`.
   * `log file path` (optional) is the path to the file that GPFDIST will write its operation logs to.

   You can run multiple GPFDIST instances on the same server, specifying different directories and connection ports to distribute network load. For example:

   ```bash
   gpfdist -d /var/load_files1 -p 8081 -l /home/gpadmin/log1 &
   gpfdist -d /var/load_files2 -p 8082 -l /home/gpadmin/log2
   ```

1. Make sure that files from the specified directory are available on the specified port from {{ yandex-cloud }}. To do this, run the following command from a VM in {{ yandex-cloud }}:

   ```bash
   wget http://hostname:port/filename
   ```

### Creating an external table using GPFDIST {#create-gpfdist-table}

SQL query syntax to create an external table:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <table name>
       (<column name> <data type> [, ...])
       LOCATION('gpfdist://<path to file on remote server>' [, ...])
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Where:

* `table name`: Name of the external table to be created in the {{ GP }} database.
* `column name`: Name of a table column.
* `data type`: Type of table column data.
* `remote server file path`: Address of the server where GPFDIST is running, the connection port, and the path to the file. You can set a specific file or a mask using the asterisk symbol (*).

The `WRITABLE` option enables you to write data to an external object. To be able to read data from an external object, create a table with the `READABLE` option.

### Examples for creating external tables {#gpfdist-examples}

* Creating an external table with data from `file.csv` on the `hostname` server:

   ```sql
   CREATE EXTERNAL TABLE tableName (id int)
          LOCATION('gpfdist://hostname:8080/file.csv')
          FORMAT 'CSV' (DELIMITER ',');
   ```

* Creating an external table with data from all `txt` files, where `|` is a separator and the space indicates `NULL` values, on `hostname1` and `hostname2` servers:

   ```sql
   CREATE EXTERNAL TABLE tableName (...)
          LOCATION('gpfdist://hostname1:8081/*.txt',
                   'gpfdist://hostname2:8081/*.txt')
          FORMAT 'TEXT' (DELIMITER '|' NULL ' ');
   ```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
