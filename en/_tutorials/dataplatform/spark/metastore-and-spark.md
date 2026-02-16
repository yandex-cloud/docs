# {{ msp-full-name }} integration with {{ metastore-full-name }}


You can connect an {{ metastore-name }} cluster to an {{ SPRK }} cluster. In this case, metadata produced by job runs will get uploaded to the {{ metastore-name }} cluster. The saved metadata can be used by another {{ SPRK }} cluster.

Below, we walk you through an example of using a PySpark job to create a database and a table within it and then load the data from the new database into a {{ objstorage-full-name }} bucket. Database metadata is stored in an {{ metastore-name }} cluster connected to an {{ SPRK }} cluster.

To implement the above example, do the following:

1. [Set up the infrastructure](#infra).
1. [Prepare and run a PySpark job](#prepare-job).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ objstorage-name }} bucket fee for storage and data operations (see [{{ objstorage-name }} pricing](../../../storage/pricing.md)).
* {{ cloud-logging-full-name }} fee for the amount of data written and the time of its retention (see [{{ cloud-logging-name }} pricing](../../../logging/pricing.md)).
* Fee for the computing resources of {{ msp-name }} cluster components (see [{{ msp-name }} pricing](../../../managed-spark/pricing.md)).
* Fee for the computing resources of {{ metastore-name }} cluster components (see [{{ metadata-hub-full-name }} pricing](../../../metadata-hub/pricing.md)).


## Set up the infrastructure {#infra}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Create a service account](../../../iam/operations/sa/create.md) named `spark-agent` for the {{ SPRK }} cluster and assign it the [managed-spark.integrationProvider](../../../iam/roles-reference.md#managed-spark-integrationProvider) role to enable the {{ SPRK }} cluster to interact with other resources.

    1. [Create a service account](../../../iam/operations/sa/create.md) named `metastore-agent` and assign it the [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider) and [storage.uploader](../../../iam/roles-reference.md#storage-uploader) roles to enable your {{ metastore-name }} cluster to [interact with other resources](../../../metadata-hub/concepts/metastore-impersonation.md) and export metadata to the {{ objstorage-name }} bucket.

    1. [Create buckets](../../../storage/operations/buckets/create.md):

        * One for the PySpark job source code.
        * One for output data.

    1. [Grant permissions](../../../storage/operations/buckets/edit-acl.md) to the `spark-agent` service account for the created buckets:

        * Bucket for the PySpark job source code: `READ`.
        * Bucket for output data: `READ and WRITE`.

    1. [Grant](../../../storage/operations/buckets/edit-acl.md) the `READ and WRITE` permissions for the output bucket to the `metastore-agent` service account.

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
        * **{{ ui-key.yacloud.mdb.forms.base_field_version }}**: `{{ metastore.integration-version }}`.
        * **{{ ui-key.yacloud.mdb.forms.label_network }}**: `integration-network`.
        * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}**: `integration-network-{{ region-id }}-a`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `metastore-sg`.

    1. [Create a {{ msp-name }} cluster](../../../managed-spark/operations/cluster-create.md) with the following parameters:

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `spark-agent`.
        * **{{ ui-key.yacloud.mdb.forms.label_network }}**: `integration-network`.
        * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}**: `integration-network-{{ region-id }}-a`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `spark-sg`.
        * **{{ ui-key.yacloud.spark.label_metastore }}**: {{ metastore-name }} cluster you created earlier.

{% endlist %}

## Prepare a PySpark job {#prepare-job}

For a PySpark job, we will use a Python script that creates a database named `database_1` and a table named `table_1`. The script will be stored in the {{ objstorage-name }} bucket.

Prepare a script file:

{% list tabs group=instructions %}

- Management console {#console}

    1. Create a local file named `job-create-table.py` and paste the following script to it:

        {% cut "job-create-table.py" %}

        {% include [PySpark job](../../_tutorials_includes/spark/job-create-table.md) %}

        {% endcut %}

    1. In the source code bucket, create a folder named `scripts` and [upload](../../../storage/operations/objects/upload.md#simple) the `job-create-table.py` file to this folder.
    1. In the output bucket, create the `warehouse` folder to load data from `database_1` to.
    1. [Create a job](../../../managed-spark/operations/jobs-pyspark.md) with the following settings:
        * **Job type**: **PySpark**
        * **Main python file**: `s3a://<source_code_bucket>/scripts/job-create-table.py`
        * **Arguments**: `s3a://<bucket_for_output_data>/warehouse`

{% endlist %}

## Check the result {#check-result}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the name of your cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Wait for the PySpark job you created to change its status to **Done**.
    1. Make sure the file with data from `database_1` appears in the `warehouse` folder in your output data bucket.
    1. Make sure the {{ metastore-name }} cluster has the metadata on `database_1`:

        1. [Export the metadata](../../../metadata-hub/operations/metastore/export-and-import.md#export) from the {{ metastore-name }} cluster to the output bucket.
        1. [Download the metadata file](../../../storage/operations/objects/download.md) and make sure it mentions `database_1`.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Management console {#console}

    1. [{{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-delete.md).
    1. [{{ SPRK }} cluster](../../../managed-spark/operations/cluster-delete.md).
    1. [{{ objstorage-name }} buckets](../../../storage/operations/buckets/delete.md). Before deleting your buckets, make sure to [have deleted](../../../storage/operations/objects/delete.md) all objects from those buckets.

{% endlist %}


