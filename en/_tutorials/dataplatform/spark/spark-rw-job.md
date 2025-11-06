# Working with an {{ objstorage-name }} table from a PySpark job using {{ metastore-full-name }} and {{ IBRG }}


Integrating {{ msp-full-name }} with [{{ metastore-full-name }}](../../../metadata-hub/concepts/metastore.md) and {{ IBRG }} strongly empowers you in managing your data in {{ objstorage-name }} via SQL tables.

{{ metastore-name }} provides:
* Centrally storing metadata on databases, tables, and partitions.
* Readily accessing your data without manually specifying paths and schemas.
* Conveniently storing table and column statistics for query optimization.

{{ IBRG }} provides:
* Versioning data and storing snapshots.
* Running ACID transactions that support `UPDATE`, `DELETE`, and `MERGE` operations, as well as the evolution of tables and the partitioning method.
* Ensuring scalability while maintaining high operational performance.

In this tutorial, you will learn how to use the following {{ metastore-name }} and {{ IBRG }} features when working with S3 storage from a PySpark job:

* Accessing a table by name.

  For all clusters, {{ metastore-name }} uses a global metadata catalog. The stored metadata can then be used by any app from any {{ SPRK }} cluster connected to that {{ metastore-name }} cluster.

* Creating and reading metadata snapshots.

  {{ IBRG }} commits each write to the table as a new metadata snapshot. Then, you can access these snapshots by specifying a time point or snapshot ID.

To implement the above example, do the following:

