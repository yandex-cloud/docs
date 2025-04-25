# Exchanging data between {{ mch-full-name }} and {{ dataproc-full-name }}


With {{ dataproc-name }}, you can:

* [Upload data from {{ mch-name }} to Spark DataFrame](#export-from-mch).
* [Export data from Spark DataFrame to {{ mch-name }}](#import-to-mch).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ dataproc-name }} cluster fee: Using VM computing resources and {{ compute-name }} network disks, and {{ cloud-logging-name }} for log management (see [{{ dataproc-name }} pricing](../../data-proc/pricing.md)).
* {{ mch-name }} cluster fee: Using computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* NAT gateway fee (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* {{ objstorage-name }} bucket fee: Storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a service account](../../iam/operations/sa/create.md) named `dataproc-sa` and assign the `dataproc.agent` and `dataproc.provisioner` roles to it.
    1. {% include [basic-before-buckets](../../_includes/data-processing/tutorials/basic-before-buckets.md) %}
    1. [Create a cloud network](../../vpc/operations/network-create.md) named `dataproc-network`.
    1. In `dataproc-network`, [create a subnet](../../vpc/operations/subnet-create.md) in any availability zone.
    1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet you created.
    1. If using security groups, [create a security group](../../vpc/operations/security-group-create.md) named `dataproc-sg` in `dataproc-network` and add the following rules to it:

        * One rule for inbound and another one for outbound service traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-security-group }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

        * Rule for outgoing HTTPS traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

        * Rule for outgoing TCP traffic on port {{ port-mch-http }} to access {{ CH }}:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mch-http }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

    1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) in any [suitable host configuration](../../data-proc/concepts/instance-types.md) with the following settings:

        * Components:
            * **SPARK**
            * **YARN**
            * **HDFS**
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `dataproc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Bucket you created for output data.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `dataproc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `dataproc-sg`.

    1. [Create a {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) cluster of any suitable configuration with the following settings:

        * With public access to cluster hosts.
        * Database: `db1`.
        * User: `user1`.

    
    1. If using security groups in your {{ mch-name }} cluster, make sure they are [configured correctly](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) and allow connecting to the cluster.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-proc-data-exchange-with-mch.tf](https://github.com/yandex-cloud-examples/yc-data-proc-clickhouse-data-exchange/blob/main/data-proc-data-exchange-with-mch.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * NAT gateway and route table required for {{ dataproc-name }}.
        * [Security groups](../../vpc/concepts/security-groups.md) required for the {{ dataproc-name }} and {{ mch-name }} clusters.
        * Service account required for the {{ dataproc-name }} cluster.
        * Service account required to create buckets in {{ objstorage-name }}.
        * Buckets for input and output data.
        * {{ dataproc-name }} cluster.
        * {{ mch-name }} cluster.

    1. Specify the following in the `data-proc-data-exchange-with-mch.tf` file:

        * `folder_id`: Cloud folder ID, same as in the provider settings.
        * `input_bucket`: Name of the input data bucket.
        * `output_bucket`: Name of the output data bucket.
        * `dp_ssh_key`: Absolute path to the public key for the {{ dataproc-name }} cluster. To learn more, see [{#T}](../../data-proc/operations/connect.md#data-proc-ssh).
        * `ch_password`: {{ CH }} user password.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Upload data from {{ mch-name }} {#export-from-mch}

### Create a table in the {{ mch-name }} cluster {#prepare-mch}

1. [Connect to the {{ mch-name }} cluster's database](../../managed-clickhouse/operations/connect/clients.md) named `db1` as `user1`.
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

        # Specifying the port and {{ CH }} cluster parameters
        jdbcPort = 8443
        jdbcHostname = "c-<{{ CH }}_cluster_ID>.rw.{{ dns-zone }}"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Transferring the persons table from {{ CH }} to DataFrame
        df = spark.read.format("jdbc") \
        .option("url", jdbcUrl) \
        .option("user","user1") \
        .option("password","<user1_password>") \
        .option("dbtable","persons") \
        .load()

        # Transferring DataFrame to the bucket for checking
        df.repartition(1).write.mode("overwrite") \
        .csv(path='s3a://<output_bucket_name>/csv', header=True, sep=',')
        ```

        {% endcut %}

    1. Specify the following in the script:

        * {{ mch-name }} cluster ID.
        * `user1` user password.
        * Output bucket name.

    1. In the input bucket, create a directory named `scripts` and [upload](../../storage/operations/objects/upload.md#simple) the `ch-to-dataproc.py` file to it.

1. [Create a PySpark job](../../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file in the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field: `s3a://<input_bucket_name>/scripts/ch-to-dataproc.py`.

1. Wait for the job to complete and make sure the output bucket's `csv` directory contains the source table.

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}

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

        # Creating DataFrame
        df = spark.createDataFrame([('Alim', 19),
                                    ('Fred' ,65),
                                    ('Guanmin' , 28),
                                    ('Till', 60),
                                    ('Almagul', 27),
                                    ('Mary', 34),
                                    ('Dmitry', 42)], schema)

        # Specifying the port and {{ CH }} cluster parameters
        jdbcPort = 8443
        jdbcHostname = "c-<{{ CH }}_cluster_ID>.rw.{{ dns-zone }}"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"

        # Transferring DataFrame to {{ CH }}
        df.write.format("jdbc") \
        .mode("error") \
        .option("url", jdbcUrl) \
        .option("dbtable", "people") \
        .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
        .option("user","user1") \
        .option("password","<{{ CH }}_database_password>") \
        .save()
        ```

        {% endcut %}

    1. Specify the following in the script:

        * {{ mch-name }} cluster ID.
        * `user1` user password.

    1. In the input bucket, create a directory named `scripts` and [upload](../../storage/operations/objects/upload.md#simple) the `dataproc-to-ch.py` file to it.

1. [Create a PySpark job](../../data-proc/operations/jobs-pyspark.md#create) by specifying the path to the script file in the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field: `s3a://<input_bucket_name>/scripts/dataproc-to-ch.py`.

1. Wait for the job to complete and make sure the data has been transferred to {{ mch-name }}:

    1. [Connect to the {{ mch-name }} cluster's database](../../managed-clickhouse/operations/connect/clients.md) named `db1` as `user1`.
    1. Run this request:

        ```sql
        SELECT * FROM people;
        ```

    If the import is successful, the response will contain a table with the data.

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the objects](../../storage/operations/objects/delete.md) from the buckets. Delete the other resources depending on how they were created:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [{{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md)
        1. [{{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md)
        1. [{{ objstorage-name }} buckets](../../storage/operations/buckets/delete.md)
        1. [Subnet](../../vpc/operations/subnet-delete.md)
        1. [Route table](../../vpc/operations/delete-route-table.md)
        1. [NAT gateway](../../vpc/operations/delete-nat-gateway.md)
        1. [Cloud network](../../vpc/operations/network-delete.md)
        1. [Service account](../../iam/operations/sa/delete.md)

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
