# Exchanging data between {{ mch-full-name }} and {{ dataproc-full-name }}

To configure data export and import between {{ mch-full-name }} and {{ dataproc-full-name }} clusters:
1. [Before you start](#before-you-begin).
1. [Export data from {{ mch-full-name }}](#export-from-mch).
1. [Upload the data to {{ mch-full-name }}](#import-to-mch).

If you no longer need these resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% note info %}

Create clusters and a VM on the same cloud network.

{% endnote %}

1. [Create an {{ mch-full-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) in any [suitable configuration](../../managed-clickhouse/concepts/instance-types.md) with the following settings:
   * With the `db1` database.
   * With the `user1` user.
1. [Create an {{ dataproc-full-name }} cluster](../../data-proc/operations/cluster-create.md) in any [suitable configuration](../../data-proc/concepts/instance-types.md) with the following settings:
   * With the **UI Proxy** option enabled;
   * With the components below:
      * **HBASE**
      * **HDFS**
      * **HIVE**
      * **MAPREDUCE**
      * **SPARK**
      * **TEZ**
      * **YARN**
      * **ZEPPELIN**
      * **ZOOKEEPER**
1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) to connect to {{ mch-full-name }} and {{ dataproc-full-name }} clusters.
1. [Connect to a virtual machine over SSH](../../compute/operations/vm-connect/ssh.md) and configure the cluster connection:
   * [{{ mch-full-name }}](../../managed-clickhouse/operations/connect.md);
   * [{{ dataproc-full-name }}](../../data-proc/operations/connect.md).
1. (Optional) To export data to a [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md):
   1. [Create a {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md).
   1. [Grant write privileges](../../storage/operations/buckets/edit-acl.md) to the {{ dataproc-full-name }} cluster service account.

### Required paid resources {#paid-resources}

The cost of support for data exchange between {{ mch-full-name }} and {{ dataproc-full-name }} includes:
* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Export data from {{ mch-full-name }} {#export-from-mch}

### Prepare the {{ mch-full-name }} cluster {#prepare-mch}

1. [Connect to the](../../managed-clickhouse/operations/connect.md) `db1` database of the {{ mch-full-name }} cluster on behalf of `user1`.
1. Add test data to the database. As an example, a simple table is used with people's names and ages.

   1. Create a table:

      ```sql
      CREATE TABLE persons (
          `name` String,
          `age` UInt8) ENGINE = MergeTree ()
      ORDER BY
          `name`;
      ```

   1. Populate the table with data:

      ```sql
      INSERT INTO persons VALUES
         ('Anna', 19),
         ('Michael', 65),
         ('Fred', 28),
         ('Alsou', 50),
         ('Max', 27),
         ('John', 34),
         ('Dmitry', 42),
         ('Oleg', 19),
         ('Alina', 20),
         ('Maria', 28);
      ```

### Start an export from {{ mch-full-name }} {#start-mch-export}

1. Open the [Zeppelin web interface](../../data-proc/operations/connect-interfaces.md#ui-proxy-list) of the {{ dataproc-full-name }} cluster.
1. Click the **Create new note** link and specify the parameters of your Zeppelin notebook:
   * **Note name**: Enter any name for the notebook.
   * **Default Interpreter**: Select `spark`.
1. Click **Create**.
1. To generate a dataframe, create and run a paragraph with code. To run a paragraph, click **Run this paragraph** or use the **Shift** + **Enter** keyboard shortcut. The paragraph text depends on whether there is public access to the {{ mch-full-name }} cluster hosts.

   {% list tabs %}

   - Connecting without using SSL

      ```python
      %spark.pyspark
      jdbcPort = 8123
      jdbcHostname = "c-<{{ mch-full-name }} cluster ID>.rw.{{ dns-zone }}"
      jdbcDatabase = "db1"
      jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}"
      df = spark.read.format("jdbc") \
      .option("url", jdbcUrl) \
      .option("user","user1") \
      .option("password","<{{ mch-full-name }} database password>") \
      .option("dbtable","persons") \
      .load()
      df.show()
      ```

   - Connecting via SSL

      ```python
      %spark.pyspark
      jdbcPort = 8443
      jdbcHostname = "c-<{{ mch-full-name }} cluster ID>.rw.{{ dns-zone }}"
      jdbcDatabase = "db1"
      jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
      df = spark.read.format("jdbc") \
      .option("url", jdbcUrl) \
      .option("user","user1") \
      .option("password","<{{ mch-full-name }} database password>") \
      .option("dbtable","persons") \
      .load()
      df.show()
      ```

   {% endlist %}

   If the dataframe generates successfully, the response will contain a table with the original data.

1. To export information from a dataframe to a {{ objstorage-full-name }} bucket or a Hive table, create and run a paragraph with code.

   {% list tabs %}

   - {{ objstorage-name }}

      ```python
      %spark.pyspark
      df.write.parquet('s3a://<bucket name>/<bucket directory>/')
      spark.read.parquet('s3a://<bucket name>/<bucket directory/').show()
      ```

   - Hive

      ```python
      %spark.pyspark
      df.createOrReplaceTempView("mytempTable")
      spark.sql("CREATE TABLE IF NOT EXISTS persons AS SELECT * FROM mytempTable");
      spark.sql("SELECT * FROM persons").show()
      ```

   {% endlist %}

   If the export was successful, the response will contain a table with the original data.


## Upload the data to {{ mch-full-name }} {#import-to-mch}

### Prepare the source data {#prepare-source-data}

An HDFS directory or a {{ objstorage-full-name }} bucket can function as a data source. A CSV file containing people's names and ages will act as the data source:

```text
name,age
Anna,19
Michael,65
Fred,28
Alsou,50
Max,27
John,34
Dmitry,42
Oleg,19
Alina,20
Maria,28
```

{% list tabs %}

- {{ objstorage-name }}

   Create a file with test data called `example.csv` and upload it to the {{ objstorage-full-name }} bucket.

- HDFS directory

   1. [Connect to a {{ dataproc-full-name }} cluster host](../../data-proc/operations/connect.md) in the data storage subcluster.
   1. Get the HDFS server address. You will need to specify this address when uploading data to the HDFS directory.

      ```bash
      hdfs getconf -confKey fs.defaultFS
      ```

   1. Create a file with test data named `example.csv`.
   1. Create an HDFS directory to write the test data to:

      ```bash
      hdfs fs -mkdir /user/testdata
      ```

   1. Copy the test data file from the local file system to the HDFS directory:

      ```bash
      hdfs dfs -copyFromLocal example.csv /user/testdata/example.csv
      ```

{% endlist %}

### Start an export from {{ dataproc-full-name }} {#start-dp-export}

1. Open the [Zeppelin web interface](../../data-proc/operations/connect-interfaces.md#ui-proxy-list) of the {{ dataproc-full-name }} cluster.
1. Click the **Create new note** link and specify the parameters of your Zeppelin notebook:
   * **Note name**: Enter any name for the notebook.
   * **Default Interpreter**: Select `spark`.
1. Click **Create**.
1. To generate a dataframe, create and run a paragraph with code.

   {% list tabs %}

   - {{ objstorage-name }}

      ```python
      %spark.pyspark
      df = spark.read.option("header", True).csv("s3a://<bucket name>/<bucket directory>/example.csv")
      df.show()
      ```

   - HDFS directory

      ```python
      %spark.pyspark
      df = spark.read.option("header", True).csv("hdfs://<HDFS server address>/user/testdata/example.csv")
      df.show()
      ```

   If the export was successful, the response will contain a table with the original data.

   {% endlist %}

1. To export information from a dataframe to a {{ mch-full-name }} database, create and run a paragraph with the code. The paragraph text depends on whether there is public access to the {{ mch-full-name }} cluster hosts.

   {% list tabs %}

   * Connecting without using SSL

      ```python
      %spark.pyspark
      jdbcPort = 8123
      jdbcHostname = "c-<{{ mch-full-name }} cluster ID>.rw.{{ dns-zone }}"
      jdbcDatabase = "db1"
      jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}"
      df.write.format("jdbc") \
      .mode("error") \
      .option("url", jdbcUrl) \
      .option("dbtable", "example") \
      .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
      .option("user","user1") \
      .option("password","<{{ mch-full-name }} database password>") \
      .save()
      ```

   * Connecting via SSL

      ```python
      %spark.pyspark
      jdbcPort = 8443
      jdbcHostname = "c-<{{ mch-full-name }} cluster ID>.rw.{{ dns-zone }}"
      jdbcDatabase = "db1"
      jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
      df.write.format("jdbc") \
      .mode("error") \
      .option("url", jdbcUrl) \
      .option("dbtable", "example") \
      .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
      .option("user","user1") \
      .option("password","<{{ mch-full-name }} database password>") \
      .save()
      ```

   {% endlist %}

### Verify the data import in {{ mch-full-name }} {#check-mch-export}

1. [Connect to the](../../managed-clickhouse/operations/connect.md) `db1` database of the {{ mch-full-name }} cluster on behalf of `user1`.
1. Run the query:

   ```sql
   SELECT * FROM example;
   ```

   If the import was successful, the response will contain a table with the data.

## How to delete created resources {#clear-out}

To stop paying for the resources created:

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. If you reserved a public static IP address for the VM, [delete it](../../vpc/operations/address-delete.md).
1. Delete the clusters:
   * [{{ mch-full-name }}](../../managed-clickhouse/operations/cluster-delete.md);
   * [{{ dataproc-full-name }}](../../data-proc/operations/cluster-delete.md).
1. If you created an {{ objstorage-full-name }} bucket, [delete it](../../storage/operations/buckets/delete.md).
