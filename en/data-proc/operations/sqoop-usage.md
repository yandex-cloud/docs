---
title: "How to use Sqoop in {{ dataproc-full-name }}"
description: "This guide describes how to use Sqoop."
---

# Using Sqoop

[Sqoop](https://sqoop.apache.org/) is used to import databases to the {{ dataproc-name }} cluster from external sources. The section includes:

* Details about [creating connect strings](#jdbc-url-getting) and [setting up drivers](#driver-installation) for Sqoop.
* Scoop commands to import data to:

   * [{{ objstorage-full-name }}](#object-storage).
   * [HDFS directory](#hdfs).
   * [Apache Hive](#apache-hive).
   * [Apache HBase](#apache-hbase).

{% include [No Sqoop in DataProc v2.0](../../_includes/data-proc/no-sqoop-in-dataproc2.md) %}

## Creating a JDBC connect string {#jdbc-url-getting}

A JDBC connect string has the following format:

{% list tabs %}

- {{ PG }}

   ```http
   jdbc:postgresql://<database_server_address>:5432/<database_name>
   ```

   For {{ mpg-full-name }}, use a string with a [special FQDN](../../managed-postgresql/operations/connect.md#fqdn-master) pointing at the master host:

   ```http
   jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mpg }}/<database_name>
   ```

   You can get the cluster ID with a [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list-clusters).

- {{ MY }}

   ```http
   jdbc:mysql://<database_server_address>:3306/<database_name>
   ```

   For {{ mmy-full-name }}, use a string with a [special FQDN](../../managed-mysql/operations/connect.md#fqdn-master) pointing at the master host:

   ```http
   jdbc:mysql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mmy }}/<database_name>
   ```

   You can get the cluster ID with a [list of clusters in the folder](../../managed-mysql/operations/cluster-list.md#list-clusters).

{% endlist %}

## Installing a JDBC driver {#driver-installation}

For Sqoop to connect to the database using a JDBC connect string, install a JDBC driver:

{% list tabs %}

- {{ PG }}

   {{ dataproc-name }} has a pre-installed {{ mpg-full-name }} driver, so no additional action is needed.

- {{ MY }}

   [Connect](./connect.md) over SSH to the {{ dataproc-name }} subcluster host that stores the data and run this command:

   ```bash
   MYSQL_VER="8.0.25" && \
   wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_VER}.tar.gz" \
       --output-document 'mysql-connector-java.tar.gz' && \
   sudo tar -xf mysql-connector-java.tar.gz -C /var/lib/sqoop/ && \
   export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/var/lib/sqoop/mysql-connector-java-${MYSQL_VER}.jar
   ```

   {% note info %}

   To install other version of the driver, change the `MYSQL_VER` variable in the command.

   {% endnote %}

{% endlist %}

## Importing with Sqoop {#import-with-sqoop}

### To {{ objstorage-name }} {#object-storage}

This type of import is available if the `Sqoop` component is enabled in the {{ dataproc-name }} cluster.

To import the data to the {{ objstorage-name }} bucket:

1. When [creating](cluster-create.md) or editing the {{ dataproc-name }} cluster, specify the bucket name to import the data to {{ objstorage-name }}. Make sure that the {{ dataproc-name }} service account has [write permissions](../../storage/operations/buckets/edit-acl.md) for this bucket.
1. [Create connect strings](#jdbc-url-getting) for JDBC.
1. [Connect](connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. [Install drivers](#driver-installation) for Sqoop if they are not installed.
1. Run this command:

   ```bash
   sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
     --connect <JDBC_connect_string> \
     --username <database_user_name> \
     --P \
     --table '<database_table_name>' \
     --target-dir 's3a://<name_of_target_bucket>/<target_folder>' \
     --split-by '<table_column>'
   ```

   Where `--split-by` is the table column used for splitting.

   {% note warning %}

   Do not specify the name of an existing bucket directory.

   {% endnote %}

### To the HDFS directory {#hdfs}

This type of import is available if the following services are enabled in the {{ dataproc-name }} cluster:

* `HBase`
* `HDFS`
* `Sqoop`
* `Yarn`
* `Zookeeper`

To import the data to the HDFS directory:

1. [Create connect strings](#jdbc-url-getting) for JDBC.
1. [Connect](connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. [Install drivers](#driver-installation) for Sqoop if they are not installed.
1. Run this command:

   ```bash
   sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
     --connect <JDBC_connect_string> \
     --username <database_user_name> \
     --table '<database_table_name>' \
     --target-dir '<HDFS_folder>' \
     --P \
     --split-by '<table_column>'
   ```

   Where `--split-by` is the table column used for splitting.

   {% note warning %}

   Do not specify the name of an existing HDFS directory.

   {% endnote %}

### To Apache Hive {#apache-hive}

This type of import is available if the following services are enabled in the {{ dataproc-name }} cluster:

* `HDFS`
* `Hive`
* `Mapreduce`
* `Sqoop`
* `Yarn`

To import the data to the Hive table:

1. When [creating](cluster-create.md) or editing the {{ dataproc-name }} cluster, add to the cluster properties the `hive:hive.execution.engine` key with the `mr` value.
1. [Create connect strings](#jdbc-url-getting) for JDBC.
1. [Connect](connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. [Install drivers](#driver-installation) for Sqoop if they are not installed.
1. Create a Hive database:

   ```bash
   hive -e "CREATE DATABASE <Hive_database_name>;"
   ```

1. Run this command:

   ```bash
   sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
     --connect <JDBC_connect_string> \
     --username <source_database_user_name> \
     --P \
     --table '<source_database_table_name>' \
     --hive-import \
     --create-hive-table \
     --hive-database '<Hive_database_name>' \
     --hive-table '<Hive_table_name>' \
     --split-by '<table_column>'
   ```

   Where `--split-by` is the table column used for splitting.

   {% note warning %}

   Do not specify the name of an existing Hive table.

   {% endnote %}

### To Apache HBase {#apache-hbase}

This type of import is available if the following services are enabled in the {{ dataproc-name }} cluster:

* `HBase`
* `HDFS`
* `Sqoop`
* `Yarn`
* `Zookeeper`

To import data to Apache HBase:

1. [Create connect strings](#jdbc-url-getting) for JDBC.
1. [Connect](connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. [Install drivers](#driver-installation) for Sqoop if they are not installed.
1. Run this command:

   ```bash
   sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
     --connect <JDBC_connect_string> \
     --username <source_database_user_name> \
     --P \
     --table '<source_database_table_name>' \
     --hbase-create-table \
     --column-family '<HBase_column_family>' \
     --hbase-table '<HBase_table_name>' \
     --split-by '<table_column>'
   ```

   Where `--split-by` is the table column used for splitting.

   {% note warning %}

   Do not specify the name of an existing HBase table.

   {% endnote %}

