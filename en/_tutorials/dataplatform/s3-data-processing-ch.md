#|
||This tutorial is based on a [Data Stories](https://data-stories.ru/) use case of building an analytical stack powered by {{ yandex-cloud }} services. It included uploading data to a storage, processing it, and transforming it into a single data mart for visualization.
|
<br>![datastories logo](../../_assets/logos/datastories_logo.png =300x)||
|#

In this example, we use two CSV tables which we will merge into a single one, import it to Parquet format, and transfer to {{ mch-name }}.


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mch-name }} cluster fee: Covers the use of computational resources allocated to hosts (including {{ ZK }} hosts) and disk storage (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* {{ dataproc-name }} cluster fee: Covers the use of VM computing resources, {{ compute-name }} network disks, and {{ cloud-logging-name }} for log management (see [{{ dataproc-name }} pricing](../../data-proc/pricing.md)).
* Fee for public IP address assignment on cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* {{ objstorage-name }} bucket fee: storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for a NAT gateway (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a service account](../../iam/operations/sa/create.md) named `dataproc-s3-sa` and assign the `dataproc.agent` and `dataproc.provisioner` roles to it.
    1. {% include [basic-before-buckets](../../_includes/data-processing/tutorials/basic-before-buckets.md) %}
    1. [Create a cloud network](../../vpc/operations/network-create.md) named `dataproc-network`.
    1. Within the `dataproc-network`, [create a subnet](../../vpc/operations/subnet-create.md) in any availability zone.
    1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) for your new subnet.
    1. In `dataproc-network`, [create a security group](../../vpc/operations/security-group-create.md) named `dataproc-sg` and add the following rules to it:

        * One inbound and one outbound rule for service traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

        * Rule for outgoing HTTPS traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

        * Egress rule to allow TCP access to {{ CH }} on port {{ port-mch-http }}:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mch-http }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}.`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) with the [host configuration of your choice](../../data-proc/concepts/instance-types.md) and the following settings:

        * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}**: `PRODUCTION`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
            * `SPARK`
            * `YARN`
            * `HDFS`
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `dataproc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Bucket you created for the output data.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `dataproc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `dataproc-sg`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}**: Enabled.

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) of any suitable [configuration](../../managed-clickhouse/concepts/instance-types.md) and the following settings:

        * Public access to cluster hosts: Enabled.
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `user1`.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [s3-dataproc-ch.tf](https://github.com/yandex-cloud-examples/yc-data-proc-clickhouse-data-export/blob/main/s3-dataproc-ch.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * NAT gateway and route table for {{ dataproc-name }}.
        * [Security groups](../../vpc/concepts/security-groups.md) for the {{ dataproc-name }} and {{ mch-name }} clusters.
        * Service account for the {{ dataproc-name }} cluster.
        * Service account required to create buckets in {{ objstorage-name }}.
        * Buckets for input and output data.
        * {{ dataproc-name }} cluster.
        * {{ mch-name }} cluster.

    1. In the `s3-dataproc-ch.tf` file, specify the following:

        * `folder_id`: Cloud folder ID matching the one in your provider settings.
        * `input-bucket`: Name of the input data bucket.
        * `output-bucket`: Output data bucket name.
        * `dp_ssh_key`: Absolute path to the public key for the {{ dataproc-name }} cluster. Learn more about connecting to a {{ dataproc-name }} host over SSH [here](../../data-proc/operations/connect-ssh.md).
        * `ch_password`: {{ CH }} user password.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare your test data {#prepare-data}

In this example, we use the following two CSV tables:

* `coords.csv` with vehicle geographic coordinates.
* `sensors.csv` with information about speed and other vehicle operating parameters.

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

1. Create a folder named `csv` in the input bucket and [upload](../../storage/operations/objects/upload.md#simple) the new CSV files to it.

## Process your data in {{ dataproc-name }} {#process-data}

Merge the data from the two tables into one and upload it in Parquet format to the bucket you previously created for processing results:

1. Prepare a script file:

    1. Create a local file named `join-tables.py` and paste the following script to it:

        {% cut "join-tables.py" %}
        ```python
        from pyspark.sql import SparkSession

        # Creating a Spark session
        spark = SparkSession.builder.appName("JoinExample").getOrCreate()

        # Reading a table from coords.csv
        coords_df = spark.read.csv("s3a://<input_bucket_name>/csv/coords.csv", header=True)

        # Reading a table from sensors.csv
        sensors_df = spark.read.csv("s3a://<input_bucket_name>/csv/sensors.csv", header=True)

        # Joining tables by the vehicle_id column
        joined_df = coords_df.join(sensors_df, on="vehicle_id", how="inner")

        # Saving the joined table to a bucket in Parquet format
        joined_df.write.parquet("s3a://<output_bucket_name>/parquet/")
        ```
        {% endcut %}

    1. In your script, specify the following:

        * Name of the input bucket that stores the original CSV tables.
        * Name of the output bucket where the Parquet file with the merged data will be saved.

    1. In the input bucket, create a folder named `scripts` and [upload](../../storage/operations/objects/upload.md#simple) the `join-tables.py` file to it.

1. [Create a PySpark job](../../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file in the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field: `s3a://<input_bucket_name>/scripts/join-tables.py`.

