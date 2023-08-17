#|
||This tutorial is based on a [Data Stories](https://data-stories.ru/) use case on creating an analytical stack powered by {{ yandex-cloud }} services. It includes uploading data to storage, processing it, and transforming it into a single data mart for visualization.
|
<br>![datastories logo](../_assets/logos/datastories_logo.png =300x)||
|#

As an example, we use two CSV tables to be joined, imported to Parquet format, and transferred to {{ mch-name }} as a single table.

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

* Manually

   1. [Create a service account](../iam/operations/sa/create.md) named `dataproc-s3-sa` and assign it the `dataproc.agent` role.
   1. {% include [basic-before-buckets](../_includes/data-proc/tutorials/basic-before-buckets.md) %}
   1. [Create a cloud network](../vpc/operations/network-create.md) named `dataproc-network`.
   1. [Create a subnet](../vpc/operations/subnet-create.md) in any availability zone in the `dataproc-network`.
   1. [Set up a NAT gateway](../vpc/operations/create-nat-gateway.md) for the subnet you created.
   1. In `dataproc-network`, [create a security group](../vpc/operations/security-group-create.md) named `dataproc-sg` and add the following rules to it:

      * One rule for inbound and another one for outbound service traffic:

         * Port range: `{{ port-any }}`.
         * Protocol: `Any`.
         * Source: `Security group`.
         * Security group: `Self`.

      * Rule for outgoing HTTPS traffic:

         * Port range: `{{ port-https }}`.
         * Protocol: `TCP`.
         * Destination type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

      * Rule for outgoing TCP traffic on port {{ port-mch-http }} to access {{ CH }}:

         * Port range: `{{ port-mch-http }}`.
         * Protocol: `TCP`.
         * Destination type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

   1. [Create a {{ dataproc-name }} cluster](../data-proc/operations/cluster-create.md) in any [suitable host configuration](../data-proc/concepts/instance-types.md) with the following settings:

      * Components:
         * `SPARK`
         * `YARN`
         * `HDFS`
      * Service account: `dataproc-sa`.
      * Bucket name: Bucket you created for output data.
      * Network: `dataproc-network`.
      * Security group: `dataproc-sg`.
      * **UI Proxy** setting: Enabled.

   1. [Create a {{ mch-name }} cluster](../managed-clickhouse/operations/cluster-create.md) in any suitable [configuration](../managed-clickhouse/concepts/instance-types.md) with the following settings:

      * With public access to cluster hosts.
      * With a database called `db1`.
      * With the `user1` user.

* Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [s3-dataproc-ch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/s3-dataproc-ch.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../vpc/concepts/network.md#network).
      * [Subnet](../vpc/concepts/network.md#subnet).
      * NAT gateway and route table required for {{ dataproc-name }}.
      * [Security groups](../vpc/concepts/security-groups.md) required for the {{ dataproc-name }} and {{ mch-name }} clusters.
      * Service account required for the {{ dataproc-name }} cluster to run.
      * Service account required to create buckets in {{ objstorage-name }}.
      * Buckets for input and output data.
      * {{ dataproc-name }} cluster.
      * {{ mch-name }} cluster.

   1. Specify the following in the `s3-dataproc-ch.tf` file:

      * `folder_id`: Cloud folder ID, the same as specified in the provider settings.
      * `input-bucket`: Name of the bucket for input data.
      * `output-bucket`: Name of the bucket for output data.
      * `dp_ssh_key`: Absolute path to the public key for the {{ dataproc-name }} cluster. For more information, see [{#T}](../data-proc/operations/connect.md#data-proc-ssh).
      * `ch_password`: {{ CH }} user password.

   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider's resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the test data {#prepare-data}

In this example, we use the following two CSV tables:

* `coords.csv` with vehicle geographic coordinates.
* `sensors.csv` with information about the speed and other vehicle operating parameters.

To prepare the test data:

1. Copy the contents of the sample files below and save them locally in CSV format:

   * {% cut "coords.csv" %}
      ```csv
      vehicle_id,latitude,longitude,altitude
      iv9a94th6rztooxh5ur2,55.70329032,37.65472196,427.5
      022wsiz48h2ljxuz04x8,56.96149325,38.46541766,423.6
      a7fbbqjws4zqw85f6jue,54.99296663,36.79063999,426.2
      l7731117m6r6on4m633n,55.34740545,37.13175678,422.5
      6f9q6ienc4qfpdwd9nef,56.69752218,38.38871530,428.3
      ```
      {% endcut %}
   * {% cut "sensors.csv" %}
      ```csv
      vehicle_id,speed,battery_voltage,cabin_temperature,fuel_level
      iv9a94th6rztooxh5ur2,0.0,25.5,17,5
      022wsiz48h2ljxuz04x8,55.5,54.5,21,22
      a7fbbqjws4zqw85f6jue,80.6,22.1,19,73
      l7731117m6r6on4m633n,40.9,76.0,25,23
      6f9q6ienc4qfpdwd9nef,64.8,90.8,21,32
      ```
      {% endcut %}

1. Create a `csv` folder in the input bucket and [upload](../storage/operations/objects/upload.md#simple) the created CSV files to it.

## Process your data in {{ dataproc-name }} {#process-data}

Join the data from the two tables into one and upload it in Parquet format to the bucket you previously created for processing results:

1. Prepare a script file:

   1. Create a local file named `join-tables.py` and copy the following script to it:

      {% cut "join-tables.py" %}
      ```python
      from pyspark.sql import SparkSession

      # Creating a Spark session
      spark = SparkSession.builder.appName("JoinExample").getOrCreate()

      # Reading the table from the coords.csv file
      coords_df = spark.read.csv("s3a://<input bucket name>/csv/coords.csv", header=True)

      # Reading the table from the sensors.csv file
      sensors_df = spark.read.csv("s3a://<input bucket name>/csv/sensors.csv", header=True)

      # Joining the tables by the vehicle_id column
      joined_df = coords_df.join(sensors_df, on="vehicle_id", how="inner")

      # Saving the joined table to the bucket in Parquet format
      joined_df.write.parquet("s3a://<output bucket name>/parquet/")
      ```
      {% endcut %}

   1. Specify the following in the script:

      * Name of the input bucket that stores the original CSV tables.
      * Name of the output bucket where the Parquet file with the joined data will be saved.

   1. Create a `scripts` folder in the input bucket and [upload](../storage/operations/objects/upload.md#simple) the `join-tables.py` file to it.

1. [Create a PySpark job](../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file (`s3a://<input bucket name>/scripts/join-tables.py`) in the **Main python file** field.

1. Wait for the job to complete and make sure the output bucket's `parquet` folder contains the `part-00000-...` Parquet file.

## Export your data to {{ CH }} {#export-data}

Transfer the joined table from {{ objstorage-name }} to {{ CH }}:

1. Prepare a script file:

   1. Create a local file named `parquet-to-ch.py` and copy the following script to it:

      {% cut "parquet-to-ch.py" %}
      ```python
      from pyspark.sql import SparkSession

      # Creating a Spark session
      spark = SparkSession.builder.appName("ParquetClickhouse").getOrCreate()

      # Reading the data from the Parquet file
      parquetFile = spark.read.parquet("s3a://<output bucket name>/parquet/*.parquet")

      # Specifying the port and ClickHouse cluster parameters
      jdbcPort = 8443
      jdbcHostname = "c-<cluster ID>.rw.mdb.yandexcloud.net"
      jdbcDatabase = "db1"
      jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

      # Transferring the table from the Parquet file to a ClickHouse table named "measurements"
      parquetFile.write.format("jdbc") \
      .mode("error") \
      .option("url", jdbcUrl) \
      .option("dbtable", "measurements") \
      .option("createTableOptions", "ENGINE = MergeTree() ORDER BY vehicle_id") \
      .option("user","user1") \
      .option("password","<ClickHouse user password>") \
      .save()
      ```
      {% endcut %}

   1. Specify the following in the script:

      * Name of the bucket with the Parquet file.
      * {{ mch-name }} cluster ID.
      * {{ CH }} user password.

   1. [Upload](../storage/operations/objects/upload.md#simple) the `parquet-to-ch.py` file to the input bucket's `scripts` folder.

1. [Create a PySpark job](../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file (`s3a://<input bucket name>/scripts/parquet-to-ch.py`) in the **Main python file** field.
1. Wait for the job to complete and make sure the joined table has been moved to the cluster:

   1. [Connect to the](../managed-clickhouse/operations/connect.md) `db1` database of the {{ mch-name }} cluster as `user1`.
   1. Run the following query:

      ```sql
      SELECT * FROM measurements;
      ```

   If the data export is successful, the response will contain the joined table.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

* Manually

   1. [{{ mch-name }} cluster](../managed-clickhouse/operations/cluster-delete.md).
   1. [{{ dataproc-name }} cluster](../data-proc/operations/cluster-delete.md).
   1. [{{ objstorage-name }} buckets](../storage/operations/buckets/delete.md).
   1. [Cloud network](../vpc/operations/network-delete.md).
   1. [Service account](../iam/operations/sa/delete.md).

* Using {{ TF }}

   1. [Delete the objects](../storage/operations/objects/delete.md) from the buckets.
   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `s3-dataproc-ch.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `s3-dataproc-ch.tf` configuration file will be deleted.

{% endlist %}
