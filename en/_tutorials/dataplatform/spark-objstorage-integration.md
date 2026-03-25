# Using {{ objstorage-full-name }} in {{ msp-full-name }}


In {{ objstorage-full-name }} buckets, you can store both files required to run jobs in a {{ msp-full-name }} cluster and the results of those jobs.

{{ msp-full-name }} clusters are pre-configured to work with S3 storages. To use an {{ objstorage-name }} bucket in a PySpark job:
* Grant the {{ msp-full-name }} cluster service account permission to access the {{ objstorage-name }} bucket.
* In the job's arguments, specify the path to the folder in the {{ objstorage-name }} bucket.

This guide gives an example of how to use a table in an {{ objstorage-name }} bucket from a PySpark job using a built-in local Hive catalog.

To implement the above example:

1. [Set up your infrastructure](#infra).
1. [Prepare a PySpark job](#prepare-a-job).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).

{% note info %}

With a local Hive catalog, you can access tables by name without specifying a path and use basic Hive features without connecting a {{ metastore-name }} cluster. The metadata stored in the local folder remains inaccessible to other clusters. For an example of using a global folder, see [{#T}](../../managed-spark/tutorials/metastore-and-spark.md).

{% endnote %}


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ objstorage-name }} bucket fee for using storage and performing data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* {{ cloud-logging-name }} fee for the amount of data written and the time of its retention (see [{{ cloud-logging-name }} pricing](../../logging/pricing.md)).


## Set up your infrastructure {#infra}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Create a service account](../../iam/operations/sa/create.md) named `spark-agent` for the {{ msp-full-name }} cluster and assign it the [managed-spark.integrationProvider](../../iam/roles-reference.md#managed-spark-integrationProvider) role to enable the {{ msp-full-name }} cluster to interact with other resources.

    1. [Create buckets](../../storage/operations/buckets/create.md):

        * `<bucket_for_PySpark_job_source_code>`.
        * `<bucket_for_PySpark_job_output_data>`.

    1. [Grant permissions](../../storage/operations/buckets/edit-acl.md) to the `spark-agent` service account for the created buckets:

        * `<bucket_for_PySpark_job_source_code>`: `READ` permission.
        * `<bucket_for_PySpark_job_output_data>`: `READ and WRITE` permission.

    1. [Create a cloud network](../../vpc/operations/network-create.md) named `spark-network`.

        This will automatically create three subnets in different availability zones.

    1. [Create a {{ msp-full-name }} cluster](../../managed-spark/operations/cluster-create.md) with the following parameters:

        * **Service account**: `spark-agent`
        * **Network**: `spark-network`
        * **Subnet**: `spark-network-{{ region-id }}-a`

{% endlist %}

## Prepare a PySpark job {#prepare-a-job}

For a PySpark job, we use a Python script that creates a table named `table_1` in `database_1`. The PySpark job's arguments give the path to the folder the database will be created in. To connect the built-in Hive catalog, your script should specify this Spark session configuration parameter: `spark.sql.catalogImplementation=hive`. The script will be stored in the {{ objstorage-name }} bucket.

Prepare a script file:

{% list tabs group=instructions %}

- Management console {#console}

    1. Create a local file named `job_save_table.py` and paste the following script to it:

       {% cut "job_save_table.py" %}

       {% include [pyspark](../_tutorials_includes/spark/job-save-table-pyspark.md) %}

       {% endcut %}

    1. In `<bucket_for_PySpark_job_source_code>`, create a folder named `scripts` and [upload](../../storage/operations/objects/upload.md#simple) the `job_save_table.py` file to it.
    1. [Create a job](../../managed-spark/operations/jobs-pyspark.md) with the following settings:
        * **Job type**: **PySpark**
        * **Main python file**: `s3a://<bucket_for_PySpark_job_source_code>/scripts/job_save_table.py`
        * **Arguments**: `s3a://<bucket_for_PySpark_job_output_data>/warehouse`

{% endlist %}

## Check the result {#check-out}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select a folder.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}** service.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Wait for the PySpark job you created to change its status to **Done**.
    1. Make sure the `warehouse` folder in `<bucket_for_PySpark_job_output_data>` now contains `database_1`. The data from the new DB is now stored in the {{ objstorage-name }} bucket in JSON format.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Management console {#console}

    1. [{{ objstorage-name }} buckets](../../storage/operations/buckets/delete.md).
    1. [{{ msp-full-name }} cluster](../../managed-spark/operations/cluster-delete.md).

{% endlist %}
