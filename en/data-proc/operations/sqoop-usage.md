# How to use Sqoop

[Sqoop](https://sqoop.apache.org/) is used to import databases to the {{ dataproc-name }} cluster from external sources. The section includes:

* Details about [creating connect strings](#jdbc-url-getting) and [setting up drivers](#driver-installation) for Sqoop.
* Scoop commands to import data to:

   * [{{ objstorage-full-name }}](#object-storage).
   * [An HDFS directory](#hdfs).
   * [Apache Hive](#apache-hive).
   * [Apache HBase](#apache-hbase).

## Creating a JDBC connect string {#jdbc-url-getting}

A JDBC connect string has the following format:

{% list tabs %}

- {{ PG }}

   ```http
   jdbc:postgresql://<database server address>:5432/<database name>
   ```

   For {{ mpg-full-name }}, use a string with a [special FQDN](../../managed-postgresql/operations/connect.md#fqdn-master) pointing at the master host:

   ```http
   jdbc:postgresql://c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mpg }}/<database name>
   ```

   You can get the cluster ID with a [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list-clusters).

- {{ MY }}

   ```http
   jdbc:mysql://<database server address>:3306/<database name>
   ```

   For {{ mmy-full-name }}, use a string with a [special FQDN](../../managed-mysql/operations/connect.md#fqdn-master) pointing at the master host:

   ```http
   jdbc:postgresql://c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mmy }}/<database name>
   ```

   You can get the cluster ID with a [list of clusters in the folder](../../managed-mysql/operations/cluster-list.md#list-clusters).

{% endlist %}

## Installing a JDBC driver {#driver-installation}

For Sqoop to connect to the database using a JDBC connect string, install a JDBC driver:

{% list tabs %}

- {{ PG }}

   {{ dataproc-name }} has a pre-installed {{ mpg-full-name }} driver, so no additional action is needed.

- {{ MY }}

   [Connect](./connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data, then run the command:

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

### In {{ objstorage-name }} {#object-storage}

This type of import is available if the `Sqoop` component is enabled in the {{ dataproc-name }} cluster.

To import the data to the {{ objstorage-name }} bucket:

1. When [creating](cluster-create.md) or editing the {{ dataproc-name }} cluster, specify the bucket name to import the data to {{ objstorage-name }}. Make sure that the {{ dataproc-name }} service account has [write permissions](../../storage/operations/buckets/edit-acl.md) for this bucket.
1. [Create connect strings](#jdbc-url-getting) for JDBC.
1. [Connect](connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. [Install drivers](#driver-installation) for Sqoop if they are not installed.
1. Run the command:

   ```bash
   sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
     --connect <JDBC connect string> \
     --username <database username> \
     --P \
     --table '<database table name>' \
     --target-dir 's3a://<bucket name for import>/<target directory>' \
     --split-by '<table column used for splitting>'
   ```

   {% note warning %}

   Don't specify a name of an existing bucket directory.

   {% endnote %}

### To the HDFS directory {#hdfs}

This type of import is available if the following services are enabled in the {{ dataproc-name }} cluster:

* `HBase`;
* `HDFS`;
* `Sqoop`;
* `Yarn`;
* `Zookeeper`.

To import the data to the HDFS directory:

1. [Create connect strings](#jdbc-url-getting) for JDBC.
1. [Connect](connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. [Install drivers](#driver-installation) for Sqoop if they are not installed.
1. Run the command:

   ```bash
   sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
     --connect <JDBC connect string> \
     --username <database username> \
     --table '<database table name>' \
     --target-dir '<HDFS directory>' \
     --P \
     --split-by '<table column used for the splitting>'
   ```

   {% note warning %}

   Don't specify a name of an existing HDFS directory.

   {% endnote %}

### To Apache Hive {#apache-hive}

This type of import is available if the following services are enabled in the {{ dataproc-name }} cluster:

* `HDFS`;
* `Hive`;
* `Mapreduce`;
* `Sqoop`;
* `Yarn`.

To import the data to the Hive table:

1. When [creating](cluster-create.md) or editing the {{ dataproc-name }} cluster, add to the cluster properties the `hive:hive.execution.engine` key with the `mr` value.
1. [Create connect strings](#jdbc-url-getting) for JDBC.
1. [Connect](connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. [Install drivers](#driver-installation) for Sqoop if they are not installed.
1. Create a Hive database:

   ```bash
   hive -e "CREATE DATABASE <Hive database name>;"
   ```

1. Run the command:

   ```bash
   sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
     --connect <JDBC connect string> \
     --username <source database username> \
     --P \
     --table '<table name in the source database>' \
     --hive-import \
     --create-hive-table \
     --hive-database '<Hive database name>' \
     --hive-table '<Hive table name>' \
     --split-by '<table column used for splitting>'
   ```

   {% note warning %}

   Don't specify a name of an existing Hive table.

   {% endnote %}

### In Apache HBase {#apache-hbase}

This type of import is available if the following services are enabled in the {{ dataproc-name }} cluster:

* `HBase`;
* `HDFS`;
* `Sqoop`;
* `Yarn`;
* `Zookeeper`.

To import data to Apache HBase:

1. [Create connect strings](#jdbc-url-getting) for JDBC.
1. [Connect](connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. [Install drivers](#driver-installation) for Sqoop if they are not installed.
1. Run the command:

   ```bash
   sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
     --connect <JDBC connect string> \
     --username <source database username> \
     --P \
     --table '<source database table name>' \
     --hbase-create-table \
     --column-family '<HBase column family>' \
     --hbase-table '<HBase table name>' \
     --split-by '<table column used for splitting>'
   ```

   {% note warning %}

   Don't specify a name of an existing HBase table.

   {% endnote %}

