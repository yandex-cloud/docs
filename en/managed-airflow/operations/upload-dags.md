# Uploading DAG files to a {{ maf-name }} cluster

Automation, data processing, and scheduled task execution are implemented using _[DAG files](../concepts/index.md#about-the-service)_. DAG files are Python 3 scripts run inside {{ AF }}. For a DAG file example, check [this {{ AF }} tutorial](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html).

You can import DAG files from:

* [{{ objstorage-full-name }} bucket](#dag-bucket-import)
* [External Git repository](#dag-git-import)

You can select the DAG file source type when [creating](cluster-create.md) or [updating the cluster](cluster-update.md). This automatically delivers DAGs to your {{ maf-name }} cluster and makes them appear in the {{ AF }} web UI.

## Importing DAG files from a bucket {#dag-bucket-import}

1. Create a folder, e.g., `dags`, in the [bucket](../../storage/concepts/bucket.md) and [upload your DAG file to it](../../storage/operations/objects/upload.md#simple). The system will automatically import the DAG file to the cluster.

    You can upload your DAG file to the bucket root, but it uploads quicker to a folder.

    If you need to upload additional scripts or modules used in the DAG to this folder, specify the full path to these scripts or modules in the bucket. Let’s say, you have uploaded all the files to the `dags` folder. If so, specify the following in `from ... import` of the DAG file:

    ```python
    from dags.<file_name> import <object>
    ```

1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure that the new DAG has appeared in the **DAGs** section. It may take a few minutes to load a DAG file from the bucket.

## Importing DAG files from a Git repository {#dag-git-import}

1. Upload your DAG file to the Git repository folder specified along with the repository address in the cluster settings. The system will automatically import the DAG file to the cluster.

    If you upload additional scripts or modules used in the DAG to this folder, specify the full path to these scripts or modules. Let’s say, you have uploaded all the files to the `dags` folder. If so, specify the following in `from ... import` of the DAG file:

    ```python
    from dags.<file_name> import <object>
    ```

1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure that the new DAG has appeared in the **DAGs** section. It may take a few minutes to import your DAG file from the Git repository.
