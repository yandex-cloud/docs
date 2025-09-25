# Exchanging data between {{ mch-full-name }} and {{ dataproc-full-name }}


With {{ dataproc-name }}, you can:

* [Upload data from {{ mch-name }} to Spark DataFrame](#export-from-mch).
* [Export data from Spark DataFrame to {{ mch-name }}](#import-to-mch).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ dataproc-name }} cluster fee: Covers the use of VM computing resources, {{ compute-name }} network disks, and {{ cloud-logging-name }} for log management (see [{{ dataproc-name }} pricing](../../data-proc/pricing.md)).
* {{ mch-name }} cluster fee: Covers the use of computational resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for a NAT gateway (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Fee for an {{ objstorage-name }} bucket: Covers data storage and bucket operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for public IP addresses assigned to cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a service account](../../iam/operations/sa/create.md) named `dataproc-sa` and assign the `dataproc.agent` and `dataproc.provisioner` roles to it.
    1. {% include [basic-before-buckets](../../_includes/data-processing/tutorials/basic-before-buckets.md) %}
    1. [Create a cloud network](../../vpc/operations/network-create.md) named `dataproc-network`.
    1. Within the `dataproc-network`, [create a subnet](../../vpc/operations/subnet-create.md) in any availability zone.
    1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) for your new subnet.
    1. If you are using security groups, [create one](../../vpc/operations/security-group-create.md) named `dataproc-sg` in the `dataproc-network` and add the following rules:

        * One inbound and one outbound rule for service traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-security-group }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`)

        * Rule for outgoing HTTPS traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

        * Egress rule to allow TCP access to {{ CH }} on port {{ port-mch-http }}:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mch-http }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

    1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) with the [host configuration of your choice](../../data-proc/concepts/instance-types.md) and the following settings:

        * Components:
            * **SPARK**
            * **YARN**
            * **HDFS**
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `dataproc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Bucket you created for the output data.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `dataproc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `dataproc-sg`.

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with your preferred [configuration](../../managed-clickhouse/concepts/instance-types.md) and the following settings:

        * Public access to cluster hosts: Enabled.
        * Database: `db1`.
        * User: `user1`.

    
    1. If using security groups, make sure they are [configured correctly](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) and allow inbound connections to your {{ mch-name }} cluster.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-proc-data-exchange-with-mch.tf](https://github.com/yandex-cloud-examples/yc-data-proc-clickhouse-data-exchange/blob/main/data-proc-data-exchange-with-mch.tf) configuration file to your current working directory.

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

    1. In the `data-proc-data-exchange-with-mch.tf` file, specify the following:

        * `folder_id`: Cloud folder ID matching the one in your provider settings.
        * `input_bucket`: Input data bucket name.
        * `output_bucket`: Output data bucket name.
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

## Export data from {{ mch-name }} {#export-from-mch}

### Create a table in the {{ mch-name }} cluster {#prepare-mch}

1. [Connect to the `db1` database](../../managed-clickhouse/operations/connect/clients.md) in the {{ mch-name }} cluster as `user1`.
1. Add test data to the database. In this example, we will use a simple table containing people's names and ages.

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

### Export the table from {{ mch-name }} {#start-mch-export}

1. Prepare a script file:

    1. Create a local file named `ch-to-dataproc.py` and copy the following script into it:

        {% cut "ch-to-dataproc.py" %}

        ```python
        from pyspark.sql import SparkSession

        # Creating a Spark session
        spark = SparkSession.builder.appName("ClickhouseDataproc").getOrCreate()

        # Specifying the port and other {{ CH }} cluster settings
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

        # Transferring DataFrame to the bucket for validation
        df.repartition(1).write.mode("overwrite") \
        .csv(path='s3a://<output_bucket_name>/csv', header=True, sep=',')
        ```

        {% endcut %}

    1. In your script, specify the following:

        * {{ mch-name }} cluster ID.
        * `user1` password.
        * Output bucket name.

    1. In the input bucket, create a folder named `scripts` and [upload](../../storage/operations/objects/upload.md#simple) the `ch-to-dataproc.py` file to it.

1. [Create a PySpark job](../../data-proc/operations/jobs-pyspark.md#create) with the file path to your script specified in the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field: `s3a://<input_bucket_name>/scripts/ch-to-dataproc.py`.

1. Wait for the job to complete and verify that the output bucket's `csv` folder contains the exported table.

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}

## Import data to {{ mch-name }} {#import-to-mch}

1. Prepare a script file:

    1. Create a local file named `dataproc-to-ch.py` and copy the following script into it:

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

        # Specifying the port and other {{ CH }} cluster settings
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

    1. In your script, specify the following:

        * {{ mch-name }} cluster ID.
        * `user1` password.

    1. In the input bucket, create a folder named `scripts` and [upload](../../storage/operations/objects/upload.md#simple) the `dataproc-to-ch.py` file to it.

1. [Create a PySpark job](../../data-proc/operations/jobs-pyspark.md#create) with the file path to your script specified in the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field: `s3a://<input_bucket_name>/scripts/dataproc-to-ch.py`.

1. Wait for the job to complete and verify that the data has been transferred to {{ mch-name }}:

    1. [Connect to the `db1` database](../../managed-clickhouse/operations/connect/clients.md) in the {{ mch-name }} cluster as `user1`.
    1. Run this query:

        ```sql
        SELECT * FROM people;
        ```

    If the import is successful, the query will return the table contents.

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}

## Delete the resources you created {#clear-out}

Some resources incur charges. To avoid unnecessary expenses, delete the resources you no longer need:

1. [Delete all objects](../../storage/operations/objects/delete.md) from the buckets. Delete other resources using the method matching their creation method:

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
