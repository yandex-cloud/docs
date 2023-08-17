# Exchanging data between {{ mch-full-name }} and {{ dataproc-full-name }}

You can use {{ dataproc-name }} to:

* [Upload data from {{ mch-name }} to Spark DataFrame](#export-from-mch).
* [Export data from Spark DataFrame to {{ mch-name }}](#import-to-mch).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

- Manually

   1. [Create a service account](../../iam/operations/sa/create.md) named `dataproc-sa` and assign it the `dataproc.agent` role.
   1. {% include [basic-before-buckets](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}
   1. [Create a cloud network](../../vpc/operations/network-create.md) named `dataproc-network`.
   1. [Create a subnet](../../vpc/operations/subnet-create.md) in any availability zone in the `dataproc-network`.
   1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet you created.
   1. If you are using security groups, [create a security group](../../vpc/operations/security-group-create.md) named `dataproc-sg` in `dataproc-network` and add the following rules to it:

      * One rule for inbound and another one for outbound service traffic:

         * Port range: `{{ port-any }}`.
         * Protocol: ``Any``.
         * Source: `Security group`.
         * Security group: `Self` (`Self`).

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

      {% include [preview-pp.md](../../_includes/preview-pp.md) %}

   1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) in any [suitable host configuration](../../data-proc/concepts/instance-types.md) with the following settings:

      * Components:
         * **SPARK**
         * **YARN**
         * **HDFS**
      * Service account: `dataproc-sa`.
      * Bucket name: Bucket you created for output data.
      * Network: `dataproc-network`.
      * Security group: `dataproc-sg`.

   1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) in any suitable [configuration](../../managed-clickhouse/concepts/instance-types.md) with the following settings:

      * With public access to cluster hosts.
      * With a database called `db1`.
      * With the `user1` user.

   
   1. If you are using security groups in your {{ mch-name }} cluster, make sure they have been [set up correctly](../../managed-clickhouse/operations/connect.md#configuring-security-groups) and allow connecting to the cluster:

      {% include [preview-pp.md](../../_includes/preview-pp.md) %}


- Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [data-proc-data-exchange-with-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-proc-data-exchange-with-mch.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network)
      * [Subnet](../../vpc/concepts/network.md#subnet)
      * NAT gateway and route table required for {{ dataproc-name }}.
      * [Security groups](../../vpc/concepts/security-groups.md) required for the {{ dataproc-name }} and {{ mch-name }} clusters.
      * Service account required for the {{ dataproc-name }} cluster to run.
      * Service account required to create buckets in {{ objstorage-name }}.
      * Buckets for input and output data.
      * {{ dataproc-name }} cluster.
      * {{ mch-name }} cluster.

   1. In the `data-proc-data-exchange-with-mch.tf` file, specify:

      * `folder_id`: Cloud folder ID, the same as specified in the provider settings.
      * `input_bucket`: Name of the bucket for input data.
      * `output_bucket`: Name of the bucket for output data.
      * `dp_ssh_key`: Absolute path to the public key for the {{ dataproc-name }} cluster. For more information, see [{#T}](../../data-proc/operations/connect.md#data-proc-ssh).
      * `ch_password`: {{ CH }} user password.

   1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration file and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Upload data from {{ mch-name }} {#export-from-mch}

### Create a table in the {{ mch-name }} cluster {#prepare-mch}

1. [Connect to the](../../managed-clickhouse/operations/connect.md) `db1` database of the {{ mch-name }} cluster as `user1`.
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

    1. Check the result:

      ```sql
      SELECT * FROM persons;
      ```

### Transfer the table from {{ mch-name }} {#start-mch-export}

1. Prepare a script file:

   1. Create a local file named `ch-to-dataproc.py` and copy the following script to it:

      {% cut "ch-to-dataproc.py" %}

      ```python
      from pyspark.sql import SparkSession

      # Creating a Spark session
      spark = SparkSession.builder.appName("ClickhouseDataproc").getOrCreate()

      # Setting the port and ClickHouse cluster parameters
      jdbcPort = 8443
      jdbcHostname = "c-<{{ mch-name }} cluster ID>.rw.mdb.yandexcloud.net"
      jdbcDatabase = "db1"
      jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

      # Transferring the persons table from ClickHouse to DataFrame
      df = spark.read.format("jdbc") \
      .option("url", jdbcUrl) \
      .option("user","user1") \
      .option("password","<password of user1>") \
      .option("dbtable","persons") \
      .load()

      # Transferring the DataFrame to the bucket for checking
      df.repartition(1).write.mode("overwrite") \
      .csv(path='s3a://<output bucket name>/csv', header=True, sep=',')
      ```

        {% endcut %}

   1. Specify the following in the script:

      * {{ mch-name }} cluster ID.
      * Password of `user1`.
      * Output bucket name.

   1. Create a `scripts` folder in the input bucket and [upload](../../storage/operations/objects/upload.md#simple) the `ch-to-dataproc.py` file to it.

1. [Create a PySpark job](../../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file (`s3a://<input bucket name>/scripts/ch-to-dataproc.py`) in the **Main python file** field.

1. Wait for the job to complete and make sure the output bucket's `csv` folder contains the source table.

## Export data to {{ mch-name }} {#import-to-mch}

1. Prepare a script file:

   1. Create a local file named `dataproc-to-ch.py` and copy the following script to it:

      {% cut "dataproc-to-ch.py" %}

      ```python
      from pyspark.sql import SparkSession
      from pyspark.sql.types import *

      # Creating a Spark session
      spark = SparkSession.builder.appName("DataprocClickhouse").getOrCreate()

      # Creating a data schema
      schema = StructType([StructField('name', StringType(), True),
      StructField('age', IntegerType(), True)])

      # Creating a DataFrame
      df = spark.createDataFrame([('Alim', 19),
                                  ('Fred' ,65),
                                  ('Guanmin' , 28),
                                  ('Till', 60),
                                  ('Almagul', 27),
                                  ('Mary', 34),
                                  ('Dmitry', 42)], schema)

      # Specifying the port and ClickHouse cluster parameters
      jdbcPort = 8443
      jdbcHostname = "c-<{{ mch-name }} cluster ID>.rw.mdb.yandexcloud.net"
      jdbcDatabase = "db1"
      jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

      # Transferring the DataFrame to ClickHouse
      df.write.format("jdbc") \
      .mode("error") \
      .option("url", jdbcUrl) \
      .option("dbtable", "people") \
      .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
      .option("user","user1") \
      .option("password","<{{ mch-name }} database password>") \
      .save()
      ```

      {% endcut %}

   1. Specify the following in the script:

      * {{ mch-name }} cluster ID.
      * Password of `user1`.

    1. Create a `scripts` folder in the input bucket and [upload](../../storage/operations/objects/upload.md#simple) the `dataproc-to-ch.py` file to it.

1. [Create a PySpark job](../../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file (`s3a://<input bucket name>/scripts/dataproc-to-ch.py`) in the **Main python file** field.

1. Wait for the job to complete and make sure the data has been transferred to {{ mch-name }}:

    1. [Connect to the](../../managed-clickhouse/operations/connect.md) `db1` database of the {{ mch-name }} cluster as `user1`.
    1. Run the following query:

        ```sql
        SELECT * FROM people;
        ```

   If the import was successful, the response will contain a table with the data.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

* Manually

   1. [{{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
   1. [{{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md).
   1. [{{ objstorage-name }} buckets](../../storage/operations/buckets/delete.md).
   1. [Cloud network](../../vpc/operations/network-delete.md).
   1. [Service account](../../iam/operations/sa/delete.md).

* Using {{ TF }}

   1. [Delete the objects](../../storage/operations/objects/delete.md) from the buckets.
   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `data-proc-data-exchange-with-mch.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in the `data-proc-data-exchange-with-mch.tf` configuration file.

{% endlist %}
