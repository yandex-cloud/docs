# Uploading DAG files to a {{ maf-name }} cluster

Automation, data processing, and scheduled task execution are implemented using _[DAG files](../concepts/index.md#about-the-service)_. DAG files are Python scripts running inside {{ AF }}. For a DAG file example, see the [{{ AF }} documentation](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html).

DAG files are uploaded to the [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md) specified when creating the cluster. This automatically delivers DAG task graphs into a {{ maf-name }} cluster and makes them appear in the {{ AF }} web interface.

To upload DAG files into a cluster:

1. [Grant](../../storage/operations/buckets/edit-acl.md) to the service account a `READ` permission for the bucket. Use the service account and bucket you specified when creating the cluster.
1. Create a folder named `dags` in the bucket and [upload the DAG file into it](../../storage/operations/objects/upload.md#simple). This will upload the DAG file into the cluster.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure that the new DAG file has appeared in the **DAGs** section. It may take several minutes to upload a DAG file from the bucket.