1. Wait for the job to complete and check that the output bucket's `parquet` folder contains the `part-00000-***` Parquet file.

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}

## Export your data to {{ CH }} {#export-data}

Transfer the joined table from {{ objstorage-name }} to {{ CH }}:

1. Prepare a script file:

    1. Create a local file named `parquet-to-ch.py` and paste the following script to it:

        {% cut "parquet-to-ch.py" %}
        ```python
        from pyspark.sql import SparkSession

        # Creating a Spark session
        spark = SparkSession.builder.appName("ParquetClickhouse").getOrCreate()

        # Reading data from a Parquet file
        parquetFile = spark.read.parquet("s3a://<output_bucket_name>/parquet/*.parquet")

        # Specifying the port and {{ CH }} cluster parameters
        jdbcPort = 8443
        jdbcHostname = "c-<cluster_ID>.rw.{{ dns-zone }}"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Transferring a table from a Parquet file to a {{ CH }} table named `measurements`
        parquetFile.write.format("jdbc") \
        .mode("error") \
        .option("url", jdbcUrl) \
        .option("dbtable", "measurements") \
        .option("createTableOptions", "ENGINE = MergeTree() ORDER BY vehicle_id") \
        .option("user","user1") \
        .option("password","<{{ CH }}_user_password>") \
        .save()
        ```
        {% endcut %}

    1. In your script, specify the following:

        * Name of the bucket with the Parquet file.
        * {{ mch-name }} cluster ID.
        * {{ CH }} user password.

    1. [Upload](../../storage/operations/objects/upload.md#simple) the `parquet-to-ch.py` file to the input data bucket’s `scripts` folder.

1. [Create a PySpark job](../../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file in the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field: `s3a://<input_bucket_name>/scripts/parquet-to-ch.py`.
1. Wait for the job to complete and make sure the joined table has been moved to the cluster:

    1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `db1` database in the {{ mch-name }} cluster as `user1`.
    1. Run this query:

        ```sql
        SELECT * FROM measurements;
        ```

    If the data export is successful, the response will contain the joined table.

## Delete the resources you created {#clear-out}

Some resources incur charges. To avoid unnecessary expenses, delete the resources you no longer need:

1. [Delete all objects](../../storage/operations/objects/delete.md) from the buckets.
1. Delete other resources using the method matching their creation method:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [{{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
        1. [{{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md).
        1. [{{ objstorage-name }} buckets](../../storage/operations/buckets/delete.md).
        1. [Subnet](../../vpc/operations/subnet-delete.md).
        1. [Route table](../../vpc/operations/delete-route-table.md).
        1. [NAT gateway](../../vpc/operations/delete-nat-gateway.md).
        1. [Cloud network](../../vpc/operations/network-delete.md).
        1. [Service account](../../iam/operations/sa/delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
