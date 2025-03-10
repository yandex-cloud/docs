---
title: How to work with Spark connectors from {{ ds-jobs }}
description: In this article, you will learn how to work with Spark connectors from {{ ds-jobs }}.
---

# Working with Spark connectors

Integrating {{ ds-jobs }} with [{{ dataproc-full-name }}](../../../data-proc/) through [Spark connectors](../spark-connector.md) is different from the standard way of how jobs work. {{ dataproc-name }} clusters have strict environment requirements, which implies the following restrictions for jobs:

* You cannot update a Docker image for a job that uses a Spark connector. Trying to specify a new image will lead to an error.
* The [Python environment](environment.md) for {{ ds-jobs }} must be consistent with your {{ dataproc-name }} cluster [environment](../../../data-proc/concepts/environment.md#current-images), i.e., the versions of Python and its main libraries must be the same. To work with {{ dataproc-name }} using jobs, we recommend [setting up your environment manually](environment.md#manual).
* For a job to run correctly, you may need additional packages. The required packages and their versions depend on the {{ dataproc-name }} cluster version. You can find information on additional packages in the job [log](cli.md#logs).
* To connect to a {{ dataproc-name }} cluster from a job, you need to use the {{ ml-platform-name }} SDK from the `datasphere` Python package.

{% note warning %}

Jobs do not support operations with [temporary clusters](../temporary-data-processing-clusters.md).

{% endnote %}

## Setting up a job {#settings}

To work with Spark connectors, add a field with the connector ID to the job [configuration file](index.md#config).

```yaml
spark:
  connector: <connector_ID>
```

Make sure the Spark connector is [available](../../operations/data/spark-connectors.md#share) in your project.

{% note warning %}

To work with Spark connectors in {{ ds-jobs }}, you need the [{{ ds-cli }}](cli.md) version `0.10.0` or higher.

{% endnote %}

## Connecting to a {{ dataproc-name }} cluster from the job code {#connect}

To connect to a {{ dataproc-name }} cluster from a job, you need the {{ ml-platform-name }} SDK from the `datasphere` Python package. Specify the `datasphere` package in `requirements.txt` and connect to the cluster in the code.

```python
from datasphere.sdk import SDK

sdk = SDK()

spark_wrapper = sdk.connect_to_spark()  # Configures and creates a {{ dataproc-name }} cluster connect session

spark_session = spark_wrapper.spark # Spark session
spark_context = spark_wrapper.sc # Spark context

# You can then use `spark_session` and `spark_context` in the same way as with `pyspark`
```

### Debugging a job locally {#debug}

When working with {{ dataproc-name }} clusters in the {{ ml-platform-name }} SDK, you can create a [local PySpark session](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.SparkSession.builder.master.html) at the time of calling `sdk.connect_to_spark()`.

To start a local session, create a `.spark_local_config.json` file in the job directory (or provide the path to the file in the `JOB_DATAPROC_CONNECTION_CONFIG` environment variable) and specify the following parameters in the file:

```json
{
    "master_node_host": "localhost",
    "connection_mode": "SPARK_LOCAL", // Required for local debugging
    "session_params": {} // PySpark session parameters
}
```

### Example of a job with a connection to a {{ dataproc-name }} cluster {#example}

1. Create the `config.yaml` job configuration file:

   ```yaml
   name: job-spark-connector-example
   cmd: python main.py
   env:
     python:
       type: manual
       version: 3.8
       requirements-file: requirements.txt
   spark:
     connector: <connector_ID>
   ```

1. Create the `requirements.txt` file with environment parameters:

   ```python   
   datasphere==0.10.0
   ```

1. Create the `main.py` job entry point file:

   ```python
   import random
   from datasphere.sdk import SDK
   
   sdk = SDK()
   
   spark_wrapper = sdk.connect_to_spark()
   spark_context = spark_wrapper.sc
   
   NUM_SAMPLES = 10_000_000
   
   def inside(*args, **kwargs):
       x, y = random.random(), random.random()
       return x * x + y * y < 1
   
   count = spark_context.parallelize(range(0, NUM_SAMPLES)).filter(inside).count()
   print("Pi:", 4.0 * count / NUM_SAMPLES)
   ```