1. [Set up your infrastructure](#infra).
1. [Prepare and run a PySpark job](#prepare-job).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ objstorage-name }} bucket fee: Covers data storage and bucket operations (see [{{ objstorage-name }} pricing](../../../storage/pricing.md)).
* Fee for collecting and storing logs (see [{{ cloud-logging-name }} pricing](../../../logging/pricing.md)).
* Fee for the computing resources of {{ msp-full-name }} cluster components (see [{{ msp-full-name }} pricing](../../../managed-spark/pricing.md)).
* Fee for the computing resources of {{ metastore-name }} cluster components (see [{{ metadata-hub-full-name }} pricing](../../../metadata-hub/pricing.md)).


## Set up the infrastructure {#infra}

Set up the infrastructure:

1. [Create a service account](../../../iam/operations/sa/create.md) named `spark-agent` and assign it the [managed-spark.integrationProvider](../../../iam/roles-reference.md#managed-spark-integrationProvider) role.

1. [Create a service account](../../../iam/operations/sa/create.md) named `metastore-agent` and assign it the [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider) role to enable your {{ metastore-name }} cluster to [interact with other resources](../../../metadata-hub/concepts/metastore-impersonation.md).

1. [Create buckets](../../../storage/operations/buckets/create.md):

    * One for the PySpark job source code.
    * One for output data.

1. [Grant permissions](../../../storage/operations/buckets/edit-acl.md) to the `spark-agent` service account for the created buckets:

    * Bucket for the PySpark job source code: `READ`.
    * Bucket for output data: `READ and WRITE`.

1. [Grant](../../../storage/operations/buckets/edit-acl.md) `metastore-agent` the `READ and WRITE` permissions for the output bucket.

1. [Create a cloud network](../../../vpc/operations/network-create.md) named `integration-network`.

    This will automatically create three subnets in different availability zones.

1. For the {{ SPRK }} cluster, [create a security group](../../../vpc/operations/security-group-create.md) named `spark-sg` in `integration-network`. Add the following rule to it:

    * For outgoing traffic, to allow {{ SPRK }} cluster connections to {{ metastore-name }}:

        * Port range: `{{ port-metastore }}`
        * Protocol: `Any`
        * Destination: `CIDR`
        * CIDR blocks: `0.0.0.0/0`

1. For the {{ metastore-name }} cluster, [create a security group](../../../vpc/operations/security-group-create.md) named `metastore-sg` in `integration-network`. Add the following rules to it:

    * For incoming client traffic:

        * Port range: `30000-32767`
        * Protocol: `Any`
        * Source: `CIDR`
        * CIDR blocks: `0.0.0.0/0`

    * For incoming load balancer traffic:

        * Port range: `10256`
        * Protocol: `Any`
        * Source: `Load balancer health checks`

1. [Create a {{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-create.md) with the following parameters:

    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `metastore-agent`.
    * **{{ ui-key.yacloud.mdb.forms.label_network }}**: `integration-network`.
    * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}**: `integration-network-{{ region-id }}-a`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `metastore-sg`.

1. [Create a {{ SPRK }} cluster](../../../managed-spark/operations/cluster-create.md) with the following parameters:

    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `spark-agent`.
    * **{{ ui-key.yacloud.mdb.forms.label_network }}**: `integration-network`.
    * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}**: `integration-network-{{ region-id }}-a`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `spark-sg`.
    * **{{ ui-key.yacloud.spark.label_metastore }}**: {{ metastore-name }} cluster you created earlier.

## Prepare and run a PySpark job {#prepare-job}

For a PySpark job, we will use a Python script that:

1. Creates a database and table in {{ IBRG }} format in the bucket.
1. Writes 10 rows of data to the table.
1. Stores the ID of the current table snapshot.
1. Writes 10 more rows of data to the table.
1. Displays the number of rows in the current table state.
1. Displays the number of rows in the table state at the time of the snapshot. 

Prepare a script file:

1. Create the `ice_min_demo.py` file and paste the following code to it:

   {% cut "ice_min_demo.py" %}

   ```python
   import random
   from pyspark.sql import SparkSession

   spark = (
      SparkSession.builder
      .appName("ice_min_demo")
      .enableHiveSupport()
      .getOrCreate()
   )

   # Creating a database and table in {{ IBRG }} format
   # {{ metastore-name }} captures metadata, allowing you to access the table by the `db.tbl` name
   # from any Spark apps associated with this {{ metastore-name }} cluster.
   db, tbl = "demo_db", "demo_events"
   spark.sql(f"CREATE DATABASE IF NOT EXISTS {db}")
   spark.sql(f"""
   CREATE TABLE IF NOT EXISTS {db}.{tbl} (
      id BIGINT,
      value DOUBLE
   ) USING iceberg
   """)

   # Writing the first piece of data to the table
   df1 = spark.createDataFrame([(i, random.random()) for i in range(10)], ["id","value"])
   df1.writeTo(f"{db}.{tbl}").append()

   # Fetching the ID of the current snapshot from the `.snapshots` housekeeping table
   snap_before = spark.sql(f"SELECT max(snapshot_id) AS s FROM {db}.{tbl}.snapshots").collect()[0][0]

   # Writing the second piece of data to the table
   df2 = spark.createDataFrame([(i, random.random()) for i in range(10, 20)], ["id","value"])
   df2.writeTo(f"{db}.{tbl}").append()

   # Counting and displaying the number of rows in the table's current (20) and previous (10) state
   cnt_now = spark.table(f"{db}.{tbl}").count()
   cnt_past = spark.sql(f"SELECT COUNT(*) FROM {db}.{tbl} VERSION AS OF {snap_before}").collect()[0][0]
   print(f"now_count: {cnt_now} | past_count: {cnt_past}", flush=True)

   spark.stop()
   ```

   {% endcut %}

1. In the source code bucket, create a folder named `scripts` and [upload](../../../storage/operations/objects/upload.md#simple) the `ice_min_demo.py` file to this folder.
1. [Create a job](../../../managed-spark/operations/jobs-pyspark.md) with the following settings:
    * **Job type**: **PySpark**.
    * **Main python file**: `s3a://<source_code_bucket>/scripts/ice_min_demo.py`.
    * **Arguments**: `spark.sql.warehouse.dir` – `s3a://<output_data_bucket>/warehouse/`.

## Check the result {#check-out}

1. Wait for the PySpark job you created to change its status to **Done**.
1. Open the [job execution logs](../../../managed-spark/operations/jobs-pyspark.md#get-logs).
1. In the logs, navigate to this string: `now_count: 20 | past_count: 10`.
1. Make sure the `warehouse/demo_db` folder appears in your output data bucket. The data from the new database, `demo_db`, is now stored in the {{ objstorage-name }} bucket, and the DB metadata, in the {{ metastore-name }} cluster.
 
## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [{{ objstorage-name }} buckets](../../../storage/operations/buckets/delete.md). Before deleting your buckets, make sure to [have deleted all objects from those buckets](../../../storage/operations/objects/delete.md).
1. [{{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-delete.md).
1. [{{ SPRK }} cluster](../../../managed-spark/operations/cluster-delete.md).
