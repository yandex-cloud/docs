---
title: How to set up and use Python virtual environments in {{ dataproc-full-name }}
description: Follow this guide to set up and use Python virtual environments.
---

# Setting up and using Python virtual environments

When using PySpark, it is often required to install or update Python packages in {{ dataproc-name }} clusters. In this case, changing the primary Python environment in a cluster may turn out too time-consuming and unpractical. As an alternative, you can use isolated virtual environments when running each job:

1. [Set up a virtual environment](#prepare).

    For compatibility, a virtual environment is set up on a temporary {{ dataproc-name }} cluster. It is then placed in an archive that is saved in an {{ objstorage-name }} bucket.

1. [Use the virtual environment](#launch) from the archive when running jobs in {{ dataproc-name }} clusters.

    Python virtual environments can be used:

    * [At regular runs of PySpark jobs](#launch-common)
    * [When running PySpark jobs in {{ dataproc-name }} clusters integrated with {{ ml-platform-full-name }}](#launch-datasphere)
    * [When running PySpark jobs in Zeppelin notebooks](#launch-zeppelin)

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
    * (Optional) Public access to the subcluster with the master host.

    We recommend specifying the minimum required settings of host resources.

1. [Use SSH to connect](./connect.md#data-proc-ssh) to the temporary {{ dataproc-name }} cluster.
1. Run the built-in [Virtualenv](https://spark.apache.org/docs/latest/api/python/user_guide/python_packaging.html#using-virtualenv) tool for managing virtual environments:

    ```bash
    python -m venv pyspark_venv && \
    source pyspark_venv/bin/activate
    ```

1. Install `venv-pack` and other Python environment modules you need:

    ```bash
    pip install venv-pack <list_of_modules>
    ```

    Example:

    ```bash
    pip install venv-pack pyarrow pandas catboost
    ```

1. Archive the resulting environment with the `venv-pack` command:

    ```bash
    venv-pack -o <archive_name>.tar.gz
    ```

1. Send the archive with the environment to the previously created {{ objstorage-short-name }} bucket:

    ```bash
    hdfs dfs -copyFromLocal <archive_name>.tar.gz s3a://<bucket_name>/
    ```

1. [Delete](./cluster-delete.md) the temporary {{ dataproc-name }} cluster to avoid paying for it.

## Using a virtual environment {#launch}

To use the prepared virtual environment in the {{ dataproc-name }} cluster, grant the cluster service account permissions to write and read data in the bucket that stores the archive. There are two ways to do this:

* [Edit the bucket ACL](../../storage/operations/objects/edit-acl.md) by granting the `READ` permission to the cluster service account.
* [Assign](../../iam/operations/roles/grant.md) the `storage.viewer` role to the service account.

### Using a virtual environment at regular runs of PySpark jobs {#launch-common}

When [creating a PySpark job](./jobs-pyspark.md#create), set the following [Spark property](https://spark.apache.org/docs/latest/configuration.html) values at the job level:

* `spark.submit.deployMode=cluster`: Driver deploy mode.

    Make sure to run jobs in `cluster` mode to set up your virtual environment properly. For more information about the driver deploy mode, see [{#T}](../concepts/spark-sql.md#resource-management).

* `spark.yarn.dist.archives='s3a://<bucket_name>/<archive_name>.tar.gz#<alias>'`: Path to the archive with the prepared environment.

    Enter an environment alias of your choice after the `#` character. The alias will be used as the name of the subdirectory the archive will be unpacked to.

* `spark.yarn.appMasterEnv.PYSPARK_PYTHON=./<alias>/bin/python`: Overrides the run Python interpreter command for the YARN Application Master process.
* `spark.yarn.appMasterEnv.PYSPARK_DRIVER_PYTHON=./<alias>/bin/python`: Overrides the run Python interpreter command for the job driver.

This makes the dependencies within the virtual environment available during job execution.

### Using a virtual environment when integrating the {{ dataproc-name }} cluster with {{ ml-platform-full-name }} {#launch-datasphere}

{{ ml-platform-full-name }} and {{ dataproc-name }} integration is based on using the [Apache Livy](https://livy.apache.org/) component as part of {{ dataproc-name }}. For more information about setting up integration with {{ ml-platform-full-name }}, see [Integration with {{ ml-platform-full-name }}](../tutorials/datasphere-integration.md).

To use Python virtual environments integrated with {{ ml-platform-full-name }}, configure additional settings:

1. Set the `cluster` driver deploy mode on the {{ dataproc-name }} cluster side. To do this, provide the `livy:livy.spark.deploy-mode=cluster` [component property](../concepts/settings-list.md) value when [updating the cluster](./cluster-update.md).

    For more information about the driver deploy mode, see [{#T}](../concepts/spark-sql.md#resource-management).

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
    * `<alias>`: Environment alias of your choice. The alias will be used as the name of the subdirectory the archive will be unpacked to.
    * `<other_Spark_context_parameters>`: Specified if needed. For a complete list of parameters, see the [Spark documentation](https://spark.apache.org/docs/latest/configuration.html#available-properties).

Specify the created session [when running Python code in the cluster](../../datasphere/concepts/data-processing.md#run-code). Dependencies included in the virtual environment will be available for use.

### Using a virtual environment in a Zeppelin notebook {#launch-zeppelin}

To use Python virtual environments when working in a Zeppelin notebook:

1. In the Zeppelin interface, go to the **Interpreter** settings, and edit the **spark** section by setting the Spark context mode to `Per Note` and `Isolated`. This will allow different notebooks to use different virtual environments.
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

        Make sure to run jobs in `cluster` mode to set up your virtual environment properly. For more information about the driver deploy mode, see [{#T}](../concepts/spark-sql.md#resource-management).

    * `spark.yarn.dist.archives 's3a://<bucket_name>/<archive_name>.tar.gz#<alias>'`: Path to the archive with the prepared environment.

        Enter an environment alias of your choice after the `#` character. The alias will be used as the name of the subdirectory the archive will be unpacked to.

    * `spark.yarn.appMasterEnv.PYSPARK_PYTHON ./<alias>/bin/python`: Overrides the run Python interpreter command for the YARN Application Master process.
    * `spark.pyspark.python ./<alias>/bin/python`: Overrides the run Python interpreter command for the job driver.

    When executing the next cell that uses Spark, such as a cell in `%spark.pyspark` or `%spark.sql` mode, a Spark session will be created with the specified settings. The virtual environment dependencies will be available in this session.
