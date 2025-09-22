# Using {{ objstorage-full-name }} in {{ msp-full-name }}


In {{ objstorage-full-name }} buckets, you can store both files required to run jobs in a {{ msp-full-name }} cluster and the results of those jobs.

To use {{ objstorage-name }} in {{ msp-name }}:

1. [Set up your infrastructure](#infra).
1. [Prepare a PySpark job](#prepare-a-job).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ objstorage-name }} bucket fee for using storage and performing data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* {{ cloud-logging-name }} fee for the amount of data written and the time of its retention (see [{{ cloud-logging-name }} pricing](../../logging/pricing.md)).


## Set up the infrastructure {#infra}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Create a service account](../../iam/operations/sa/create.md) named `spark-agent` for the {{ SPRK }} cluster and assign it the [managed-spark.integrationProvider](../../iam/roles-reference.md#managed-spark-integrationProvider) role to enable the {{ SPRK }} cluster to interact with other resources.

    1. [Create buckets](../../storage/operations/buckets/create.md):

        * `<bucket_for_PySpark_job_source_code>`.
        * `<bucket_for_PySpark_job_output_data>`.

    1. [Grant permissions](../../storage/operations/buckets/edit-acl.md) to the `spark-agent` service account for the created buckets:

        * `<bucket_for_PySpark_job_source_code>`: `READ` permission.
        * `<bucket_for_PySpark_job_output_data>`: `READ and WRITE` permission.

    1. [Create a cloud network](../../vpc/operations/network-create.md) named `spark-network`.

        This will automatically create three subnets in different availability zones.

    1. [Create a {{ msp-name }} cluster](../../managed-spark/operations/cluster-create.md) with the following parameters:

        * **Service account**: `spark-agent`
        * **Network**: `spark-network`
        * **Subnet**: `spark-network-{{ region-id }}-a`

{% endlist %}

## Prepare a PySpark job {#prepare-a-job}

For a PySpark job, we will use a Python script that is stored in the {{ objstorage-name }} bucket and creates a table named `table_1` in `database_1`. Prepare a script file:

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

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the name of your cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Wait for the PySpark job you created to change its status to **Done**.
    1. Make sure the `warehouse` folder in `<bucket_for_PySpark_job_output_data>` now contains `database_1`. The data from the new DB is now stored in the {{ objstorage-name }} bucket in JSON format.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Management console {#console}

    1. [{{ objstorage-name }} buckets](../../storage/operations/buckets/delete.md).
    1. [{{ SPRK }} cluster](../../managed-spark/operations/cluster-delete.md).

{% endlist %}
