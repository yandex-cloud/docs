---
title: How to set up and use Python virtual environments in {{ dataproc-full-name }}
description: Follow this guide to set up and use Python virtual environments.
---

# Setting up and using Python virtual environments

Using PySpark often requires installing or updating Python packages in {{ dataproc-name }} clusters. In this case, modifying the primary Python environment in a cluster may prove too time-consuming and unpractical. As a workaround, you can use isolated virtual environments when running each job:

1. [Set up a virtual environment](#prepare).

    For compatibility, set up your virtual environment on a temporary {{ dataproc-name }} cluster. Then place it in an archive, saved in an {{ objstorage-name }} bucket.

1. [Use the virtual environment](#launch) from the archive when running jobs in {{ dataproc-name }} clusters.

    You can use Python virtual environments:

    * [When running PySpark jobs normally](#launch-common).
    * [When running PySpark jobs in {{ dataproc-name }} clusters integrated with {{ ml-platform-full-name }}](#launch-datasphere).
    * [When running PySpark jobs in Zeppelin notebooks](#launch-zeppelin).

## Setting up a Python virtual environment {#prepare}

1. [Create a service account](../../iam/operations/sa/create.md) with the `dataproc.agent` and `dataproc.provisioner` roles.
1. In {{ objstorage-name }}, [create a bucket](../../storage/operations/buckets/create.md) to store cluster logs and a virtual environment archive.
1. [Configure an ACL](../../storage/operations/buckets/edit-acl.md) for the bucket by granting the `READ and WRITE` permissions to the service account.
1. [Create](./cluster-create.md) a temporary {{ dataproc-name }} cluster. When creating it, specify:

    * {{ dataproc-name }} version, same as that of the cluster to use the environment on. This ensures compatibility.
    * Components:
        * `SPARK`
        * `YARN`
    * Bucket for storing logs.
    * Service account with bucket access.
    * Optionally, public access to the master host subcluster.

    We recommend specifying the minimum required settings for host resources.

1. [Use SSH to connect](connect-ssh.md) to the temporary {{ dataproc-name }} cluster.
1. Run the built-in [Virtualenv](https://spark.apache.org/docs/latest/api/python/user_guide/python_packaging.html#using-virtualenv) tool for managing virtual environments:

    ```bash
    python -m venv pyspark_venv && \
    source pyspark_venv/bin/activate
    ```

1. Install `venv-pack` and other Python environment modules you need:

    ```bash
    pip install venv-pack <list_of_modules>
    ```

    Here is an example:

    ```bash
    pip install venv-pack pyarrow pandas catboost
    ```

1. Archive the environment you got with the `venv-pack` command:

    ```bash
    venv-pack -o <archive_name>.tar.gz
    ```

1. Send the environment archive to the {{ objstorage-short-name }} bucket you created earlier:

    ```bash
    hdfs dfs -copyFromLocal <archive_name>.tar.gz s3a://<bucket_name>/
    ```

1. [Delete](./cluster-delete.md) the temporary {{ dataproc-name }} cluster to avoid paying for it.

## Using a virtual environment {#launch}

To use your virtual environment in the {{ dataproc-name }} cluster, grant the cluster service account permissions to write and read data in the archive bucket. There are two ways to do this:

* [Edit the bucket ACL](../../storage/operations/objects/edit-acl.md) by granting the `READ` permission to the cluster service account.
* [Assign](../../iam/operations/roles/grant.md) the `storage.viewer` role to the service account.

### Using a virtual environment when running PySpark jobs normally {#launch-common}

When [creating a PySpark job](./jobs-pyspark.md#create), set the following [Spark property](https://spark.apache.org/docs/latest/configuration.html) values at the job level:

* `spark.submit.deployMode=cluster`: Driver deploy mode.

    Make sure to run jobs in `cluster` mode to set up your virtual environment properly. For more information, see [{#T}](../concepts/spark-sql.md#resource-management).

* `spark.yarn.dist.archives='s3a://<bucket_name>/<archive_name>.tar.gz#<alias>'`: Path to the archive with your environment.

    Enter an environment alias of your choice after the `#` character. The alias will serve as the name of the subdirectory the archive will be unpacked to.

* `spark.yarn.appMasterEnv.PYSPARK_PYTHON=./<alias>/bin/python`: Overrides the run Python interpreter command for the YARN Application Master process.
* `spark.yarn.appMasterEnv.PYSPARK_DRIVER_PYTHON=./<alias>/bin/python`: Overrides the run Python interpreter command for the job driver.

This makes the dependencies within the virtual environment available when running jobs.

### Using a virtual environment when integrating a {{ dataproc-name }} cluster with {{ ml-platform-full-name }} {#launch-datasphere}

{{ ml-platform-full-name }} and {{ dataproc-name }} integration is based on using the [Apache Livy](https://livy.apache.org/) component as part of {{ dataproc-name }}. For more information, see [Integration with {{ ml-platform-full-name }}](../tutorials/datasphere-integration.md).

To use Python virtual environments integrated with {{ ml-platform-full-name }}, configure the additional settings:

1. Set the `cluster` driver deploy mode on the {{ dataproc-name }} cluster’s side. To do this, provide the `livy:livy.spark.deploy-mode=cluster` [component property](../concepts/settings-list.md) value when [updating the cluster](./cluster-update.md).

    For more information, see [{#T}](../concepts/spark-sql.md#resource-management).

1. On the {{ ml-platform-full-name }} side, [create a Livy session](../../datasphere/concepts/data-processing.md#session) with the following settings:

    ```livy
    %create_livy_session \
        --cluster <cluster_name_or_ID> --id <Livy_session_ID> \
        --conf spark.yarn.dist.archives=s3a://<bucket_name>/<archive_name>.tar.gz#<alias> \
        --conf spark.yarn.appMasterEnv.PYSPARK_PYTHON=./<alias>/bin/python \
        --conf <other_Spark_context_parameters> ...
    ```

    Where:

    * `<cluster_name_or_ID>`: Name or ID of the {{ dataproc-name }} cluster used for integration.
    * `<Livy_session_ID>`: Arbitrary string to identify the Livy session in the cluster.
    * `<bucket_name>`: Bucket with the environment archive.
    * `<archive_name>`: Ready-to-use archive with the Python environment.
    * `<alias>`: Environment alias of your choice. The alias will serve as the name of the subdirectory the archive will be unpacked to.
    * `<other_Spark_context_parameters>`: Specify them if needed. For a complete list of parameters, see [this Spark article](https://spark.apache.org/docs/latest/configuration.html#available-properties).

Specify the session you created [when running Python code in the cluster](../../datasphere/concepts/data-processing.md#run-code). You will be able to use dependencies included in the virtual environment.

### Using a virtual environment in a Zeppelin notebook {#launch-zeppelin}

To use Python virtual environments for operations in a Zeppelin notebook:

1. In the Zeppelin interface, navigate to the **Interpreter** settings and edit the **spark** section by setting the Spark context mode to `Per Note` and `Isolated`. This will allow different notebooks to use different virtual environments.
1. Create a new cell named `%spark.conf` and use it to provide variables for a Spark session:

    ```spark
    %spark.conf
    spark.submit.deployMode cluster
    spark.yarn.dist.archives s3a://<bucket_name>/<archive_name>.tar.gz#<alias>
    spark.yarn.appMasterEnv.PYSPARK_PYTHON ./<alias>/bin/python
    spark.pyspark.python ./<alias>/bin/python
    ```

    Where:

    * `spark.submit.deployMode cluster`: Driver deploy mode.

        Make sure to run jobs in `cluster` mode to set up your virtual environment properly. For more information, see [{#T}](../concepts/spark-sql.md#resource-management).

    * `spark.yarn.dist.archives 's3a://<bucket_name>/<archive_name>.tar.gz#<alias>'`: Path to the archive with your environment.

        Enter an environment alias of your choice after the `#` character. The alias will serve as the name of the subdirectory the archive will be unpacked to.

    * `spark.yarn.appMasterEnv.PYSPARK_PYTHON ./<alias>/bin/python`: Overrides the run Python interpreter command for the YARN Application Master process.
    * `spark.pyspark.python ./<alias>/bin/python`: Overrides the run Python interpreter command for the job driver.

    When executing the next cell that uses Spark, such as a cell in `%spark.pyspark` or `%spark.sql` mode, a Spark session will be created with the specified settings. The virtual environment dependencies will be available in this session.
