---
title: Uploading DAG files to a {{ maf-full-name }} cluster
description: Upload the DAG files from your {{ objstorage-name }} bucket or Git repository to your {{ maf-name }} cluster, and make sure they appear in the web UI.
---

# Uploading DAG files to a {{ maf-name }} cluster

A {{ maf-name }} cluster automatically loads [DAG files](../concepts/index.md#about-the-service) from the configured source, such as the following:

* [{{ objstorage-full-name }} bucket](#dag-bucket-import)
* [External Git repository](#dag-git-import)

Prepare a DAG file. You can find an example in [this {{ AF }} guide](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html). If a DAG uses additional scripts or modules, [configure their import](#additional-modules).

## Importing DAG files from a bucket {#dag-bucket-import}

When [creating](cluster-create.md) or [updating a cluster](cluster-update.md), select a bucket as the source of DAG files and configure the bucket access permissions for the cluster’s service account.

1. Create a folder, e.g., `dags`, in the selected [bucket](../../storage/concepts/bucket.md) and [upload your DAG file to it](../../storage/operations/objects/upload.md#simple). If the DAG uses additional scripts or modules, upload them along with the DAG.

    You can upload your DAG file to the bucket root, but it uploads quicker to a folder.

1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure that the new DAG has appeared in the **DAGs** section. It may take a few minutes to load a DAG file from the bucket.

## Importing DAG files from a Git repository {#dag-git-import}

When [creating](cluster-create.md) or [updating a cluster](cluster-update.md), select a Git repository as the source of DAG files. Specify the repository URL, branch, DAG files directory, and [authentication](../concepts/dag-sources.md#git-auth) parameters.

{% include [git-sync-network](../../_includes/mdb/maf/note-git-sync-network.md) %}

1. Add the DAG file to the Git repository directory specified in the cluster settings. If the DAG uses additional scripts or modules, add them along with the DAG.
1. Push your changes to the remote branch specified in the cluster settings. If you are working with a local repository copy, create a commit and push it to that branch.
1. [Open the {{ AF }} web interface](af-interfaces.md#web-gui).
1. Make sure that the new DAG has appeared in the **DAGs** section. It may take a few minutes to import your DAG file from the Git repository.

## Using additional scripts and modules {#additional-modules}

If a DAG uses additional scripts or modules, upload them along with the DAG file to the bucket or Git repository. In the DAG file, specify the full path to these scripts or modules. Let’s say, you have uploaded all files to the `dags` folder. In this case, specify the following in the `from ... import` construct:

```python
from dags.<file_name> import <object>
```
