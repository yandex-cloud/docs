# Uploading DAG files to a {{ maf-name }} cluster

Automation, data processing, and scheduled task execution are implemented using _[DAG files](../concepts/index.md#about-the-service)_. DAG files are Python 3 scripts run inside {{ AF }}. For a DAG file example, check [this {{ AF }} tutorial](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html).

DAG files are uploaded to the [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md) specified when creating a cluster. This automatically delivers DAGs to a {{ maf-name }} cluster and makes them appear in the {{ AF }} web interface.

To upload DAG files to a cluster:

1. Create a folder, e.g., `dags`, in the bucket and [upload a DAG file to it](../../storage/operations/objects/upload.md#simple). This will upload your DAG to the cluster.

    You can upload your DAG file to the bucket root, but it uploads quicker to a folder.

    If you need to upload additional scripts or modules used in the DAG to this folder, specify the full path to these scripts or modules in the bucket. Let’s say, you have uploaded all the files to the `dags` folder. If so, specify the following in `from ... import` of the DAG file:

    ```python
    from dags.<file_name> import <object>
    ```

1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure that the new DAG has appeared in the **DAGs** section. It may take a few minutes to load a DAG file from the bucket.

