You can save data from a {{ dataproc-name }} cluster to a {{ objstorage-name }} bucket using a separate [{{ metastore-name }}](../data-proc/operations/metastore/index.md) server to store table metadata. This will allow a different {{ dataproc-name }} cluster that has access to the bucket and is connected to the same {{ metastore-name }} server to work with the saved data.

To set up shared use of tables with two {{ dataproc-name }} clusters through [{{ metastore-name }}](../data-proc/operations/metastore/index.md):

1. [Connect {{ dataproc-name }} to {{ metastore-name }}](#connect).
1. [Create a test table](#create-table).
1. [Get data in the second cluster](#test-target).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

* Manually

   1. [Create a service account](../iam/operations/sa/create.md) named `dataproc-s3-sa` and assign it the `dataproc.agent` role.
   1. {% include [basic-before-buckets](../_includes/data-proc/tutorials/basic-before-buckets.md) %}
   1. [Create a cloud network](../vpc/operations/network-create.md) named `dataproc-network`.
   1. [Create a subnet](../vpc/operations/subnet-create.md) in any availability zone in the `dataproc-network`.
   1. [Set up a NAT gateway](../vpc/operations/create-nat-gateway.md) for the subnet you created.
   1. [Create two {{ dataproc-name }} clusters](../data-proc/operations/cluster-create.md) named `dataproc-source` and `dataproc-target`, in any [suitable host configuration](../data-proc/concepts/instance-types.md) with the following settings:

      * Components:
         * `SPARK`
         * `YARN`
         * `HIVE`
      * Service account: `dataproc-sa`.
      * Bucket name: Bucket you created for output data.
      * Network: `dataproc-network`.

   1. If the cloud network uses [security groups](../vpc/concepts/security-groups.md), [add](../vpc/operations/security-group-add-rule.md) the following rule for outgoing traffic to the {{ dataproc-name }} cluster's security group:

      * Port range: `{{ port-metastore }}`.
      * Protocol: ``Any``.
      * Source: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

* Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [dataproc-to-dataproc.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/dataproc-to-dataproc.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../vpc/concepts/network.md#network)
      * [Subnet](../vpc/concepts/network.md#subnet)
      * [NAT gateway](../vpc/concepts/gateways.md) and route table required for {{ dataproc-name }}.
      * [Security groups](../vpc/concepts/security-groups.md) required for the {{ dataproc-name }} clusters.
      * Service account required for the {{ dataproc-name }} cluster to run.
      * Service account required to create buckets in {{ objstorage-name }}.
      * Buckets for input and output data.
      * Two {{ dataproc-name }} clusters.

   1. In the `dataproc-to-dataproc.tf` file, specify:

      * `folder_id`: Cloud folder ID, the same one specified in the provider settings.
      * `input-bucket`: Name of the bucket for input data.
      * `output-bucket`: Name of the bucket for output data.
      * `dp_ssh_key`: Absolute path to the public key for the {{ dataproc-name }} clusters. For more information, see [{#T}](../data-proc/operations/connect.md#data-proc-ssh).

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

## Connect {{ dataproc-name }} to {{ metastore-name }} {#connect}

1. [Create a {{ metastore-name }} server](../data-proc/operations/metastore/cluster-create.md) in `dataproc-network`.

1. [Change settings](../data-proc/operations/cluster-update.md) for the {{ dataproc-name }} clusters by adding the following [property](../data-proc/concepts/settings-list.md) to them:

   ```text
   spark:spark.hive.metastore.uris=thrift://<{{ metastore-name }} IP address>:{{ port-metastore }}
   ```

   To find out the {{ metastore-name }} IP address, go to the {{ metastore-name }} page in the [management console]({{ link-console-main }}). You will see the IP address in the **{{ ui-key.yacloud.common.section-base }}** section.

## Create a test table {#create-table}

In the `dataproc-source` cluster, create a test table named `countries` and upload it to {{ objstorage-name }}:

{% list tabs %}

- Spark

   1. Prepare a script file:

      1. Create a local file named `create-table.py` and copy the following script to it:

         {% cut "create-table.py" %}

         ```python
         from pyspark.sql.types import *
         from pyspark.sql import SparkSession

         # Creating a Spark session
         spark = SparkSession.builder \
             .appName("create-table") \
             .enableHiveSupport() \
             .getOrCreate()

         # Creating a data schema
         schema = StructType([StructField('Name', StringType(), True),
         StructField('Capital', StringType(), True),
         StructField('Area', IntegerType(), True),
         StructField('Population', IntegerType(), True)])

         # Creating a dataframe
         df = spark.createDataFrame([('Australia', 'Canberra', 7686850, 19731984), ('Austria', 'Vienna', 83855, 7700000)], schema)

         # Writing the dataframe to a bucket as the countries table
         df.write.mode("overwrite").option("path","s3a://<output bucket name>/countries").saveAsTable("countries")
         ```

         {% endcut %}

      1. In the script, specify the name of the output bucket where the file with the `countries` table will be saved.

      1. Create a `scripts` folder in the input bucket and [upload](../storage/operations/objects/upload.md#simple) the `create-table.py` file to it.

   1. [Create a PySpark job](../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file (`s3a://<input bucket name>/scripts/create-table.py`) in the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field.

   1. Wait for the job to complete and make sure the output bucket's `countries` folder contains the `part-00000-...` file.

{% endlist %}

The data from the created table is now stored in the {{ objstorage-name }} bucket and the table metadata, on the {{ metastore-name }} server. You can [delete](../data-proc/operations/cluster-delete.md) the `dataproc-source` cluster.

## Get data in the second cluster {#test-target}

Upload the `countries` table metadata to the `dataproc-target` cluster and make sure the table is accessible in the cluster for further operations:

{% list tabs %}

- Spark

   1. Prepare a script file:

      1. Create a local file named `obtain-table.py` and copy the following script to it:

         {% cut "obtain-table.py" %}

         ```python
         from pyspark.sql import SparkSession

         # Creating a Spark session
         spark = SparkSession.builder \
             .appName("obtain-table") \
             .enableHiveSupport() \
             .getOrCreate()

         spark.catalog.listDatabases()

         # Retrieving information about the countries table from Metastore
         df = spark.sql("describe extended countries")

         # Querying data from the countries table
         df = spark.sql("select * from countries")

         # Moving the table to the bucket for verification
         df.repartition(1).write.csv(path='s3a://<output bucket name>/csv', header=True, sep=',')
         ```

         {% endcut %}

      1. In the script, specify the name of the output bucket where the CSV file with the `countries` table will be saved.
      1. [Upload](../storage/operations/objects/upload.md#simple) the `obtain-table.py` file to the input bucket's `scripts` folder.

   1. [Create a PySpark job](../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file (`s3a://<input bucket name>/scripts/obtain-table.py`) in the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field.
   1. Wait for the job to complete and make sure the output bucket contains the `csv` folder with a table in CSV format.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ metastore-name }} server](../data-proc/operations/metastore/cluster-delete.md).
1. Delete other resources depending on how they were created:

{% list tabs %}

* Manually

   1. [{{ dataproc-name }} clusters](../data-proc/operations/cluster-delete.md).
   1. [{{ objstorage-name }} buckets](../storage/operations/buckets/delete.md).
   1. [Cloud network](../vpc/operations/network-delete.md).
   1. [Service account](../iam/operations/sa/delete.md).

* Using {{ TF }}

   1. [Delete the objects](../storage/operations/objects/delete.md) from the buckets.
   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `dataproc-to-dataproc.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `dataproc-to-dataproc.tf` configuration file will be deleted.

{% endlist %}
