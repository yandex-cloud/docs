# Computing on Apache Spark™ clusters

To use {{ dataproc-name }} clusters, pre-configure a project. To learn more, see the [concept](data-proc.md#settings).

Regardless of the deployment option, all {{ dataproc-name }} clusters are charged based on the [{{ dataproc-full-name }} pricing policy](../../data-proc/pricing.md). To view all the clusters available in your project, navigate to **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** ⟶ ![image](../../_assets/data-proc/data-proc.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}** on the project page.

{% note warning %}

As a user of a cluster deployed in {{ dataproc-name }}, you manage its lifecycle yourself. Even with no computations ongoing, the cluster will not be deleted and will remain billable.

{% endnote %}

{{ ml-platform-name }} supports using {{ dataproc-name }} clusters via:

 * [Spark connector](#spark-with-existing-cluster)
 * [Livy session](#livy-sessions)

## Spark connectors {#spark-with-existing-cluster}

A [Spark connector](spark-connector.md) is a special resource that stores connection settings for {{ dataproc-name }} clusters. Cluster connection settings are specified when [creating a Spark connector](../operations/data/spark-connectors.md#create). The clusters you select are either connected or created when you run computations in a cell.

You can [publish](../operations/data/spark-connectors.md#create) a Spark connector in a community, thus making it available for other projects. Changes to a Spark connector's settings will apply to all the projects the connector is used in.

For correct integration with {{ ml-platform-name }} via a Spark connector, make sure that the [image version](../../data-proc/concepts/environment.md) of the deployed {{ dataproc-name }} cluster is at least `2.0`, with `LIVY`, `SPARK`, and `YARN` enabled.

To learn more about using Spark connectors, see [this guide](../operations/data/spark-connectors.md).

### Running Python code in a cluster {#run-code-with-spark-connector}

{% include [run-python-code](../../_includes/datasphere/run-code-with-spark-connector.md) %}

### Syncing Python environment with a cluster {#synchronization}

When working with Python Spark via {{ ml-platform-name }}, there is no need to manually migrate the virtual environment. In a {{ dataproc-name }} cluster, you can change the basic composition of PyPI packages using a virtual environment:

1. Install the `catboost` library:

   ```python
   %pip install catboost
   ```

1. Once the installation is complete, from the top panel, select **Kernel** ⟶ **Restart kernel...**. If the installation completes without [errors](../troubleshooting/troubles-with-spark.md), the virtual environment will be automatically created and available in the Spark session using the `spark` variable.

To synchronize the environment, the Spark connector settings in the **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}** section must specify the [static access key](../../iam/concepts/authorization/access-key.md) ID for the bucket and the [secret](secrets.md) containing the static access key.

{% note warning %}

Python environment synchronization is running in test mode. To enable environment synchronization, in the Spark connector settings, under **{{ ui-key.yc-ui-datasphere.spark-connector.spark-settings }}**, specify the `.options` = `venv` parameter.

{% endnote %}

## Livy sessions {#livy-sessions}

For correct integration with {{ ml-platform-name }} via Livy sessions, make sure the [image version](../../data-proc/concepts/environment.md) of the deployed {{ dataproc-name }} cluster is at least `2.0`, with `LIVY`, `SPARK`, `YARN`, and `HDFS` enabled.

{% include [dataproc-s3-connector](../../_includes/datasphere/dataproc-s3-connector.md) %}

### Computing sessions {#session}

{% include [dataproc](../../_includes/datasphere/dataproc-sessions.md) %}

### {{ dataproc-name }} session restrictions {#restrictions}

{% include [cluster variables](../../_includes/datasphere/dataproc-session-vars.md) %}

### Running Python code in a cluster {#run-code}

The code is run in the cells with the header:

```text
#!spark [--cluster <cluster>] [--session <session>] [--variables <input_variable>] [--return_variables <returned_variable>]
```

Where:

* `--cluster`: {{ dataproc-name }} cluster to perform computations on. This can be:
  * Name of the cluster created through the notebook interface.
  * HTTP link to the internal IP address of the `masternode` host, such as `http://10.0.0.8:8998/`.
* `--session`: Computing session ID. If this parameter is not specified, the default {{ dataproc-name }} cluster session is used.
* `--variables`: Variable imported to the {{ ml-platform-name }} cluster from {{ dataproc-name }}. Supported types include `bool`, `int`, `float`, `str`, and `pandas.DataFrame` (converted to Spark DataFrame in a cluster).
* `--return_variables`: Variable to be exported from the {{ dataproc-name }} cluster to {{ ml-platform-name }}. Supported type: `bool`, `int`, `float`, `str`, `pandas.DataFrame` (transformed Spark DataFrame).

### Example of using computing sessions with user-defined parameters {#example-custom-sessions}

To run computations in a session with defined settings, first create this session and then provide the code in the cell with the `#!spark` header:

1. Create a session and set its parameters:

   ```python
   %create_livy_session --cluster my-new-cluster --id ses1 --conf spark.cores.max=4 --conf spark.executor.memory=4g
   ```

1. In the next cell, run your computations:

   ```python
   #!spark --cluster my-new-cluster --session ses1
   import random

   def inside(p):
       x, y = random.random(), random.random()
       return x*x + y*y < 1

   NUM_SAMPLES = 1_000_000

   count = sc.parallelize(range(0, NUM_SAMPLES)) \
       .filter(inside).count()
   print("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))
   ```

1. If you no longer need the session, delete it:

   ```python
   %delete_livy_session --cluster my-new-cluster --id ses1
   ```

### Working with the Spark SQL library {#sql}

{{ ml-platform-name }} supports using the Spark SQL library. For example, the query below will return all records in the `animals` table created in `cluster test-dataproc-cluster`:

```python
#!spark --cluster test-dataproc-cluster --return_variables df
df = spark.sql("SELECT * FROM animals;")
```

```python
df
```

For more information about the SQL query syntax and how to use the Spark SQL library, see the [official documentation](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select.html).

## See also {#see-also}

* [{#T}](../tutorials/data-proc-integration.md)
* [{#T}](spark-connector.md)
