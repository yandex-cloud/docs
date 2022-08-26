# Exchanging data between {{ mch-full-name }} and {{ dataproc-full-name }}

To configure data export and import between {{ mch-name }} and {{ dataproc-name }} clusters:
1. [Before you start](#before-you-begin).
1. [Export data from {{ mch-name }}](#export-from-mch).
1. [Upload the data to {{ mch-name }}](#import-to-mch).

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [Same Network](../../_includes/same-network.md) %}

1. [Create a cloud network](../../vpc/operations/network-create.md).
1. [Create a subnet](../../vpc/operations/subnet-create.md) in the `{{ zone-id }}` availability zone. While creating it, select **NAT for internet access**: this is required for {{ dataproc-name }} clusters to run.

Create resources:

{% list tabs %}

- Manually

   1. [Create an {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) in any [suitable configuration](../../managed-clickhouse/concepts/instance-types.md) with the following settings:
      * With public access to cluster hosts.
      * With the `db1` database.
      * With the `user1` user.
   1. [Create a service account](../../iam/operations/sa/create.md#create-sa) for the {{ dataproc-name }} cluster. [Assign it the roles](../../iam/operations/sa/assign-role-for-sa.md):

      * `dataproc.agent`
      * `dataproc.provisioner`
      * `monitoring.viewer`.
   1. [Create an {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) in any [suitable configuration](../../data-proc/concepts/instance-types.md) with the following settings:
      * With the **UI Proxy** option enabled;
      * With the previously created service account.
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
   1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) to connect to {{ mch-name }} and {{ dataproc-name }} clusters.
   1. [Connect to a virtual machine over SSH](../../compute/operations/vm-connect/ssh.md) and configure the cluster connection:
      * [{{ mch-name }}](../../managed-clickhouse/operations/connect.md);
      * [{{ dataproc-name }}](../../data-proc/operations/connect.md).
   1. (Optional) To export data to a [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md):
      1. [Create a {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).
      1. [Grant write privileges](../../storage/operations/buckets/edit-acl.md) to the {{ dataproc-name }} cluster service account.

- Using {{ TF }}

   1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [data-proc-data-exchange-with-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-proc-data-exchange-with-mch.tf) configuration file to the same working directory.

      The file describes:
      * [Security groups](../../vpc/concepts/security-groups.md) for the clusters and the virtual machine.
      * [Service account](../../iam/concepts/users/service-accounts.md) for the {{ dataproc-name }} cluster.
      * [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md).
      * {{ mch-name }} cluster.
      * {{ dataproc-name }} cluster.
      * Virtual machine.

   1. Specify the infrastructure settings in the `data-proc-data-exchange-with-mch.tf` configuration file under `locals`:

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
      * `network_id`: ID of previously created cloud network.
      * `subnet_id`: ID of the previously created subnet.
      * `zone_id`: Availability zone where resources will be created.
      * `ch_user_name`: {{ mch-name }} `db1` database username.
      * `pg_cluster_password`: Password of the `user1` user of the {{ mch-name }} `db1` database.
      * `vm_username`: Virtual machine username.
      * `vm_ssh_key`: Absolute path to the virtual machine public key. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md).
      * `vm_image_id`: Virtual machine image. [Select the desired image from the list](../../compute/operations/images-with-pre-installed-software/get-list.md) or use the pre-specified Ubuntu 20.04 (`fd8ciuqfa001h8s9sa7i`) image.
      * `dp_ssh_key`: Absolute path to the public key for the {{ dataproc-name }} cluster. For more information, see [{#T}](../../data-proc/operations/connect.md#data-proc-ssh).
      * `bucket_name`: {{ objstorage-name }} bucket name. It must be unique throughout {{ yandex-cloud }}.

   1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration file and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of support for data exchange between {{ mch-name }} and {{ dataproc-name }} includes:
* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

{% endif %}

## Export data from {{ mch-name }} {#export-from-mch}

### Prepare the {{ mch-name }} cluster {#prepare-mch}

1. [Connect to the](../../managed-clickhouse/operations/connect.md) `db1` database of the {{ mch-name }} cluster on behalf of `user1`.
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
         ('Alvar', 28),
         ('Lilith', 50),
         ('Max', 27),
         ('Jaimey', 34),
         ('Dmitry', 42),
         ('Qiang', 19),
         ('Augustyna', 20),
         ('Maria', 28);
      ```

### Start an export from {{ mch-name }} {#start-mch-export}

1. Open the [Zeppelin web interface](../../data-proc/operations/connect-interfaces.md#ui-proxy-list) of the {{ dataproc-name }} cluster.
1. Click the **Create new note** link and specify your note parameters:
   * **Note name**: Enter any name for the note.
   * **Default Interpreter**: Select `spark`.
1. Click **Create**.
1. To generate a dataframe, create and run a paragraph with code. To do this, highlight the desired paragraph and click **Run this paragraph** (you can also use the **Shift**+**Enter** keyboard shortcut).

   ```python
   %spark.pyspark
   jdbcPort = 8443
   jdbcHostname = "c-<{{ mch-name }} cluster ID>.rw.{{ dns-zone }}"
   jdbcDatabase = "db1"
   jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
   df = spark.read.format("jdbc") \
   .option("url", jdbcUrl) \
   .option("user","user1") \
   .option("password","<{{ mch-name }} database password>") \
   .option("dbtable","persons") \
   .load()
   df.show()
   ```

   If the dataframe generates successfully, the response will contain a table with the original data.

1. To export information from a dataframe to a {{ objstorage-name }} bucket or a Hive table, create and run a paragraph with code.

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

## Upload the data to {{ mch-name }} {#import-to-mch}

### Prepare the source data {#prepare-source-data}

An HDFS directory or a {{ objstorage-name }} bucket can function as a data source. A CSV file containing people's names and ages will act as the data source:

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

   Create a file named `example.csv` with test data and [upload it to the {{ objstorage-name }} bucket](../../storage/operations/objects/upload.md).

- HDFS directory

   1. [Connect to a {{ dataproc-name }} cluster host](../../data-proc/operations/connect.md) in the data storage subcluster.
   1. Get the HDFS server address. You will need to specify this address when uploading data to the HDFS directory.

      ```bash
      hdfs getconf -confKey fs.defaultFS
      ```

   1. Create a file with test data named `example.csv`.
   1. Create an HDFS directory to write the test data to:

      ```bash
      hdfs dfs -mkdir /user/testdata
      ```

   1. Copy the test data file from the local file system to the HDFS directory:

      ```bash
      hdfs dfs -copyFromLocal example.csv /user/testdata/example.csv
      ```

{% endlist %}

### Start an export from {{ dataproc-name }} {#start-dp-export}

1. Open the [Zeppelin web interface](../../data-proc/operations/connect-interfaces.md#ui-proxy-list) of the {{ dataproc-name }} cluster.
1. Click the **Create new note** link and specify your note parameters:
   * **Note name**: Enter any name for the note.
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

1. To export information from a dataframe to a {{ mch-name }} database, create and run a paragraph with the code.

   ```python
   %spark.pyspark
   jdbcPort = 8443
   jdbcHostname = "c-<{{ mch-name }} cluster ID>.rw.{{ dns-zone }}"
   jdbcDatabase = "db1"
   jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
   df.write.format("jdbc") \
   .mode("error") \
   .option("url", jdbcUrl) \
   .option("dbtable", "example") \
   .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
   .option("user","user1") \
   .option("password","<{{ mch-name }} database password>") \
   .save()
   ```

### Verify the data import in {{ mch-name }} {#check-mch-export}

1. [Connect to the](../../managed-clickhouse/operations/connect.md) `db1` database of the {{ mch-name }} cluster on behalf of `user1`.
1. Run the query:

   ```sql
   SELECT * FROM example;
   ```

   If the import was successful, the response will contain a table with the data.

## Delete the resources you created {#clear-out}

{% list tabs %}

* Manually

   * [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
   * If you reserved a public static IP address for the VM, release and [delete it](../../vpc/operations/address-delete.md).
   * Delete the clusters:
      * [{{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md);
      * [{{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).
   * If you created an {{ objstorage-name }} bucket, [delete it](../../storage/operations/buckets/delete.md).

* Using Terraform

   If you created your resources using {{ TF }}:

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `data-proc-data-exchange-with-mch.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in the `data-proc-data-exchange-with-mch.tf` configuration file.

{% endlist %}
